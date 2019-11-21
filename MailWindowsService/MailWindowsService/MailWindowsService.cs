using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;
using System.Collections.Generic;
using System.Linq;
using System.ServiceProcess;
using ImapX;
using System.Threading;
using System.Text.RegularExpressions;

namespace MailWindowsService
{
    public partial class MailWindowsService : ServiceBase
    {
        static ImapClient client = new ImapClient("imap.gmail.com", 993, true, false);
        public static object LockVar = new object();
        System.Timers.Timer timerTicket = new System.Timers.Timer();

        public MailWindowsService()
        {
            InitializeComponent();
            GC.KeepAlive(client); // necessary for long running process, otherwise GC will dispose it
        }

        protected override void OnStart(string[] args)
        {
            Thread.Sleep(20000);
            timerTicket.Elapsed += new System.Timers.ElapsedEventHandler(ManageTicket);
            //This statement is used to set interval to 20 secs (= 20,000 milliseconds)
            timerTicket.Interval = 200000;
            timerTicket.Enabled = true;
        }

        private void ManageTicket(object sender, System.Timers.ElapsedEventArgs e)
        {
            if (client.Connect())
            {
                System.Diagnostics.Trace.WriteLine("Client Connected");
                if (client.Login("helpdeskcts6716@gmail.com", "AP_5@ukH"))
                {
                    System.Diagnostics.Trace.WriteLine("Client Login");
                    client.Behavior.MessageFetchMode = ImapX.Enums.MessageFetchMode.Full;
                    ProcessMail();
                    client.Disconnect();
                }
            }
            else
            {
                System.Diagnostics.Trace.WriteLine("Client connection failed");
            }
        }

        private void ProcessMail()
        {
            try
            {
                System.Diagnostics.Trace.WriteLine("Lock Acquired");
                var lstMails = client.Folders.Inbox.Search("UNSEEN");
                if (lstMails != null && lstMails.Count() > 0)
                {
                    List<Message> lstUnreadMsg = lstMails.ToList();
                    System.Diagnostics.Trace.WriteLine("Unread Message #" + lstUnreadMsg.Count.ToString());
                    foreach (Message UnReadMsg in lstUnreadMsg)
                    {
                        TicketEntities ticketdbcontext = new TicketEntities();
                        
                        String emailid = UnReadMsg.From.ToString();
                        String subject = UnReadMsg.Subject.ToString();
                        string subtrim = subject;
                        Regex subregex = new Regex("TicketID:");
                        if (subregex.IsMatch(subtrim) == true)
                        {
                            subtrim = subtrim.Remove(0, subregex.Match(subtrim).Index + 9);
                            subregex = new Regex(" ;");
                            if (subregex.IsMatch(subtrim) == true)
                            {
                                subtrim = subtrim.Remove(subregex.Match(subtrim).Index);
                            }
                            else
                            {
                                subtrim = subject;
                            }
                        }
                        else
                        {
                            subtrim = subject;
                        }
                        int id = 0;
                        if (Int32.TryParse(subtrim, out id) == true)
                        {
                            id = Int32.Parse(subtrim);
                        }
                        else
                        {
                            id = 0;
                        }
                        
                        Ticket_Master decidemethod = ticketdbcontext.Ticket_Master.FirstOrDefault(x => x.TicketID == id && x.Email == emailid);
                        if (decidemethod != null)
                        {
                            Ticket_Activity ticketactivity = new Ticket_Activity();
                            if (decidemethod != null)
                            {
                                //Ticket already exist                                                    
                                ticketactivity.ActivityType = "Customer Reply";
                                IEnumerable<Ticket_Activity> matchdescription = (from r in ticketdbcontext.Ticket_Activity
                                                                                where r.TicketID == decidemethod.TicketID
                                                                                select r).ToList();
                                string mailbody;
                                if (UnReadMsg.Body.HasHtml)
                                    mailbody = UnReadMsg.Body.Html;
                                else
                                    mailbody = UnReadMsg.Body.Text;
                                ticketactivity.Description = mailbody;
                                ticketactivity.ActivityDate = DateTime.Now;
                                ticketactivity.ActorName = "End User";
                                ticketactivity.Unread = true;
                                decidemethod.Ticket_Activity.Add(ticketactivity);
                                /*if (UnReadMsg.Attachments.Length > 0)
                                {
                                    Attachment[] Attachments = UnReadMsg.Attachments;
                                    foreach (Attachment item in Attachments)
                                    {
                                        byte[] result = item.FileData;
                                        TicketAttachment ticketattachment = new TicketAttachment();
                                        ticketattachment.ID = Guid.NewGuid();
                                        ticketattachment.FileName = item.FileName;
                                        ticketattachment.Attachment = result;
                                        ticketattachment.ActivityID = ticketactivity.ActivityID;
                                        ticketactivity.TicketAttachment.Add(ticketattachment);
                                    }
                                }*/
                                ticketdbcontext.SaveChanges();
                            }
                        }
                        else
                        {
                            //Create a new Ticket
                            Ticket_Master ticketmaster = new Ticket_Master();
                            Ticket_Activity ticketactivity = new Ticket_Activity();
                            ticketmaster.Email = UnReadMsg.From.ToString();
                            ticketmaster.CreationDate = DateTime.Now;
                            ticketmaster.TicketSource = "Email";
                            ticketmaster.Subject = UnReadMsg.Subject.ToString();
                            ticketmaster.TicketStatus = "Open";
                            ticketmaster.Priority = 1;
                            ticketmaster.IsDeleted = false;
                            ticketdbcontext.Ticket_Master.Add(ticketmaster);
                            ticketdbcontext.SaveChanges();

                            ticketactivity.ActivityType = "Created";
                            ticketactivity.Summary = UnReadMsg.Subject.ToString();
                            if (UnReadMsg.Body.HasHtml)
                                ticketactivity.Description = UnReadMsg.Body.Html;
                            else
                                ticketactivity.Description = UnReadMsg.Body.Text;
                            ticketactivity.ActivityDate = DateTime.Now;
                            ticketactivity.ActorName = "End User";
                            ticketactivity.Unread = true;
                            ticketmaster.Ticket_Activity.Add(ticketactivity);

                            List<MailAddress> Collaborator = UnReadMsg.Cc.ToList();
                            int CollabCount = Collaborator.Count();
                            for (int i = 0; i < CollabCount; i++)
                            {
                                Ticket_Collaborator ticketcollaborator = new Ticket_Collaborator();
                                ticketcollaborator.Email = Collaborator.ElementAt(i).ToString();
                                ticketcollaborator.FieldType = "Cc";
                                ticketmaster.Ticket_Collaborator.Add(ticketcollaborator);

                                Ticket_Activity ticketcollaboratoractivity = new Ticket_Activity();
                                ticketcollaboratoractivity.ActivityType = "Collaborator Added";
                                ticketcollaboratoractivity.Description = "EmailID: " + Collaborator.ElementAt(i).ToString() + " ; FieldType: Cc";
                                ticketcollaboratoractivity.ActivityDate = DateTime.Now;
                                ticketcollaboratoractivity.ActorName = "End User";
                                ticketcollaboratoractivity.Unread = true;
                                ticketmaster.Ticket_Activity.Add(ticketcollaboratoractivity);
                            }

                            /*if (UnReadMsg.Attachments.Length > 0)
                            {
                                Attachment[] Attachments = UnReadMsg.Attachments;
                                foreach (Attachment item in Attachments)
                                {
                                    byte[] result = item.FileData;
                                    TicketAttachment ticketattachment = new TicketAttachment();
                                    ticketattachment.ID = Guid.NewGuid();
                                    ticketattachment.FileName = item.FileName;
                                    ticketattachment.Attachment = result;
                                    ticketattachment.ActivityID = ticketactivity.ActivityID;
                                    ticketactivity.TicketAttachment.Add(ticketattachment);
                                }
                            }*/
                            ticketdbcontext.SaveChanges();
                        }
                        UnReadMsg.Seen = true;
                    }
                }
            }

            catch (Exception ex)
            {
                System.Diagnostics.Trace.TraceError("\r\nMessage: {0}\r\nStrackTrace: {1}", ex.Message, ex.StackTrace);
            }
        }
        private string GetPlainTextFromHtml(string htmlString)
        {
            string htmlTagPattern = "<.*?>";
            var regexCss = new Regex("(\\<script(.+?)\\</script\\>)|(\\<style(.+?)\\</style\\>)", RegexOptions.Singleline | RegexOptions.IgnoreCase);
            htmlString = regexCss.Replace(htmlString, string.Empty);
            htmlString = Regex.Replace(htmlString, htmlTagPattern, string.Empty);
            htmlString = Regex.Replace(htmlString, @"^\s+$[\r\n]*", "", RegexOptions.Multiline);
            htmlString = htmlString.Replace("&nbsp;", string.Empty);
            return htmlString;
        }

        protected override void OnStop()
        {
            timerTicket.Enabled = false;
        }
    }
}

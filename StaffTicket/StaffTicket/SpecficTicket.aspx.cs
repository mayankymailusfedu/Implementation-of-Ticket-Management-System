using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;

public partial class SpecficTicket : System.Web.UI.Page
{
    private TicketEntities te = new TicketEntities();
    /* Module Name: Page_Load;
    * Student: Mayank Yadav
    * Modification Date: 23-April-2018
    * Description: This method is exceute first before page loads. The page contains a list view.
    * Input/Outputs: Populate the listv view
    * Globals: No global changes.
    */
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!Page.IsPostBack)
        {
            FillDate();
        }

    }

    /* Module Name: FillDate;
    * Student: Mayank Yadav
    * Modification Date: 23-April-2018
    * Description: This method is exceuted to populate the list view and all other labels (details) related to the particular Ticket
    * Input/Outputs: Populate the listv view and labels
    * Globals: No global changes.
    */
    private void FillDate()
    {
        string ticket = Session["TicketID"].ToString();
        int ticketid = Int32.Parse(ticket);
        var result = te.Ticket_Activity.
            Where(x=>x.TicketID.Equals(ticketid)).
            Select
            (x => new {
                ActivityType = x.ActivityType,
                ActivityDate = x.ActivityDate,
                ActedBy = x.ActedBy,
                ActorName = x.ActorName,
                Summary = x.Summary,
                Description = x.Description
            }).ToList();
        ListView1.DataSource = result;
        ListView1.DataBind();
        Ticket_Master result2 = te.Ticket_Master.FirstOrDefault(x => x.TicketID.Equals(ticketid));
        TicketLabel.Text = result2.TicketID.ToString();
        NameLabel.Text = result2.FullName;
        EmailLabel.Text = result2.Email;
        AssignLabel.Text = result2.AssignTo.ToString();
        CreationLabel.Text = result2.CreationDate.ToString();
        ClosingLabel.Text = result2.ClosedDate.ToString();
        SourceLabel.Text = result2.TicketSource;
        CategoryLabel.Text = result2.Category;
        PriorityLabel.Text = result2.Priority.ToString();
        Labelts.Text = result2.TicketStatus;
        SubjectLabel.Text = result2.Subject;

    }

    /* Module Name: LinkButton4_Click;
    * Student: Mayank Yadav
    * Modification Date: 23-April-2018
    * Description: Loads the Staff Dashboard
    * Input/Outputs: Redirect the Staff Dashboard
    * Globals: No global changes.
    */
    protected void LinkButton4_Click(object sender, EventArgs e)//Dashboard
    {
        Response.Redirect("StaffDashboard.aspx");
    }

    /* Module Name: ButtonDashboard_Click;
    * Student: Mayank Yadav
    * Modification Date: 23-April-2018
    * Description: Loads the Staff Dashboard
    * Input/Outputs: Redirect the Staff Dashboard
    * Globals: No global changes.
    */
    protected void ButtonDashboard_Click(object sender, EventArgs e)
    {
        Response.Redirect("StaffDashboard.aspx");
    }

    /* Module Name: ButtonAssign_Click;
    * Student: Mayank Yadav
    * Modification Date: 23-April-2018
    * Description: Assign ticket to yourself or the staff who is logged in
    * Input/Outputs: The ticket id and staff username
    * Globals: No global changes.
    */
    protected void ButtonAssign_Click(object sender, EventArgs e)
    {
        string ticket = Session["TicketID"].ToString();
        int ticketid = Int32.Parse(ticket);
        string username = Session["StaffUser"].ToString();
        Console.WriteLine("Username: " + username);
        if (username != null)
        {
            IEnumerable<int> staff = from st in te.Staffs
                                     where st.Username.Equals(username)
                                     select st.Staff_ID;
            List<int> factorsofFourList = staff.ToList();
            if (factorsofFourList.Count != 0)
            {
                Console.WriteLine("Staff: " + factorsofFourList[0]);
                int staffid = factorsofFourList[0];
                Ticket_Activity ta = new Ticket_Activity()
                {
                    TicketID = ticketid,
                    ActivityType = "Assigned To",
                    Summary = "Ticket Assigned To Staff",
                    Description = "Your ticket has been assigned to " + username + " (" + staffid + ")",
                    ActivityDate = DateTime.Now,
                    ActedBy = staffid,
                    ActorName = username,
                    Unread = false
                };


                te.Ticket_Activity.Add(ta);

                var query =
                    from tic in te.Ticket_Master
                    where tic.TicketID == ticketid
                    select tic;
                foreach (Ticket_Master ord in query)
                {
                    ord.AssignTo = staffid;
                }
                bool saveFailed;
                do
                {
                    saveFailed = false;
                    try
                    {
                        te.SaveChanges();
                    }
                    catch (Exception ex)
                    {
                        saveFailed = true;
                        Response.Redirect(Request.RawUrl);
                    }

                } while (saveFailed);
                Response.Redirect(Request.RawUrl);
            }


        }
    }

    /* Module Name: ButtonDelete_Click;
    * Student: Mayank Yadav
    * Modification Date: 23-April-2018
    * Description: Delete the ticket. The is_deleted field in Ticket_Master is updates to true.
    *               The Ticket is not deleted from the database, so that in future if we need to conduct an inspection
    *               we can inspected every ticket
    * Input/Outputs: The ticket id and staff username
    * Globals: No global changes.
    */
    protected void ButtonDelete_Click(object sender, EventArgs e)
    {
        string ticket = Session["TicketID"].ToString();
        int ticketid = Int32.Parse(ticket);
        string username = Session["StaffUser"].ToString();
        Console.WriteLine("Username: " + username);
        if (username != null)
        {
            IEnumerable<int> staff = from st in te.Staffs
                                     where st.Username.Equals(username)
                                     select st.Staff_ID;
            List<int> factorsofFourList = staff.ToList();
            if (factorsofFourList.Count != 0)
            {
                Console.WriteLine("Staff: " + factorsofFourList[0]);
                int staffid = factorsofFourList[0];
                Ticket_Activity ta = new Ticket_Activity()
                {
                    TicketID = ticketid,
                    ActivityType = "Deleted",
                    Summary = "Ticket has been Deleted",
                    Description = "Your ticket has been Deleted " + username + " (" + staffid + ")",
                    ActivityDate = DateTime.Now,
                    ActedBy = staffid,
                    ActorName = username,
                    Unread = false
                };


                te.Ticket_Activity.Add(ta);

                var query =
                    from tic in te.Ticket_Master
                    where tic.TicketID == ticketid
                    select tic;
                foreach (Ticket_Master ord in query)
                {
                    ord.IsDeleted = true;
                }
                bool saveFailed;
                do
                {
                    saveFailed = false;
                    try
                    {
                        te.SaveChanges();
                    }
                    catch (Exception ex)
                    {
                        saveFailed = true;
                        Response.Redirect(Request.RawUrl);
                    }

                } while (saveFailed);
                Response.Redirect(Request.RawUrl);
            }

        }
    }

    /* Module Name: ButtonBlock_Click;
    * Student: Mayank Yadav
    * Modification Date: 23-April-2018
    * Description: Add the Client to Blocklist
    * Input/Outputs: The ticket id and staff username
    * Globals: No global changes.
    */
    protected void ButtonBlock_Click(object sender, EventArgs e)
    {
        string ticket = Session["TicketID"].ToString();
        int ticketid = Int32.Parse(ticket);
        IEnumerable<string> ticketmaster = from st in te.Ticket_Master
                                 where st.TicketID.Equals(ticketid)
                                 select st.Email;
        List<string> factorsofFourList = ticketmaster.ToList();
        if (factorsofFourList.Count != 0)
        {
            Console.WriteLine("Staff: " + factorsofFourList[0]);
            string ticketemail = factorsofFourList[0];
            string username = Session["StaffUser"].ToString();
            Console.WriteLine("Username: " + username);
            if (username != null)
            {
                TicketEntities te = new TicketEntities();
                string E_mail = ticketemail;

                BlockList b = new BlockList()
                {
                    Email = E_mail,
                };


                try
                {
                    te.BlockLists.Add(b);
                    te.SaveChanges();
                    Response.Redirect(Request.RawUrl);
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.ToString());
                }
            }
            else
            {
                Response.Redirect(Request.RawUrl);
            }
        }
    }

    /* Module Name: ctsLinkButton_Click;
    * Student: Mayank Yadav
    * Modification Date: 23-April-2018
    * Description: Change the Ticket Status or update the ticket status in Ticket_Master and also insert an activity on the same
    *               If the ticket status contains "close" then also update the Closed by and Closed Date in Ticket_Master
    * Input/Outputs: The ticket id and staff username
    * Globals: No global changes.
    */
    protected void ctsLinkButton_Click(object sender, EventArgs e)
    {
        string ticket = Session["TicketID"].ToString();
        int ticketid = Int32.Parse(ticket);
        string username = Session["StaffUser"].ToString();
        Console.WriteLine("Username: " + username);
        if (username != null)
        {
            IEnumerable<int> staff = from st in te.Staffs
                                     where st.Username.Equals(username)
                                     select st.Staff_ID;
            List<int> factorsofFourList = staff.ToList();
            string ts = ctsTextBox1.Text;
            if (factorsofFourList.Count != 0 && ts != null)
            {
                Console.WriteLine("Staff: " + factorsofFourList[0]);
                int staffid = factorsofFourList[0];
                Ticket_Activity ta = new Ticket_Activity()
                {
                    TicketID = ticketid,
                    ActivityType = "Ticket Status",
                    Summary = "Ticket Status has been chnaged",
                    Description = "Your ticket status has been changed to " + ts + " by " + username + " (" + staffid + ")",
                    ActivityDate = DateTime.Now,
                    ActedBy = staffid,
                    ActorName = username,
                    Unread = false
                };


                te.Ticket_Activity.Add(ta);

                var query =
                    from tic in te.Ticket_Master
                    where tic.TicketID == ticketid
                    select tic;
                foreach (Ticket_Master ord in query)
                {
                    ord.TicketStatus = ts;
                }
                bool saveFailed;
                do
                {
                    saveFailed = false;
                    try
                    {
                        te.SaveChanges();
                    }
                    catch (Exception ex)
                    {
                        saveFailed = true;
                        Response.Redirect(Request.RawUrl);
                    }

                } while (saveFailed);
                Response.Redirect(Request.RawUrl);

                if (ts.Contains("close"))
                {
                    TicketEntities te2 = new TicketEntities();
                    var query2 =
                        from tic in te2.Ticket_Master
                        where tic.TicketID == ticketid
                        select tic;
                    foreach (Ticket_Master ord in query)
                    {
                        ord.ClosedDate = DateTime.Now;
                        ord.ClosedBy = staffid;
                    }
                    bool saveFailed2;
                    do
                    {
                        saveFailed2 = false;
                        try
                        {
                            te2.SaveChanges();
                        }
                        catch (Exception ex)
                        {
                            saveFailed2 = true;
                            Response.Redirect(Request.RawUrl);
                        }

                    } while (saveFailed2);
                    Response.Redirect(Request.RawUrl);
                }


            }

        }
    }

    /* Module Name: cpLinkButton_Click;
    * Student: Mayank Yadav
    * Modification Date: 23-April-2018
    * Description: Change the Ticket Priority or update the ticket priority in Ticket_Master and also insert an activity of the same
    * Input/Outputs: The ticket id and staff username
    * Globals: No global changes.
    */
    protected void cpLinkButton_Click(object sender, EventArgs e)
    {
        string ticket = Session["TicketID"].ToString();
        int ticketid = Int32.Parse(ticket);
        string username = Session["StaffUser"].ToString();
        Console.WriteLine("Username: " + username);
        if (username != null)
        {
            IEnumerable<int> staff = from st in te.Staffs
                                     where st.Username.Equals(username)
                                     select st.Staff_ID;
            List<int> factorsofFourList = staff.ToList();
            int pr=0;
            string prtext = cpTextBox2.Text;
            bool re = Int32.TryParse(prtext, out pr);
            if (factorsofFourList.Count != 0 && pr !=0  && prtext != null && re == true)
            {
                Console.WriteLine("Staff: " + factorsofFourList[0]);
                int staffid = factorsofFourList[0];
                Ticket_Activity ta = new Ticket_Activity()
                {
                    TicketID = ticketid,
                    ActivityType = "Priority",
                    Summary = "Priority Changed",
                    Description = "Your ticket priority has been chnages to "+ pr + " by "+ username + " (" + staffid + ")",
                    ActivityDate = DateTime.Now,
                    ActedBy = staffid,
                    ActorName = username,
                    Unread = false
                };


                te.Ticket_Activity.Add(ta);

                byte[] Byte_prior = BitConverter.GetBytes(pr);
                byte Single_byte = Byte_prior[0];
                var query =
                    from tic in te.Ticket_Master
                    where tic.TicketID == ticketid
                    select tic;
                foreach (Ticket_Master ord in query)
                {
                    ord.Priority = Single_byte;
                }
                bool saveFailed;
                do
                {
                    saveFailed = false;
                    try
                    {
                        te.SaveChanges();
                    }
                    catch (Exception ex)
                    {
                        saveFailed = true;
                        Response.Redirect(Request.RawUrl);
                    }

                } while (saveFailed);
                Response.Redirect(Request.RawUrl);
            }


        }
    }

    /* Module Name: submit_Click;
    * Student: Mayank Yadav
    * Modification Date: 23-April-2018
    * Description: Post a reply on particular ticket, insert an activity of the same and send an email about the reply to the client
    * Input/Outputs: The ticket id and staff username
    * Globals: No global changes.
    */
    protected void submit_Click(object sender, EventArgs e)
    {
        string Descript_ion = Request.Form["TextArea1"].ToString();
        string ticket = Session["TicketID"].ToString();
        int ticketid = Int32.Parse(ticket);
        string username = Session["StaffUser"].ToString();
        Console.WriteLine("Username: " + username);
        if (username != null && Descript_ion !=null)
        {
            IEnumerable<int> staff = from st in te.Staffs
                                     where st.Username.Equals(username)
                                     select st.Staff_ID;
            List<int> factorsofFourList = staff.ToList();;
            if (factorsofFourList.Count != 0)
            {
                Console.WriteLine("Staff: " + factorsofFourList[0]);
                int staffid = factorsofFourList[0];
                Ticket_Activity ta = new Ticket_Activity()
                {
                    TicketID = ticketid,
                    ActivityType = "Post Reply",
                    Summary = "Reply posted by Staff",
                    Description = Descript_ion,
                    ActivityDate = DateTime.Now,
                    ActedBy = staffid,
                    ActorName = username,
                    Unread = false
                };


                te.Ticket_Activity.Add(ta);
                bool saveFailed;
                do
                {
                    saveFailed = false;
                    try
                    {
                        te.SaveChanges();
                    }
                    catch (Exception ex)
                    {
                        saveFailed = true;
                        Response.Redirect(Request.RawUrl);
                    }

                } while (saveFailed);
                               
                TicketEntities sme = new TicketEntities();
                Ticket_Master sm = sme.Ticket_Master.FirstOrDefault(x => x.TicketID.Equals(ticketid));
                MailMessage mail = new MailMessage("helpdeskcts6716@gmail.com", sm.Email);
                SmtpClient client = new SmtpClient();
                client.EnableSsl = true;
                client.Port = 25;
                client.DeliveryMethod = SmtpDeliveryMethod.Network;
                client.UseDefaultCredentials = true;
                client.Credentials = new System.Net.NetworkCredential("helpdeskcts6716@gmail.com", "AP_5@ukH");
                client.Host = "smtp.gmail.com";
                mail.Subject = "TicketID:" + sm.TicketID + " ; " + sm.Subject;
                mail.Body = Descript_ion;
                var query =
                    from tic in sme.Ticket_Collaborator
                    where tic.TicketID == ticketid
                    select tic; 
                foreach (Ticket_Collaborator ord in query)
                {
                    mail.CC.Add(ord.Email);
                }

                client.Send(mail);
                Response.Redirect(Request.RawUrl);
            }
            Response.Redirect(Request.RawUrl);

        }
    }
}
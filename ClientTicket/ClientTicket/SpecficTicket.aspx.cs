using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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

    /* Module Name: LinkButton4_Click;
    * Student: Mayank Yadav
    * Modification Date: 23-April-2018
    * Description: Loads the Client Dashboard
    * Input/Outputs: Redirect the Client Dashboard
    * Globals: No global changes.
    */
    protected void ButtonDashboard_Click(object sender, EventArgs e)
    {
        Response.Redirect("ClientDashboard.aspx");
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
            Where(x => x.TicketID.Equals(ticketid)).
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

    /* Module Name: ButtonDelete_Click;
    * Student: Mayank Yadav
    * Modification Date: 23-April-2018
    * Description: Delete the ticket. The is_deleted field in Ticket_Master is updates to true.
    *               The Ticket is not deleted from the database, so that in future if we need to conduct an inspection
    *               we can inspected every ticket
    * Input/Outputs: The ticket id and client username
    * Globals: No global changes.
    */
    protected void ButtonDelete_Click(object sender, EventArgs e)
    {
        string ticket = Session["TicketID"].ToString();
        int ticketid = Int32.Parse(ticket);
        string username = Session["ClientUser"].ToString();
        Console.WriteLine("Username: " + username);
        if (username != null)
        {
            var client = (from cl in te.Clients
                          where cl.Email.Equals(username)
                          select new
                          {
                              cl.Email,
                              cl.FullName,
                              cl.Client_ID
                          }).First();
            string E_mail = client.Email.ToString();
            string Full_name = client.FullName.ToString();
            int clientid = int.Parse(client.Client_ID.ToString());
            if (E_mail != null)
            {
                Ticket_Activity ta = new Ticket_Activity()
                {
                    TicketID = ticketid,
                    ActivityType = "Deleted",
                    Summary = "Ticket has been Deleted",
                    Description = "Your ticket has been Deleted by the end user" + username + " (" +  clientid + ")",
                    ActivityDate = DateTime.Now,
                    ActedBy = clientid,
                    ActorName = "End User",
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

    /* Module Name: submit_Click;
    * Student: Mayank Yadav
    * Modification Date: 23-April-2018
    * Description: Post a reply on particular ticket, insert an activity of the same
    * Input/Outputs: The ticket id and client username
    * Globals: No global changes.
    */
    protected void submit_Click(object sender, EventArgs e)
    {
        string Descript_ion = Request.Form["TextArea1"].ToString();
        string ticket = Session["TicketID"].ToString();
        int ticketid = Int32.Parse(ticket);
        string username = Session["ClientUser"].ToString();
        Console.WriteLine("Username: " + username);
        if (username != null && Descript_ion != null)
        {
            var client = (from cl in te.Clients
                          where cl.Email.Equals(username)
                          select new
                          {
                              cl.Email,
                              cl.FullName,
                              cl.Client_ID
                          }).First();
            string E_mail = client.Email.ToString();
            string Full_name = client.FullName.ToString();
            int clientid = int.Parse(client.Client_ID.ToString());
            if (E_mail != null)
            {
                Ticket_Activity ta = new Ticket_Activity()
                {
                    TicketID = ticketid,
                    ActivityType = "Post Reply",
                    Summary = "Reply posted by Staff",
                    Description = Descript_ion,
                    ActivityDate = DateTime.Now,
                    ActedBy = clientid,
                    ActorName = "End User",
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
                Response.Redirect(Request.RawUrl);
            }
        }
    }
}
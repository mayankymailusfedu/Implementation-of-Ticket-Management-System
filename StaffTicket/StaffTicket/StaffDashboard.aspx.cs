using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class StaffDashboard : System.Web.UI.Page
{
    private TicketEntities te = new TicketEntities();

    /* Module Name: Page_Load;
    * Student: Mayank Yadav
    * Modification Date: 23-April-2018
    * Description: Loads the grid view with the tickets
    * Input/Outputs: Checks staff username
    * Globals: No global changes.
    */
    protected void Page_Load(object sender, EventArgs e)
    {
        string username = Session["StaffUser"].ToString();
        if (!Page.IsPostBack && username != null)
        {
            FillDate();
        }

    }

    /* Module Name: FillDate;
    * Student: Mayank Yadav
    * Modification Date: 23-April-2018
    * Description: Loads the grid view with the tickets
    * Input/Outputs: Checks staff username
    * Globals: No global changes.
    */
    private void FillDate()
    {
        this.GridView2.DataSource = (from tm in te.Ticket_Master
                                     join st in te.Staffs
                                     on tm.AssignTo equals st.Staff_ID
                                     into t
                                     from rt in t.DefaultIfEmpty()
                                     where tm.IsDeleted.Equals(false)
                                     orderby tm.CreationDate descending, tm.Priority

                                     select new
                                     {
                                         ticketid = tm.TicketID,
                                         email = tm.Email,
                                         subject = tm.Subject,
                                         creationdate = tm.CreationDate,
                                         assignto = rt.Username,
                                         ticketstatus = tm.TicketStatus,
                                         priority = tm.Priority
                                     }).ToList();

        this.GridView2.DataBind();
    }

    protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    /* Module Name: LinkButtonSelect_Click;
    * Student: Mayank Yadav
    * Modification Date: 23-April-2018
    * Description: Loads all the details related to a ticket
    * Input/Outputs: Checks staff username and ticket id
    * Globals: No global changes.
    */
    protected void LinkButtonSelect_Click(object sender, EventArgs e)
    {
        LinkButton lb = (LinkButton)sender;
        HiddenField hd = (HiddenField)lb.FindControl("HiddenFieldTicketID");

        Console.WriteLine(hd.Value);

        Session["TicketID"] = hd.Value;
        Server.Transfer("SpecficTicket.aspx", true);
    }

    /* Module Name: LinkButton1_Click;
    * Student: Mayank Yadav
    * Modification Date: 23-April-2018
    * Description: Redirect to Staff Dashboard
    * Input/Outputs: Checks staff username
    * Globals: No global changes.
    */
    protected void LinkButton1_Click(object sender, EventArgs e)//Show All
    {
        string username = Session["StaffUser"].ToString();
        if (username != null)
            FillDate();
    }

    /* Module Name: LinkButton2_Click;
    * Student: Mayank Yadav
    * Modification Date: 23-April-2018
    * Description: Redirect to Staff Dashboard but show only tickets asigned to logged in staff
    * Input/Outputs: Checks staff username
    * Globals: No global changes.
    */
    protected void LinkButton2_Click(object sender, EventArgs e)//My Ticket
    {
        string username = Session["StaffUser"].ToString();
        if (username != null)
        {
            this.GridView2.DataSource = (from tm in te.Ticket_Master
                                         join st in te.Staffs
                                         on tm.AssignTo equals st.Staff_ID
                                         into t
                                         from rt in t.DefaultIfEmpty()
                                         orderby tm.CreationDate descending, tm.Priority
                                         where rt.Username.Equals(username)
                                         select new
                                         {
                                             ticketid = tm.TicketID,
                                             email = tm.Email,
                                             subject = tm.Subject,
                                             creationdate = tm.CreationDate,
                                             assignto = rt.Username,
                                             ticketstatus = tm.TicketStatus,
                                             priority = tm.Priority
                                         }).ToList();

            this.GridView2.DataBind();
        }
    }

    /* Module Name: LinkButton3_Click;
    * Student: Mayank Yadav
    * Modification Date: 23-April-2018
    * Description: Create a Ticket and insert the record in Ticket_Master
    * Input/Outputs: Checks staff username
    * Globals: No global changes.
    */
    protected void LinkButton3_Click(object sender, EventArgs e)//CreateTicket
    {
        string username = Session["StaffUser"].ToString();
        if (username != null)
        {
            Server.Transfer("CreateTicket.aspx", true);
        }
    }

    /* Module Name: LinkButton5_Click;
    * Student: Mayank Yadav
    * Modification Date: 23-April-2018
    * Description: Redirect to Blocklist
    * Input/Outputs: No input
    * Globals: No global changes.
    */
    protected void LinkButton5_Click(object sender, EventArgs e)//Blocklist
    {
        Server.Transfer("Blocklist.aspx", true);
    }

    /* Module Name: LinkButton4_Click;
    * Student: Mayank Yadav
    * Modification Date: 23-April-2018
    * Description: Logout or destroy the session of the staff username
    * Input/Outputs: No input
    * Globals: No global changes.
    */
    protected void LinkButton4_Click(object sender, EventArgs e)//Logout
    {
        Session["StaffUser"] = null;
        Server.Transfer("StaffLogin.aspx", true);
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ClientDashboard : System.Web.UI.Page
{
    private TicketEntities te = new TicketEntities();
    /* Module Name: Page_Load;
   * Student: Mayank Yadav
   * Modification Date: 23-April-2018
   * Description: Loads the grid view with the clients tickets
   * Input/Outputs: Checks client username
   * Globals: No global changes.
   */
    protected void Page_Load(object sender, EventArgs e)
    {
        string username = Session["ClientUser"].ToString();
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
        string username = Session["ClientUser"].ToString();
        this.GridView2.DataSource = (from tm in te.Ticket_Master
                                     join st in te.Staffs
                                     on tm.AssignTo equals st.Staff_ID
                                     into t
                                     from rt in t.DefaultIfEmpty()
                                     where tm.IsDeleted.Equals(false) &&
                                            tm.Email.Equals(username)
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
   * Description: Redirect to Login Dashboard
   * Input/Outputs: Checks staff username
   * Globals: No global changes.
   */
    protected void LinkButton1_Click(object sender, EventArgs e)//Show All
    {
        string username = Session["ClientUser"].ToString();
        if (username != null)
            FillDate();
    }

    /* Module Name: LinkButton3_Click;
    * Student: Mayank Yadav
    * Modification Date: 23-April-2018
    * Description: Create a Ticket and insert the record in Ticket_Master
    * Input/Outputs: Checks client username
    * Globals: No global changes.
    */
    protected void LinkButton3_Click(object sender, EventArgs e)//Create Ticket
    {
        string username = Session["ClientUser"].ToString();
        if (username != null)
        {
            Server.Transfer("CreateTicket.aspx", true);
        }
    }

    /* Module Name: LinkButton4_Click;
   * Student: Mayank Yadav
   * Modification Date: 23-April-2018
   * Description: Logout or destroy the session of the client username
   * Input/Outputs: No input
   * Globals: No global changes.
   */
    protected void LinkButton4_Click(object sender, EventArgs e)//Logout
    {
        Session["ClientUser"] = null;
        Server.Transfer("ClientLogin.aspx", true);
    }
}
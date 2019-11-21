using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class StaffLogin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    /* Module Name: Signin_Click;
    * Student: Mayank Yadav
    * Modification Date: 23-April-2018
    * Description: Create the sesssion of the staff username
    * Input/Outputs: Staff username and password
    * Globals: No global changes.
    */
    protected void Signin_Click(object sender, EventArgs e)
    {
        TicketEntities te = new TicketEntities();
        Staff st = new Staff();
        string username = firstname.Text;
        string password = pass_word.Text;
        if (username != null && password != null)
        { 
        bool result = te.Staffs.Any(x => x.Username.Equals(username) && x.Password.Equals(password));
        if (result == true)
        {
            Session["StaffUser"] = username;
            Server.Transfer("StaffDashboard.aspx", true);
        }
        else
        {
            Response.Redirect(Request.RawUrl);
        }
        }
        else
        {
            Response.Redirect(Request.RawUrl);
        }
    }

    /* Module Name: signup_Click;
    * Student: Mayank Yadav
    * Modification Date: 23-April-2018
    * Description: Redirect to Staff Registartion
    * Input/Outputs: --
    * Globals: No global changes.
    */
    protected void signup_Click(object sender, EventArgs e)
    {
        Server.Transfer("StaffRegistration.aspx", true);
    }
}
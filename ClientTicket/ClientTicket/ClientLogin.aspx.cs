using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ClientLogin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    /* Module Name: signup_Click;
    * Student: Mayank Yadav
    * Modification Date: 23-April-2018
    * Description: Redirect to Client Registartion
    * Input/Outputs: --
    * Globals: No global changes.
    */
    protected void signup_Click(object sender, EventArgs e)
    {
        Server.Transfer("ClientRegistration.aspx", true);
    }

    /* Module Name: Signin_Click;
    * Student: Mayank Yadav
    * Modification Date: 23-April-2018
    * Description: Create the sesssion of the client username
    * Input/Outputs: Staff username and password
    * Globals: No global changes.
    */
    protected void Signin_Click(object sender, EventArgs e)
    {
        TicketEntities te = new TicketEntities();
        Client st = new Client();
        string username = firstname.Text;
        string password = pass_word.Text;
        if (username != null && password != null)
        {
            bool result = te.Clients.Any(x => x.Email.Equals(username) && x.Password.Equals(password));
            if (result == true)
            {
                Session["ClientUser"] = username;
                Server.Transfer("ClientDashboard.aspx", true);
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
}
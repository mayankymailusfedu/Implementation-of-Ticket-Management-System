using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class StaffRegistration : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    /* Module Name: Signin_Click;
    * Student: Mayank Yadav
    * Modification Date: 23-April-2018
    * Description: Redirect to Staff Login
    * Input/Outputs: No input
    * Globals: No global changes.
    */
    protected void signin_Click(object sender, EventArgs e)
    {
        Server.Transfer("StaffLogin.aspx", true);
    }

    /* Module Name: Signup_Click;
    * Student: Mayank Yadav
    * Modification Date: 23-April-2018
    * Description: Insert the record in Staff Table
    * Input/Outputs: Username , password and confirm password
    * Globals: No global changes.
    */
    protected void Signup_Click(object sender, EventArgs e)
    {
        TicketEntities te = new TicketEntities();
        
        
        string username = firstname.Text;
        string password = pass_word.Text;
        string confirm_password = confirmpassword.Text;
        if (username != null && password != null && confirm_password != null && password.Equals(confirm_password))
        {
            Staff st = new Staff() {
                Username = username,
                Password = password,
                IsActive = false
            };

            te.Staffs.Add(st);
            try
            {
                te.SaveChanges();
                Response.Redirect("StaffLogin.aspx");
            }
            catch(Exception ex)
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
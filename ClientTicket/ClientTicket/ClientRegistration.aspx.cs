using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ClientRegistration : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    /* Module Name: Signin_Click;
    * Student: Mayank Yadav
    * Modification Date: 23-April-2018
    * Description: Redirect to Client Login
    * Input/Outputs: No input
    * Globals: No global changes.
    */
    protected void signin_Click(object sender, EventArgs e)
    {
        Server.Transfer("ClientLogin.aspx", true);
    }

    /* Module Name: Signup_Click;
    * Student: Mayank Yadav
    * Modification Date: 23-April-2018
    * Description: Insert the record in CLient Table
    * Input/Outputs: Fullname, Username , password, confirm password and other details
    * Globals: No global changes.
    */
    protected void Signup_Click(object sender, EventArgs e)
    {
        TicketEntities te = new TicketEntities();
        string fullname = Fullname.Text;
        string gender = Gender.Text;
        string email = username.Text;
        string password = pass_word.Text;
        string confirm_password = confirmpassword.Text;
        string streetaddress1 = StreetAddress1.Text;
        string streetaddress2 = StreetAddress2.Text;
        string city = City.Text;
        string state = State.Text;
        string country = Country.Text;
        string zip = Zip.Text;

        if (fullname != null && email != null && password != null && confirm_password != null && password.Equals(confirm_password))
        {
            Client st = new Client()
            {
                FullName = fullname,
                Gender = gender,
                Email = email,
                Password = password,
                StreetAddress1 = streetaddress1,
                StreetAddress2 = streetaddress2,
                City = city,
                State = state,
                Country = country,
                Zip = zip
            };

            te.Clients.Add(st);
            try
            {
                te.SaveChanges();
                Response.Redirect("ClientLogin.aspx");
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
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CreateTicket : System.Web.UI.Page
{
    private TicketEntities te = new TicketEntities();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    /* Module Name: LinkButton1_Click;
           * Student: Mayank Yadav
           * Modification Date: 23-April-2018
           * Description: It is an onlclick event of Show All Tickets. It will show all the created images regardless of 
           *                whether it belongs to that staff or not
           * Input/Outputs: Check Staff username in session and redirect to StaffDashboard.aspx
           * Globals: If the session is empty, it will throw an exception 
      */
    protected void LinkButton1_Click(object sender, EventArgs e)//Show All
    {
        string username = Session["StaffUser"].ToString();
        if (username != null)
            Server.Transfer("StaffDashboard.aspx", true);
    }


    /* Module Name: IsValidEmail;
        * Student: Mayank Yadav
        * Modification Date: 23-April-2018
        * Description: Checks whether the input email is in correct form or not 
        * Input/Outputs: Takes given input email and gives boolean as output- true if email is in correct format.
        * Globals: No global changes.
   */
    bool IsValidEmail(string email)
    {
        try
        {
            var addr = new System.Net.Mail.MailAddress(email);
            return addr.Address == email;
        }
        catch
        {
            return false;
        }
    }

    /* Module Name: LinkButtonCreate_Click;
    * Student: Mayank Yadav
    * Modification Date: 23-April-2018
    * Description: Creates a ticket and store the value in database (Ticket_Master and Ticket_Activity) 
    * Input/Outputs: Takes all the required values from form and if successful redirect you to Staff Dashboard
    * Globals: No global changes.
*/
    protected void LinkButtonCreate_Click(object sender, EventArgs e)
    {
        string username = Session["StaffUser"].ToString();
        TicketEntities te = new TicketEntities();
        Console.WriteLine("Username: " + username);
        if (username != null)
        {
            IEnumerable<int> staff = from st in te.Staffs
                                     where st.Username.Equals(username)
                                     select st.Staff_ID;
            List<int> factorsofFourList = staff.ToList();
            Console.WriteLine("Staff: " + factorsofFourList[0]);
            int staffid = factorsofFourList[0];
            string E_mail = email.Text;
            bool Isemail = IsValidEmail(E_mail);
            bool notBlocked = false;
            if (Isemail == true)
            {
                IEnumerable<int> block = from bl in te.BlockLists
                                         where bl.Email.Equals(E_mail)
                                         select bl.BlockListID;
                List<int> blockList = block.ToList();
                if (blockList.Count == 0)
                {
                    notBlocked = true;
                }
            }
            string Full_name = name.Text;
            string Ticket_source = source.Text;
            string Cate_gory = category.Text;
            string Sub_ject = subject.Text;
            string Prio_rity = priority.Text;
            int Prior = 0;
            bool IsPriority = int.TryParse(Prio_rity, out Prior);
            string Descript_ion = Request.Form["description"].ToString();
            if (Isemail == true && Full_name != null && Ticket_source != null && Cate_gory != null && Sub_ject != null &&
                Prior != 0 && Descript_ion != null && notBlocked == true)
            {
                byte[] Byte_prior = BitConverter.GetBytes(Prior);
                byte Single_byte = Byte_prior[0];
                Ticket_Master tm = new Ticket_Master()
                {
                    Email = E_mail,
                    FullName = Full_name,
                    CreatedBy = staffid,
                    CreationDate = DateTime.Now,
                    TicketSource = Ticket_source,
                    Category = Cate_gory,
                    Subject = Sub_ject,
                    TicketStatus = "New",
                    Priority = Single_byte,
                    IsDeleted = false
                };

                te.Ticket_Master.Add(tm);

                Ticket_Activity ta = new Ticket_Activity()
                {
                    ActivityType = "Create",
                    Summary = Sub_ject,
                    Description = Descript_ion,
                    ActivityDate = DateTime.Now,
                    ActedBy = staffid,
                    ActorName = username,
                    Unread = false
                };


                tm.Ticket_Activity.Add(ta);
                try
                {
                    te.SaveChanges();
                    Response.Redirect("StaffDashboard.aspx");
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.ToString());
                }
            }
            }
        else
        {
            Response.Redirect("StaffLogin.aspx");
        }
    }
}
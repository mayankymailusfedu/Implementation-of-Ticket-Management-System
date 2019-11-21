using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CreateTicket : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    /* Module Name: LinkButton1_Click;
       * Student: Mayank Yadav
       * Modification Date: 23-April-2018
       * Description: It is an onlclick event of Show All Tickets.
       * Input/Outputs: Check Client username in session and redirect to ClientDashboard.aspx
       * Globals: If the session is empty, it will throw an exception 
  */
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        string username = Session["ClientUser"].ToString();
        if (username != null)
            Server.Transfer("ClientDashboard.aspx", true);
    }


    /* Module Name: LinkButtonCreate_Click;
  * Student: Mayank Yadav
  * Modification Date: 23-April-2018
  * Description: Creates a ticket and store the value in database (Ticket_Master and Ticket_Activity) 
  * Input/Outputs: Takes all the required values from form and if successful redirect you to Client Dashboard
  * Globals: No global changes.
*/
    protected void LinkButtonCreate_Click(object sender, EventArgs e)
    {
        string username = Session["ClientUser"].ToString();
        TicketEntities te = new TicketEntities();
        Console.WriteLine("Username: " + username);
        if (username != null)
        {
            var client = (from cl in te.Clients
                            where cl.Email.Equals(username)
                            select new {
                                cl.Email,
                                cl.FullName,
                                cl.Client_ID
                                }).First();
            string E_mail = client.Email.ToString();
            string Full_name = client.FullName.ToString();
            int clientid = int.Parse(client.Client_ID.ToString());
            bool notBlocked = false;
            if (E_mail != null)
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
            string Ticket_source = "Web";
            string Cate_gory = category.Text;
            string Sub_ject = subject.Text;
            int Prior = 2;;
            string Descript_ion = Request.Form["description"].ToString();
            if (Full_name != null && Ticket_source != null && Cate_gory != null && Sub_ject != null &&
                Prior != 0 && Descript_ion != null && notBlocked == true)
            {
                byte[] Byte_prior = BitConverter.GetBytes(Prior);
                byte Single_byte = Byte_prior[0];
                Ticket_Master tm = new Ticket_Master()
                {
                    Email = E_mail,
                    FullName = Full_name,
                    CreatedBy = clientid,
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
                    ActedBy = clientid,
                    ActorName = "End User",
                    Unread = false
                };


                tm.Ticket_Activity.Add(ta);
                try
                {
                    te.SaveChanges();
                    Response.Redirect("ClientDashboard.aspx");
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.ToString());
                }
            }
        }
        else
        {
            Response.Redirect("ClientLogin.aspx");
        }
    }
}
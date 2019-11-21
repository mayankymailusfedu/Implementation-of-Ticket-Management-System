using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Blocklist : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string username = Session["StaffUser"].ToString();
        if (!Page.IsPostBack && username != null)
        {
            FillDate();
        }
    }

    private void FillDate()
    {
        TicketEntities te = new TicketEntities();
        this.GridView1.DataSource = (from b in te.BlockLists
                                     select new
                                     {
                                         id = b.BlockListID,
                                         em = b.Email

                                     }).ToList();

        this.GridView1.DataBind();
    }

    protected void aeLinkButton_Click(object sender, EventArgs e)
    {
        string username = Session["StaffUser"].ToString();
        Console.WriteLine("Username: " + username);
        if (username != null)
        {
            TicketEntities te = new TicketEntities();
            string E_mail = aeinput.Text;
            bool Isemail = IsValidEmail(E_mail);
            if (Isemail == true)
            {

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

    protected void LinkButtonRemove_Click(object sender, EventArgs e)
    {
        LinkButton lb = (LinkButton)sender;
        HiddenField hd = (HiddenField)lb.FindControl("HiddenField1");

        Console.WriteLine(hd.Value);
        int em = int.Parse(hd.Value.ToString());
        TicketEntities te = new TicketEntities();
        BlockList block = new BlockList() { BlockListID = em };
            te.BlockLists.Attach(block);
            te.BlockLists.Remove(block);
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
        te.SaveChanges();
        Server.Transfer("Blocklist.aspx", true);
    }

    protected void LinkButtonShow_Click(object sender, EventArgs e)
    {
        Server.Transfer("StaffDashboard.aspx", true);
    }
}

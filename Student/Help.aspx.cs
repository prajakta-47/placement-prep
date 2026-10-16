using System;
using System.Web.UI;

namespace PlacementPrep
{
    public partial class Help : System.Web.UI.Page
    {
        // Note: Page_Load is defined in the partial class Help (Admin/Help.aspx.cs)

        protected void btnSubmitTicket_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string ticketId = "TKT-" + new Random().Next(10450, 99999);
                litTicketNotice.Text = string.Format("<strong>Ticket #{0} Created!</strong> Our placement support team has received your inquiry regarding '{1}' and will respond within 24 hours.", ticketId, Server.HtmlEncode(txtTicketSubject.Text.Trim()));
                pnlTicketNotice.Visible = true;

                // Clear input controls
                txtTicketSubject.Text = string.Empty;
                txtTicketMessage.Text = string.Empty;
                ddlTicketCategory.SelectedIndex = 0;
                ddlTicketPriority.SelectedIndex = 1;
            }
        }
    }
}

using System;
using System.Web.UI;

namespace PlacementPrep
{
    public partial class Help : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (pnlTicketNotice != null)
                {
                    pnlTicketNotice.Visible = false;
                }
            }
        }
    }
}

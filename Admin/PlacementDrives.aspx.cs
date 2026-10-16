using System;
using System.Web.UI;

namespace PlacementPrep
{
    public partial class PlacementDrives : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("~/Admin/ManageDrives.aspx", true);
        }
    }
}

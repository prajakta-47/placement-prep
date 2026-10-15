using System;
using System.Web.UI;
using PlacementPrep.Models;

namespace PlacementPrep.Faculty
{
    public partial class PlacementDrives : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                rptDrives.DataSource = FacultyDataStore.Drives;
                rptDrives.DataBind();
            }
        }
    }
}

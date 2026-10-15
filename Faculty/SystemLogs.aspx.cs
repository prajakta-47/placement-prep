using System;
using System.Web.UI;
using PlacementPrep.Models;

namespace PlacementPrep.Faculty
{
    public partial class SystemLogs : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                rptLogs.DataSource = FacultyDataStore.Logs;
                rptLogs.DataBind();
            }
        }
    }
}

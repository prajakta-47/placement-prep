using System;
using System.Web.UI;
using PlacementPrep.Models;

namespace PlacementPrep.Faculty
{
    public partial class BatchReports : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                rptBatchSummary.DataSource = FacultyDataStore.Students;
                rptBatchSummary.DataBind();
            }
        }
    }
}

using System;
using System.Web.UI;
using PlacementPrep.Models;

namespace PlacementPrep.Faculty
{
    public partial class Companies : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                rptCompanies.DataSource = FacultyDataStore.Companies;
                rptCompanies.DataBind();
            }
        }
    }
}

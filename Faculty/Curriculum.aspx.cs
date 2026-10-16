using System;
using System.Web.UI;
using PlacementPrep.Models;

namespace PlacementPrep.Faculty
{
    public partial class Curriculum : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                rptSubjects.DataSource = FacultyDataStore.Subjects;
                rptSubjects.DataBind();
            }
        }
    }
}

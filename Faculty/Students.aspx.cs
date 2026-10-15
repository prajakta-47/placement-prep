using System;
using System.Linq;
using System.Web.UI;
using PlacementPrep.Models;

namespace PlacementPrep.Faculty
{
    public partial class Students : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindStudents();
            }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            BindStudents();
        }

        private void BindStudents()
        {
            var list = FacultyDataStore.Students.AsEnumerable();
            string query = txtSearch.Text.Trim();
            if (!string.IsNullOrEmpty(query))
            {
                list = list.Where(s => s.Name.IndexOf(query, StringComparison.OrdinalIgnoreCase) >= 0 ||
                                       s.RollNo.IndexOf(query, StringComparison.OrdinalIgnoreCase) >= 0);
            }

            string status = ddlStatus.SelectedValue;
            if (!string.IsNullOrEmpty(status) && status != "ALL")
            {
                list = list.Where(s => string.Equals(s.Status, status, StringComparison.OrdinalIgnoreCase));
            }

            rptStudents.DataSource = list.ToList();
            rptStudents.DataBind();
        }
    }
}

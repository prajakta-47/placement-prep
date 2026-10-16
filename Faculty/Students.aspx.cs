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
                if (!string.IsNullOrEmpty(Request.QueryString["q"]))
                {
                    txtSearch.Text = Request.QueryString["q"];
                }
                BindStudents();
            }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            BindStudents();
        }

        protected void btnExportCsv_Click(object sender, EventArgs e)
        {
            var list = FacultyDataStore.Students;
            Response.Clear();
            Response.ContentType = "text/csv";
            Response.AddHeader("content-disposition", "attachment;filename=Student_Readiness_Cohort.csv");
            Response.Write("RollNo,Name,Department,CGPA,TestsCompleted,AvgScore,ReadinessIndex,Status\n");
            foreach (var s in list)
            {
                Response.Write(string.Format("\"{0}\",\"{1}\",\"{2}\",{3:F2},{4},{5:F1},{6:F0},\"{7}\"\n",
                    s.RollNo, s.Name, s.Department, s.CGPA, s.TestsCompleted, s.AvgScore, s.ReadinessIndex, s.Status));
            }
            Response.End();
        }

        protected void btnSaveStudent_Click(object sender, EventArgs e)
        {
            string name = txtNewName.Text.Trim();
            string roll = txtNewRoll.Text.Trim();
            string dept = txtNewDept.Text.Trim();
            decimal cgpa = 8.0m;
            decimal.TryParse(txtNewCgpa.Text.Trim(), out cgpa);
            string status = ddlNewStatus.SelectedValue;

            if (!string.IsNullOrEmpty(name) && !string.IsNullOrEmpty(roll))
            {
                var s = new StudentModel
                {
                    Name = name,
                    RollNo = roll,
                    Department = string.IsNullOrEmpty(dept) ? "Computer Science & Engineering" : dept,
                    CGPA = cgpa,
                    TestsCompleted = 10,
                    AvgScore = cgpa * 9.5m,
                    ReadinessIndex = cgpa * 10m,
                    Status = status,
                    Trend = "+3%",
                    Email = roll.ToLower() + "@campus.edu",
                    ClassYear = "Class of 2025"
                };
                FacultyDataStore.AddStudent(s);
                txtNewName.Text = "";
                txtNewRoll.Text = "";
                BindStudents();
            }
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

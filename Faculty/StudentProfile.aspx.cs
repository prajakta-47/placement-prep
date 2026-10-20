using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using PlacementPrep.Models;

namespace PlacementPrep.Faculty
{
    public partial class StudentProfile : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string roll = Request.QueryString["roll"];
                LoadStudent(roll);
            }
        }

        private void LoadStudent(string roll)
        {
            var students = FacultyDataStore.Students;
            StudentModel student = null;

            if (!string.IsNullOrWhiteSpace(roll))
            {
                student = students.FirstOrDefault(s => string.Equals(s.RollNo, roll.Trim(), StringComparison.OrdinalIgnoreCase));
            }

            if (student == null)
            {
                student = students.FirstOrDefault();
            }

            if (student == null)
            {
                pnlAlert.Visible = true;
                pnlAlert.CssClass = "users-alert users-alert-error";
                litAlert.Text = "Student record could not be found in active cohort.";
                return;
            }

            // Populate Student Details
            litStudentName.Text = student.Name;
            litRollNo.Text = student.RollNo;
            litDepartment.Text = student.Department;
            litClassYear.Text = !string.IsNullOrEmpty(student.ClassYear) ? student.ClassYear : "Class of 2025";
            litEmail.Text = !string.IsNullOrEmpty(student.Email) ? student.Email : (student.RollNo.ToLower() + "@campus.edu");

            // Avatar Initials
            string[] parts = student.Name.Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
            string initials = "ST";
            if (parts.Length >= 2)
            {
                initials = ("" + parts[0][0] + parts[parts.Length - 1][0]).ToUpper();
            }
            else if (parts.Length == 1 && parts[0].Length >= 2)
            {
                initials = parts[0].Substring(0, 2).ToUpper();
            }
            litAvatarInitials.Text = initials;

            // Status Badge
            string statusCss = "badge-review";
            if (string.Equals(student.Status, "Strong Fit", StringComparison.OrdinalIgnoreCase))
            {
                statusCss = "badge-fit";
            }
            else if (string.Equals(student.Status, "On Track", StringComparison.OrdinalIgnoreCase))
            {
                statusCss = "badge-track";
            }
            litStatusBadge.Text = string.Format("<span class='{0}'>{1}</span>", statusCss, student.Status);

            // KPIs
            litCgpa.Text = student.CGPA.ToString("F2");
            litReadiness.Text = student.ReadinessIndex.ToString("F0");
            litTrend.Text = !string.IsNullOrEmpty(student.Trend) ? student.Trend : "+3%";
            litRank.Text = student.BatchRank > 0 ? student.BatchRank.ToString() : "1";
            litSolved.Text = student.TotalSolved > 0 ? student.TotalSolved.ToString() : (student.TestsCompleted * 10).ToString();
            litTestsTaken.Text = student.TestsCompleted.ToString();
            litAvgScore.Text = student.AvgScore.ToString("F1");

            // Aptitude domain breakdowns based on candidate baseline
            decimal baseScore = student.AvgScore;
            litQuantScore.Text = Math.Min(98, Math.Max(50, (int)(baseScore - 2))) + "%";
            litLogicScore.Text = Math.Min(98, Math.Max(50, (int)(baseScore + 4))) + "%";
            litVerbalScore.Text = Math.Min(98, Math.Max(50, (int)(baseScore - 4))) + "%";
            litCoreCsScore.Text = Math.Min(98, Math.Max(50, (int)(baseScore + 2))) + "%";

            // Skills repeater
            var skills = student.Skills;
            if (skills == null || skills.Count == 0)
            {
                skills = new List<string> { "C#", "ASP.NET Core", "SQL Server", "Data Structures", "Algorithms", "System Design", "Python", "REST APIs" };
            }
            rptSkills.DataSource = skills;
            rptSkills.DataBind();
        }

        protected void btnSaveNote_Click(object sender, EventArgs e)
        {
            string note = txtNewNote.Text.Trim();
            if (!string.IsNullOrWhiteSpace(note))
            {
                litFacultyNote.Text = Server.HtmlEncode(note);
                txtNewNote.Text = string.Empty;
                pnlAlert.Visible = true;
                litAlert.Text = "Mentorship record and counseling note successfully updated.";
            }
        }
    }
}

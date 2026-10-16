using System;
using System.Web.UI;
using PlacementPrep.Models;

namespace PlacementPrep.Faculty
{
    public partial class Announcements : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindAnnouncements();
            }
        }

        private void BindAnnouncements()
        {
            rptAnnouncements.DataSource = FacultyDataStore.Announcements;
            rptAnnouncements.DataBind();
        }

        protected void btnPostAnnouncement_Click(object sender, EventArgs e)
        {
            string title = txtTitle.Text.Trim();
            string content = txtContent.Text.Trim();
            string priority = ddlPriority.SelectedValue;
            string cohort = txtCohort.Text.Trim();

            if (string.IsNullOrEmpty(title) || string.IsNullOrEmpty(content))
            {
                litAlert.Text = "Please enter both an Announcement Title and Message Content.";
                pnlAlert.CssClass = "alert-box";
                pnlAlert.Style["background"] = "#fef2f2";
                pnlAlert.Style["color"] = "#991b1b";
                pnlAlert.Visible = true;
                return;
            }

            var ann = new AnnouncementModel
            {
                Title = title,
                Content = content,
                Priority = priority,
                TargetCohort = string.IsNullOrEmpty(cohort) ? "All Departments" : cohort,
                Author = "Prof. R. Sharma",
                PostedDate = DateTime.Now
            };

            FacultyDataStore.AddAnnouncement(ann);

            litAlert.Text = "✓ Announcement broadcasted successfully to student dashboards.";
            pnlAlert.CssClass = "alert-box";
            pnlAlert.Style["background"] = "#ecfdf5";
            pnlAlert.Style["color"] = "#065f46";
            pnlAlert.Visible = true;

            txtTitle.Text = "";
            txtContent.Text = "";

            BindAnnouncements();
        }
    }
}

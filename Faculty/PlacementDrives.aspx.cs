using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using PlacementPrep.Models;

namespace PlacementPrep.Faculty
{
    public partial class PlacementDrives : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDrives();
            }
        }

        private void BindDrives()
        {
            var drives = FacultyDataStore.Drives.AsEnumerable();

            string search = txtSearchDrives.Text.Trim();
            if (!string.IsNullOrEmpty(search))
            {
                drives = drives.Where(d => 
                    (d.CompanyName != null && d.CompanyName.IndexOf(search, StringComparison.OrdinalIgnoreCase) >= 0) ||
                    (d.JobTitle != null && d.JobTitle.IndexOf(search, StringComparison.OrdinalIgnoreCase) >= 0) ||
                    (d.DriveId != null && d.DriveId.IndexOf(search, StringComparison.OrdinalIgnoreCase) >= 0));
            }

            string status = ddlStatusFilter.SelectedValue;
            if (!string.IsNullOrEmpty(status) && status != "ALL")
            {
                drives = drives.Where(d => string.Equals(d.Status, status, StringComparison.OrdinalIgnoreCase));
            }

            var list = drives.ToList();
            rptDrives.DataSource = list;
            rptDrives.DataBind();

            litDriveCount.Text = list.Count.ToString();
        }

        protected void btnFilterDrives_Click(object sender, EventArgs e)
        {
            BindDrives();
        }

        protected void rptDrives_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteDrive")
            {
                string driveId = e.CommandArgument.ToString();
                if (FacultyDataStore.DeleteDrive(driveId))
                {
                    ShowAlert("Placement drive " + driveId + " was deleted successfully.");
                }
                else
                {
                    ShowAlert("Unable to find or delete placement drive.");
                }
                BindDrives();
            }
        }

        protected void btnSaveDrive_Click(object sender, EventArgs e)
        {
            string driveId = hfDriveId.Value;
            string company = txtModalCompany.Text.Trim();
            string role = txtModalRole.Text.Trim();
            string date = txtModalDate.Text.Trim();
            string time = txtModalTime.Text.Trim();
            string location = txtModalLocation.Text.Trim();
            string status = ddlModalStatus.SelectedValue;
            string dept = txtModalDept.Text.Trim();

            int students = 0;
            int.TryParse(txtModalStudents.Text.Trim(), out students);

            decimal cgpa = 7.0m;
            decimal.TryParse(txtModalCgpa.Text.Trim(), out cgpa);

            decimal package = 6.5m;
            decimal.TryParse(txtModalPackage.Text.Trim(), out package);
            if (package <= 0) package = 6.5m;

            string industry = txtModalIndustry.Text.Trim();
            if (string.IsNullOrEmpty(industry)) industry = "IT Services";

            if (string.IsNullOrEmpty(company) || string.IsNullOrEmpty(role))
            {
                ShowAlert("Please provide both Company Name and Job Role.");
                return;
            }

            if (string.IsNullOrEmpty(date)) date = DateTime.Now.AddDays(7).ToString("MMM dd, yyyy");
            if (string.IsNullOrEmpty(time)) time = "10:00 AM - 01:00 PM";
            if (string.IsNullOrEmpty(location)) location = "Campus Lab 3";

            if (string.IsNullOrEmpty(driveId))
            {
                // Create
                var newDrive = new PlacementDriveModel
                {
                    CompanyName = company,
                    JobTitle = role,
                    EventDate = date,
                    TimeWindow = time,
                    Location = location,
                    Status = status,
                    RegisteredStudents = students > 0 ? students : 45,
                    EligibleDept = string.IsNullOrEmpty(dept) ? "CSE, IT" : dept,
                    MinCgpa = cgpa > 0 ? cgpa : 7.0m,
                    PackageLPA = package,
                    Industry = industry,
                    DriveType = "Full Time"
                };
                FacultyDataStore.AddDrive(newDrive);
                ShowAlert("Successfully scheduled new placement drive for " + company + " (" + newDrive.DriveId + ") with " + package.ToString("F1") + " LPA.");
            }
            else
            {
                // Update
                var existing = FacultyDataStore.GetDrive(driveId);
                if (existing != null)
                {
                    existing.CompanyName = company;
                    existing.JobTitle = role;
                    existing.EventDate = date;
                    existing.TimeWindow = time;
                    existing.Location = location;
                    existing.Status = status;
                    existing.RegisteredStudents = students;
                    existing.EligibleDept = dept;
                    existing.MinCgpa = cgpa;
                    existing.PackageLPA = package;
                    existing.Industry = industry;
                    FacultyDataStore.UpdateDrive(existing);
                    ShowAlert("Updated placement drive details for " + company + " (" + driveId + ").");
                }
            }

            BindDrives();
        }

        private void ShowAlert(string msg)
        {
            litDriveAlert.Text = msg;
            pnlDriveAlert.Visible = true;
        }
    }
}

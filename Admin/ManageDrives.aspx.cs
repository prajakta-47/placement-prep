using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using PlacementPrep.Helpers;

namespace PlacementPrep
{
    public partial class ManageDrives : Page
    {
        private readonly PlacementDriveRepository _driveRepo = new PlacementDriveRepository();
        private readonly CompanyRepository _companyRepo = new CompanyRepository();
        private int _totalPages = 1;

        private int CurrentPageIndex
        {
            get
            {
                int page;
                return int.TryParse(hfPageIndex.Value, out page) && page > 0 ? page : 1;
            }
            set
            {
                hfPageIndex.Value = Math.Max(1, value).ToString(CultureInfo.InvariantCulture);
            }
        }

        private int CurrentPageSize
        {
            get
            {
                int size;
                return int.TryParse(ddlPageSize.SelectedValue, out size) && size > 0 ? size : 10;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindKpis();
                BindFilters();
                BindPage();
            }
        }

        protected void btnApplyFilters_Click(object sender, EventArgs e)
        {
            CurrentPageIndex = 1;
            BindPage();
        }

        protected void btnResetFilters_Click(object sender, EventArgs e)
        {
            txtSearch.Text = string.Empty;
            ddlCompanyFilter.SelectedValue = "All";
            ddlStatusFilter.SelectedValue = "All";
            ddlDeptFilter.SelectedValue = "All";
            CurrentPageIndex = 1;
            BindPage();
        }

        protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            CurrentPageIndex = 1;
            BindPage();
        }

        protected void btnPrevPage_Click(object sender, EventArgs e)
        {
            if (CurrentPageIndex > 1)
            {
                CurrentPageIndex--;
                BindPage();
            }
        }

        protected void btnNextPage_Click(object sender, EventArgs e)
        {
            if (CurrentPageIndex < _totalPages)
            {
                CurrentPageIndex++;
                BindPage();
            }
        }

        protected void rptPages_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "GoPage") return;

            int page;
            if (int.TryParse(Convert.ToString(e.CommandArgument), out page))
            {
                CurrentPageIndex = page;
                BindPage();
            }
        }

        protected void rptDrives_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int driveId;
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out driveId)) return;

            try
            {
                switch (e.CommandName)
                {
                    case "QuickView":
                        OpenDriveDetailsModal(driveId);
                        break;
                    case "EditDrive":
                        OpenEditModal(driveId);
                        break;
                    case "ToggleStatus":
                        _driveRepo.ToggleStatus(driveId);
                        ShowMessage("Drive status toggled successfully (In-Memory Sample Store).", false);
                        BindKpis();
                        BindPage();
                        break;
                    case "DeleteDrive":
                        string err;
                        if (_driveRepo.Delete(driveId, out err))
                        {
                            ShowMessage("Placement drive removed from schedule (In-Memory Sample Store).", false);
                            BindKpis();
                            BindPage();
                        }
                        else
                        {
                            ShowMessage(err, true);
                        }
                        break;
                }
            }
            catch (Exception ex)
            {
                ShowMessage(ex.Message, true);
            }
        }

        protected void btnOpenAddDrive_Click(object sender, EventArgs e)
        {
            ClearMessage();
            hfEditDriveId.Value = "0";
            litDriveModalTitle.Text = "Schedule Placement Drive";

            BindCompanyDropdown();

            txtJobRole.Text = string.Empty;
            txtDriveDate.Text = DateTime.UtcNow.AddDays(14).ToString("yyyy-MM-dd");
            txtDeadline.Text = DateTime.UtcNow.AddDays(7).ToString("yyyy-MM-dd");
            txtMinCgpa.Text = "7.50";
            txtGradBatch.Text = "2025";
            txtOpenings.Text = "15";
            ddlFormStatus.SelectedValue = "Open";
            txtPkgMin.Text = "18.0";
            txtPkgMax.Text = "24.0";
            txtWorkLocation.Text = "Bangalore, Hyderabad";
            txtBondDetails.Text = "No Service Bond";
            txtEligibleDepts.Text = "Computer Science, Information Technology";
            txtRecruitmentStages.Text = "Online Assessment, Technical Interview 1, Technical Interview 2, HR Round";
            txtDescription.Text = string.Empty;

            pnlDriveModal.Visible = true;
            pnlDriveDetailsModal.Visible = false;
        }

        protected void btnCloseDriveModal_Click(object sender, EventArgs e)
        {
            pnlDriveModal.Visible = false;
        }

        protected void btnCloseDriveDetails_Click(object sender, EventArgs e)
        {
            pnlDriveDetailsModal.Visible = false;
        }

        protected void btnSaveDrive_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                pnlDriveModal.Visible = true;
                return;
            }

            int editId;
            int.TryParse(hfEditDriveId.Value, out editId);
            var isNew = editId <= 0;

            DateTime driveDate;
            if (!DateTime.TryParse(txtDriveDate.Text.Trim(), CultureInfo.InvariantCulture, DateTimeStyles.None, out driveDate))
            {
                ShowMessage("Invalid drive execution date format.", true);
                pnlDriveModal.Visible = true;
                return;
            }

            DateTime deadline;
            if (!DateTime.TryParse(txtDeadline.Text.Trim(), CultureInfo.InvariantCulture, DateTimeStyles.None, out deadline))
            {
                ShowMessage("Invalid application deadline date format.", true);
                pnlDriveModal.Visible = true;
                return;
            }

            // Server-side date consistency validation: deadline cannot be after drive date
            if (deadline > driveDate)
            {
                ShowMessage("Application deadline cannot be later than the drive execution date.", true);
                pnlDriveModal.Visible = true;
                return;
            }

            double minCgpa;
            if (!double.TryParse(txtMinCgpa.Text.Trim(), NumberStyles.Any, CultureInfo.InvariantCulture, out minCgpa) || minCgpa < 0 || minCgpa > 10.0)
            {
                ShowMessage("Minimum CGPA cutoff must be between 0.00 and 10.00.", true);
                pnlDriveModal.Visible = true;
                return;
            }

            int gradBatch;
            if (!int.TryParse(txtGradBatch.Text.Trim(), out gradBatch) || gradBatch < 2020 || gradBatch > 2035)
            {
                ShowMessage("Graduation batch must be between 2020 and 2035.", true);
                pnlDriveModal.Visible = true;
                return;
            }

            int openings;
            if (!int.TryParse(txtOpenings.Text.Trim(), out openings) || openings <= 0)
            {
                ShowMessage("Openings count must be a positive integer.", true);
                pnlDriveModal.Visible = true;
                return;
            }

            double minPkg;
            double.TryParse(txtPkgMin.Text.Trim(), NumberStyles.Any, CultureInfo.InvariantCulture, out minPkg);

            double maxPkg;
            double.TryParse(txtPkgMax.Text.Trim(), NumberStyles.Any, CultureInfo.InvariantCulture, out maxPkg);

            if (maxPkg < minPkg)
            {
                ShowMessage("Maximum package cannot be lower than minimum package.", true);
                pnlDriveModal.Visible = true;
                return;
            }

            string companyName = ddlFormCompany.SelectedItem != null ? ddlFormCompany.SelectedItem.Text : ddlFormCompany.SelectedValue;
            int companyId = 0;
            int.TryParse(ddlFormCompany.SelectedValue, out companyId);

            string err;
            if (isNew)
            {
                var newDrive = new PlacementDriveItem
                {
                    CompanyId = companyId,
                    CompanyName = companyName,
                    JobRole = txtJobRole.Text.Trim(),
                    DriveDate = driveDate,
                    ApplicationDeadline = deadline,
                    MinCgpa = minCgpa,
                    GraduationBatch = gradBatch,
                    Openings = openings,
                    PackageMinLpa = minPkg,
                    PackageMaxLpa = maxPkg,
                    DriveStatus = ddlFormStatus.SelectedValue,
                    WorkLocation = txtWorkLocation.Text.Trim(),
                    BondDetails = txtBondDetails.Text.Trim(),
                    EligibleDepartments = txtEligibleDepts.Text.Trim(),
                    RecruitmentStages = txtRecruitmentStages.Text.Trim(),
                    JobDescription = txtDescription.Text.Trim(),
                    ApplicantCount = 0,
                    ShortlistedCount = 0,
                    OfferedCount = 0
                };

                if (_driveRepo.Add(newDrive, out err))
                {
                    ShowMessage("Placement drive for <strong>" + Server.HtmlEncode(companyName) + "</strong> scheduled successfully (In-Memory Sample Store).", false);
                    pnlDriveModal.Visible = false;
                    BindKpis();
                    BindPage();
                }
                else
                {
                    ShowMessage(err, true);
                    pnlDriveModal.Visible = true;
                }
            }
            else
            {
                var existing = _driveRepo.GetById(editId);
                if (existing == null)
                {
                    ShowMessage("Placement drive record not found.", true);
                    return;
                }

                existing.CompanyId = companyId;
                existing.CompanyName = companyName;
                existing.JobRole = txtJobRole.Text.Trim();
                existing.DriveDate = driveDate;
                existing.ApplicationDeadline = deadline;
                existing.MinCgpa = minCgpa;
                existing.GraduationBatch = gradBatch;
                existing.Openings = openings;
                existing.PackageMinLpa = minPkg;
                existing.PackageMaxLpa = maxPkg;
                existing.DriveStatus = ddlFormStatus.SelectedValue;
                existing.WorkLocation = txtWorkLocation.Text.Trim();
                existing.BondDetails = txtBondDetails.Text.Trim();
                existing.EligibleDepartments = txtEligibleDepts.Text.Trim();
                existing.RecruitmentStages = txtRecruitmentStages.Text.Trim();
                existing.JobDescription = txtDescription.Text.Trim();

                if (_driveRepo.Update(existing, out err))
                {
                    ShowMessage("Placement drive <strong>" + Server.HtmlEncode(existing.DriveCode) + "</strong> updated successfully (In-Memory Sample Store).", false);
                    pnlDriveModal.Visible = false;
                    BindKpis();
                    BindPage();
                }
                else
                {
                    ShowMessage(err, true);
                    pnlDriveModal.Visible = true;
                }
            }
        }

        private void OpenDriveDetailsModal(int driveId)
        {
            var drive = _driveRepo.GetById(driveId);
            if (drive == null)
            {
                ShowMessage("Placement drive not found.", true);
                return;
            }

            litQuickCompanyInitials.Text = !string.IsNullOrWhiteSpace(drive.CompanyName)
                ? drive.CompanyName.Substring(0, Math.Min(2, drive.CompanyName.Length)).ToUpperInvariant()
                : "DR";

            litQuickJobRole.Text = Server.HtmlEncode(drive.JobRole);
            litQuickCompany.Text = Server.HtmlEncode(drive.CompanyName);
            litQuickDriveCode.Text = Server.HtmlEncode(drive.DriveCode);
            litQuickLocation.Text = Server.HtmlEncode(drive.WorkLocation);

            litQuickStatus.Text = Server.HtmlEncode(drive.DriveStatus);
            badgeQuickStatus.Attributes["class"] = drive.StatusClass;

            litQuickPackage.Text = Server.HtmlEncode(drive.PackageDisplay);
            litQuickOpenings.Text = drive.Openings.ToString(CultureInfo.InvariantCulture);
            litQuickMinCgpa.Text = string.Format(CultureInfo.InvariantCulture, "{0:0.00}+", drive.MinCgpa);
            litQuickDriveDate.Text = drive.DriveDate.ToString("MMM dd, yyyy");

            litQuickDepts.Text = Server.HtmlEncode(drive.EligibleDepartments);
            litQuickBatch.Text = drive.GraduationBatch.ToString(CultureInfo.InvariantCulture);
            litQuickDeadline.Text = drive.ApplicationDeadline.ToString("MMM dd, yyyy");
            litQuickBond.Text = string.IsNullOrWhiteSpace(drive.BondDetails) ? "None" : Server.HtmlEncode(drive.BondDetails);

            litQuickStages.Text = Server.HtmlEncode(drive.RecruitmentStages);
            litQuickDescription.Text = string.IsNullOrWhiteSpace(drive.JobDescription)
                ? "No detailed description entered."
                : Server.HtmlEncode(drive.JobDescription);

            btnFullDrivePage.HRef = ResolveUrl("~/Admin/DriveDetails.aspx?id=" + drive.DriveId);

            pnlDriveDetailsModal.Visible = true;
            pnlDriveModal.Visible = false;
        }

        private void OpenEditModal(int driveId)
        {
            var drive = _driveRepo.GetById(driveId);
            if (drive == null)
            {
                ShowMessage("Drive not found.", true);
                return;
            }

            BindCompanyDropdown();

            hfEditDriveId.Value = drive.DriveId.ToString(CultureInfo.InvariantCulture);
            litDriveModalTitle.Text = "Edit Placement Drive (" + drive.DriveCode + ")";

            // Select company by name or id
            var matchItem = ddlFormCompany.Items.FindByText(drive.CompanyName);
            if (matchItem != null)
            {
                ddlFormCompany.SelectedValue = matchItem.Value;
            }

            txtJobRole.Text = drive.JobRole;
            txtDriveDate.Text = drive.DriveDate.ToString("yyyy-MM-dd");
            txtDeadline.Text = drive.ApplicationDeadline.ToString("yyyy-MM-dd");
            txtMinCgpa.Text = drive.MinCgpa.ToString("0.00", CultureInfo.InvariantCulture);
            txtGradBatch.Text = drive.GraduationBatch.ToString(CultureInfo.InvariantCulture);
            txtOpenings.Text = drive.Openings.ToString(CultureInfo.InvariantCulture);

            if (ddlFormStatus.Items.FindByValue(drive.DriveStatus) != null)
                ddlFormStatus.SelectedValue = drive.DriveStatus;

            txtPkgMin.Text = drive.PackageMinLpa.ToString("0.0", CultureInfo.InvariantCulture);
            txtPkgMax.Text = drive.PackageMaxLpa.ToString("0.0", CultureInfo.InvariantCulture);
            txtWorkLocation.Text = drive.WorkLocation;
            txtBondDetails.Text = drive.BondDetails;
            txtEligibleDepts.Text = drive.EligibleDepartments;
            txtRecruitmentStages.Text = drive.RecruitmentStages;
            txtDescription.Text = drive.JobDescription;

            pnlDriveModal.Visible = true;
            pnlDriveDetailsModal.Visible = false;
        }

        private void BindCompanyDropdown()
        {
            ddlFormCompany.Items.Clear();
            var companies = _companyRepo.Search(string.Empty, "All", "All", 1, 100).Items;
            foreach (var c in companies)
            {
                ddlFormCompany.Items.Add(new ListItem(c.CompanyName, c.CompanyId.ToString(CultureInfo.InvariantCulture)));
            }
        }

        private void BindKpis()
        {
            var kpis = _driveRepo.GetKpiSummary();
            litKpiTotalDrives.Text = kpis.TotalDrives.ToString(CultureInfo.InvariantCulture);
            litKpiOpenDrives.Text = kpis.OpenDrivesCount.ToString(CultureInfo.InvariantCulture);
            litKpiUpcomingDrives.Text = kpis.UpcomingDrivesCount.ToString(CultureInfo.InvariantCulture);
            litKpiTotalOpenings.Text = kpis.TotalOpeningsCount.ToString(CultureInfo.InvariantCulture);
        }

        private void BindFilters()
        {
            var selCompany = ddlCompanyFilter.SelectedValue;
            ddlCompanyFilter.Items.Clear();
            ddlCompanyFilter.Items.Add(new ListItem("All Companies", "All"));

            var companies = _companyRepo.Search(string.Empty, "All", "All", 1, 100).Items;
            foreach (var c in companies)
            {
                ddlCompanyFilter.Items.Add(new ListItem(c.CompanyName, c.CompanyName));
            }
            if (!string.IsNullOrEmpty(selCompany) && ddlCompanyFilter.Items.FindByValue(selCompany) != null)
                ddlCompanyFilter.SelectedValue = selCompany;
        }

        private void BindPage()
        {
            var result = _driveRepo.Search(
                txtSearch.Text,
                ddlCompanyFilter.SelectedValue,
                ddlStatusFilter.SelectedValue,
                ddlDeptFilter.SelectedValue,
                CurrentPageIndex,
                CurrentPageSize);

            _totalPages = Math.Max(1, result.TotalPages);
            if (CurrentPageIndex > _totalPages)
            {
                CurrentPageIndex = _totalPages;
                result = _driveRepo.Search(
                    txtSearch.Text,
                    ddlCompanyFilter.SelectedValue,
                    ddlStatusFilter.SelectedValue,
                    ddlDeptFilter.SelectedValue,
                    CurrentPageIndex,
                    CurrentPageSize);
            }

            rptDrives.DataSource = result.Items;
            rptDrives.DataBind();

            pnlEmpty.Visible = result.TotalCount == 0;
            rptDrives.Visible = result.TotalCount > 0;

            int startRow = result.TotalCount == 0 ? 0 : (result.PageIndex - 1) * result.PageSize + 1;
            int endRow = Math.Min(result.PageIndex * result.PageSize, result.TotalCount);
            litPageInfo.Text = string.Format(CultureInfo.InvariantCulture, "Showing {0}-{1} of {2} drives", startRow, endRow, result.TotalCount);

            btnPrevPage.Enabled = result.PageIndex > 1;
            btnNextPage.Enabled = result.PageIndex < _totalPages;

            var pages = new List<object>();
            int window = 5;
            int startPage = Math.Max(1, result.PageIndex - window / 2);
            int endPage = Math.Min(_totalPages, startPage + window - 1);
            if (endPage - startPage + 1 < window)
            {
                startPage = Math.Max(1, endPage - window + 1);
            }

            for (int p = startPage; p <= endPage; p++)
            {
                pages.Add(new
                {
                    PageNumber = p,
                    IsCurrent = (p == result.PageIndex)
                });
            }

            rptPages.DataSource = pages;
            rptPages.DataBind();
        }

        private void ShowMessage(string message, bool isError)
        {
            pnlMessage.Visible = true;
            pnlMessage.CssClass = isError ? "users-alert users-alert-error" : "users-alert users-alert-success";
            litMessage.Text = message;
        }

        private void ClearMessage()
        {
            pnlMessage.Visible = false;
            litMessage.Text = string.Empty;
        }
    }
}

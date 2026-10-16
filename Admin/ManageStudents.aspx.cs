using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using PlacementPrep.Helpers;

namespace PlacementPrep
{
    public partial class ManageStudents : Page
    {
        private readonly StudentRepository _repo = new StudentRepository();
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
            ddlDepartmentFilter.SelectedValue = "All";
            ddlBatchFilter.SelectedValue = "All";
            ddlEligibilityFilter.SelectedValue = "All";
            ddlPlacementStatusFilter.SelectedValue = "All";
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

        protected void rptStudents_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int studentId;
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out studentId)) return;

            try
            {
                switch (e.CommandName)
                {
                    case "ViewDossier":
                        OpenDossierModal(studentId);
                        break;
                    case "EditStudent":
                        OpenEditModal(studentId);
                        break;
                    case "ToggleEligibility":
                        _repo.ToggleEligibility(studentId);
                        ShowMessage("Placement eligibility status updated for student (In-Memory Sample Store).", false);
                        BindKpis();
                        BindPage();
                        break;
                    case "DeleteStudent":
                        _repo.DeleteStudent(studentId);
                        ShowMessage("Student record removed from repository (In-Memory Sample Store).", false);
                        BindKpis();
                        BindPage();
                        break;
                }
            }
            catch (Exception ex)
            {
                ShowMessage(ex.Message, true);
            }
        }

        protected void btnOpenAdd_Click(object sender, EventArgs e)
        {
            ClearMessage();
            hfEditStudentId.Value = "0";
            litModalTitle.Text = "Add Student Record";
            txtFullName.Text = string.Empty;
            txtEnrollmentId.Text = string.Empty;
            txtEmail.Text = string.Empty;
            ddlFormDepartment.SelectedValue = "Computer Science";
            txtGradYear.Text = "2025";
            txtCgpa.Text = "8.00";
            ddlFormEligibility.SelectedValue = "Eligible";
            ddlFormPlacementStatus.SelectedValue = "Unplaced";
            txtCompanyPlaced.Text = string.Empty;
            txtPackageLpa.Text = string.Empty;
            txtTechnicalSkills.Text = string.Empty;
            txtGithub.Text = string.Empty;
            txtLinkedin.Text = string.Empty;

            pnlStudentModal.Visible = true;
            pnlDossierModal.Visible = false;
        }

        protected void btnCloseModal_Click(object sender, EventArgs e)
        {
            pnlStudentModal.Visible = false;
        }

        protected void btnCloseDossier_Click(object sender, EventArgs e)
        {
            pnlDossierModal.Visible = false;
        }

        protected void btnSaveStudent_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                pnlStudentModal.Visible = true;
                return;
            }

            int editId;
            int.TryParse(hfEditStudentId.Value, out editId);
            var isNew = editId <= 0;

            var enrollmentId = txtEnrollmentId.Text.Trim();
            var email = txtEmail.Text.Trim();

            if (_repo.EnrollmentIdExists(enrollmentId, isNew ? (int?)null : editId))
            {
                ShowMessage("A student with Enrollment ID <strong>" + Server.HtmlEncode(enrollmentId) + "</strong> already exists.", true);
                pnlStudentModal.Visible = true;
                return;
            }

            if (_repo.EmailExists(email, isNew ? (int?)null : editId))
            {
                ShowMessage("A student with Email <strong>" + Server.HtmlEncode(email) + "</strong> already exists.", true);
                pnlStudentModal.Visible = true;
                return;
            }

            int gradYear;
            if (!int.TryParse(txtGradYear.Text.Trim(), out gradYear) || gradYear < 2020 || gradYear > 2035)
            {
                ShowMessage("Please enter a valid graduation year between 2020 and 2035.", true);
                pnlStudentModal.Visible = true;
                return;
            }

            double cgpa;
            if (!double.TryParse(txtCgpa.Text.Trim(), NumberStyles.Any, CultureInfo.InvariantCulture, out cgpa) || cgpa < 0.0 || cgpa > 10.0)
            {
                ShowMessage("Please enter a valid academic CGPA between 0.00 and 10.00.", true);
                pnlStudentModal.Visible = true;
                return;
            }

            double? packageLpa = null;
            if (!string.IsNullOrWhiteSpace(txtPackageLpa.Text))
            {
                double pkg;
                if (double.TryParse(txtPackageLpa.Text.Trim(), NumberStyles.Any, CultureInfo.InvariantCulture, out pkg))
                {
                    packageLpa = pkg;
                }
            }

            var student = new StudentItem
            {
                StudentId = editId,
                FullName = txtFullName.Text.Trim(),
                EnrollmentId = enrollmentId,
                Email = email,
                Department = ddlFormDepartment.SelectedValue,
                GraduationYear = gradYear,
                Cgpa = cgpa,
                PlacementEligibility = ddlFormEligibility.SelectedValue,
                PlacementStatus = ddlFormPlacementStatus.SelectedValue,
                CompanyPlaced = string.IsNullOrWhiteSpace(txtCompanyPlaced.Text) ? null : txtCompanyPlaced.Text.Trim(),
                PackageLpa = packageLpa,
                TechnicalSkills = txtTechnicalSkills.Text.Trim(),
                GithubProfile = string.IsNullOrWhiteSpace(txtGithub.Text) ? null : txtGithub.Text.Trim(),
                LinkedinProfile = string.IsNullOrWhiteSpace(txtLinkedin.Text) ? null : txtLinkedin.Text.Trim(),
                ResumeStatus = "Parsed & ATS Verified",
                AtsScore = (int)Math.Min(98, Math.Max(50, (cgpa * 10))),
                ReadinessScore = (int)Math.Min(95, Math.Max(45, (cgpa * 9.5))),
                AssessmentsCompleted = 10,
                InterviewCount = 2,
                ActiveApplications = string.Equals(ddlFormPlacementStatus.SelectedValue, "Placed", StringComparison.OrdinalIgnoreCase)
                    ? (string.IsNullOrEmpty(txtCompanyPlaced.Text) ? "Campus Drive Offer" : txtCompanyPlaced.Text.Trim() + " (Offer Accepted)")
                    : "Active in Campus Placement Pool"
            };

            try
            {
                if (isNew)
                {
                    _repo.CreateStudent(student);
                    ShowMessage("Student <strong>" + Server.HtmlEncode(student.FullName) + "</strong> added successfully (In-Memory Sample Store).", false);
                }
                else
                {
                    var existing = _repo.GetById(editId);
                    student.AvatarClass = existing != null ? existing.AvatarClass : "users-avatar avatar-blue";
                    student.AtsScore = existing != null ? existing.AtsScore : student.AtsScore;
                    student.ReadinessScore = existing != null ? existing.ReadinessScore : student.ReadinessScore;
                    student.AssessmentsCompleted = existing != null ? existing.AssessmentsCompleted : 10;
                    student.InterviewCount = existing != null ? existing.InterviewCount : 2;
                    student.ActiveApplications = existing != null ? existing.ActiveApplications : student.ActiveApplications;
                    _repo.UpdateStudent(student);
                    ShowMessage("Student <strong>" + Server.HtmlEncode(student.FullName) + "</strong> updated successfully (In-Memory Sample Store).", false);
                }

                pnlStudentModal.Visible = false;
                BindKpis();
                BindFilters();
                BindPage();
            }
            catch (Exception ex)
            {
                ShowMessage(ex.Message, true);
                pnlStudentModal.Visible = true;
            }
        }

        private void OpenDossierModal(int studentId)
        {
            var student = _repo.GetById(studentId);
            if (student == null)
            {
                ShowMessage("Student record not found.", true);
                return;
            }

            litDossierInitials.Text = Server.HtmlEncode(student.Initials);
            litDossierName.Text = Server.HtmlEncode(student.FullName);
            litDossierEnrollment.Text = Server.HtmlEncode(student.EnrollmentId);
            litDossierEmail.Text = Server.HtmlEncode(student.Email);
            litDossierDept.Text = Server.HtmlEncode(student.Department);
            litDossierBatch.Text = student.GraduationYear.ToString(CultureInfo.InvariantCulture);

            badgeDossierElig.Attributes["class"] = student.EligibilityClass;
            litDossierElig.Text = Server.HtmlEncode(student.PlacementEligibility);

            badgeDossierStatus.Attributes["class"] = student.PlacementStatusClass;
            litDossierStatus.Text = Server.HtmlEncode(student.PlacementStatus) +
                (!string.IsNullOrEmpty(student.CompanyPlaced) ? " (" + Server.HtmlEncode(student.CompanyPlaced) + ")" : "");

            litDossierPri.Text = student.ReadinessScore.ToString(CultureInfo.InvariantCulture);
            litDossierAts.Text = student.AtsScore.ToString(CultureInfo.InvariantCulture);
            litDossierCgpa.Text = student.CgpaDisplay;
            litDossierTests.Text = student.AssessmentsCompleted.ToString(CultureInfo.InvariantCulture);

            // Skills chips
            if (!string.IsNullOrWhiteSpace(student.TechnicalSkills))
            {
                var chips = student.TechnicalSkills.Split(new[] { ',', ';' }, StringSplitOptions.RemoveEmptyEntries)
                    .Select(s => "<span class='dossier-skill-tag'>" + Server.HtmlEncode(s.Trim()) + "</span>");
                litDossierSkills.Text = string.Join(" ", chips);
            }
            else
            {
                litDossierSkills.Text = "<span class='users-hint'>No verified technical skill tags recorded yet.</span>";
            }

            if (student.Applications != null && student.Applications.Count > 0)
            {
                var sb = new System.Text.StringBuilder();
                sb.Append("<div class='table-scroll'><table class='users-table compact-table'>");
                sb.Append("<thead><tr><th>Company &amp; Role</th><th>Recruitment Stage</th><th>Application Status</th><th>Offer CTC</th><th>Date</th></tr></thead><tbody>");
                foreach (var app in student.Applications)
                {
                    sb.Append("<tr>");
                    sb.AppendFormat("<td><strong>{0}</strong><br/><small class='placed-company'>{1}</small></td>",
                        Server.HtmlEncode(app.CompanyName), Server.HtmlEncode(app.JobRole));
                    sb.AppendFormat("<td><span class='qb-code'>{0}</span></td>", Server.HtmlEncode(app.RecruitmentStage));
                    sb.AppendFormat("<td><span class='{0}'><i></i>{1}</span></td>",
                        app.StatusBadgeClass, Server.HtmlEncode(app.ApplicationStatus));
                    sb.AppendFormat("<td><strong>{0}</strong></td>",
                        app.OfferPackageLpa.HasValue ? app.OfferPackageLpa.Value.ToString("0.0", CultureInfo.InvariantCulture) + " LPA" : "<span class='users-hint'>-</span>");
                    sb.AppendFormat("<td><small class='text-muted'>{0}</small></td>", Server.HtmlEncode(app.AppliedDate ?? "-"));
                    sb.Append("</tr>");
                }
                sb.Append("</tbody></table></div>");
                litDossierPipeline.Text = sb.ToString();
            }
            else
            {
                litDossierPipeline.Text = string.IsNullOrEmpty(student.ActiveApplications)
                    ? "<span class='users-hint'>No active recruitment applications.</span>"
                    : Server.HtmlEncode(student.ActiveApplications);
            }

            litDossierGithub.Text = string.IsNullOrEmpty(student.GithubProfile) ? "Not provided" : Server.HtmlEncode(student.GithubProfile);
            litDossierLinkedin.Text = string.IsNullOrEmpty(student.LinkedinProfile) ? "Not provided" : Server.HtmlEncode(student.LinkedinProfile);
            btnFullDossierPage.HRef = ResolveUrl("~/Admin/StudentDetails.aspx?id=" + student.StudentId);

            pnlDossierModal.Visible = true;
            pnlStudentModal.Visible = false;
        }

        private void OpenEditModal(int studentId)
        {
            var student = _repo.GetById(studentId);
            if (student == null)
            {
                ShowMessage("Student record not found.", true);
                return;
            }

            hfEditStudentId.Value = student.StudentId.ToString(CultureInfo.InvariantCulture);
            litModalTitle.Text = "Edit Student Record";
            txtFullName.Text = student.FullName;
            txtEnrollmentId.Text = student.EnrollmentId;
            txtEmail.Text = student.Email;
            if (ddlFormDepartment.Items.FindByValue(student.Department) != null)
                ddlFormDepartment.SelectedValue = student.Department;
            txtGradYear.Text = student.GraduationYear.ToString(CultureInfo.InvariantCulture);
            txtCgpa.Text = student.Cgpa.ToString("0.00", CultureInfo.InvariantCulture);
            if (ddlFormEligibility.Items.FindByValue(student.PlacementEligibility) != null)
                ddlFormEligibility.SelectedValue = student.PlacementEligibility;
            if (ddlFormPlacementStatus.Items.FindByValue(student.PlacementStatus) != null)
                ddlFormPlacementStatus.SelectedValue = student.PlacementStatus;
            txtCompanyPlaced.Text = student.CompanyPlaced ?? string.Empty;
            txtPackageLpa.Text = student.PackageLpa.HasValue ? student.PackageLpa.Value.ToString("0.0", CultureInfo.InvariantCulture) : string.Empty;
            txtTechnicalSkills.Text = student.TechnicalSkills ?? string.Empty;
            txtGithub.Text = student.GithubProfile ?? string.Empty;
            txtLinkedin.Text = student.LinkedinProfile ?? string.Empty;

            pnlStudentModal.Visible = true;
            pnlDossierModal.Visible = false;
        }

        private void BindFilters()
        {
            var selDept = ddlDepartmentFilter.SelectedValue;
            ddlDepartmentFilter.Items.Clear();
            ddlDepartmentFilter.Items.Add(new ListItem("All Departments", "All"));
            foreach (var d in _repo.GetDepartments())
            {
                ddlDepartmentFilter.Items.Add(new ListItem(d, d));
            }
            if (!string.IsNullOrEmpty(selDept) && ddlDepartmentFilter.Items.FindByValue(selDept) != null)
                ddlDepartmentFilter.SelectedValue = selDept;

            var selBatch = ddlBatchFilter.SelectedValue;
            ddlBatchFilter.Items.Clear();
            ddlBatchFilter.Items.Add(new ListItem("All Batches", "All"));
            foreach (var y in _repo.GetGraduationYears())
            {
                ddlBatchFilter.Items.Add(new ListItem("Class of " + y, y.ToString(CultureInfo.InvariantCulture)));
            }
            if (!string.IsNullOrEmpty(selBatch) && ddlBatchFilter.Items.FindByValue(selBatch) != null)
                ddlBatchFilter.SelectedValue = selBatch;
        }

        private void BindPage()
        {
            var result = _repo.SearchStudents(
                txtSearch.Text,
                ddlDepartmentFilter.SelectedValue,
                ddlBatchFilter.SelectedValue,
                ddlEligibilityFilter.SelectedValue,
                ddlPlacementStatusFilter.SelectedValue,
                CurrentPageIndex,
                CurrentPageSize);

            _totalPages = Math.Max(1, result.TotalPages);
            if (CurrentPageIndex > _totalPages)
            {
                CurrentPageIndex = _totalPages;
                result = _repo.SearchStudents(
                    txtSearch.Text,
                    ddlDepartmentFilter.SelectedValue,
                    ddlBatchFilter.SelectedValue,
                    ddlEligibilityFilter.SelectedValue,
                    ddlPlacementStatusFilter.SelectedValue,
                    CurrentPageIndex,
                    CurrentPageSize);
                _totalPages = Math.Max(1, result.TotalPages);
            }

            rptStudents.DataSource = result.Items;
            rptStudents.DataBind();
            pnlEmpty.Visible = result.Items.Count == 0;

            var start = result.TotalCount == 0 ? 0 : ((result.PageIndex - 1) * result.PageSize) + 1;
            var end = Math.Min(result.PageIndex * result.PageSize, result.TotalCount);
            litPageInfo.Text = string.Format(
                CultureInfo.InvariantCulture,
                "Showing {0} to {1} of {2} students",
                start, end, result.TotalCount);

            btnPrevPage.Enabled = result.PageIndex > 1;
            btnNextPage.Enabled = result.PageIndex < _totalPages;
            BindPageNumbers(result.PageIndex, _totalPages);
        }

        private void BindKpis()
        {
            var kpi = _repo.GetKpiSummary();
            litTotalStudents.Text = kpi.TotalStudents.ToString("N0", CultureInfo.InvariantCulture);
            litEligibleCount.Text = kpi.EligibleCount.ToString("N0", CultureInfo.InvariantCulture);
            litPlacedCount.Text = kpi.PlacedCount.ToString("N0", CultureInfo.InvariantCulture);
            litIncompleteCount.Text = kpi.ProfilesIncomplete.ToString("N0", CultureInfo.InvariantCulture);
        }

        private void BindPageNumbers(int current, int total)
        {
            var pages = new List<object>();
            var start = Math.Max(1, current - 2);
            var end = Math.Min(total, start + 4);
            start = Math.Max(1, end - 4);

            for (var i = start; i <= end; i++)
            {
                pages.Add(new { PageNumber = i, IsCurrent = i == current });
            }

            rptPages.DataSource = pages;
            rptPages.DataBind();
        }

        private void ShowMessage(string html, bool isError)
        {
            pnlMessage.Visible = true;
            pnlMessage.CssClass = isError ? "users-alert error" : "users-alert success";
            litMessage.Text = html;
        }

        private void ClearMessage()
        {
            pnlMessage.Visible = false;
            litMessage.Text = string.Empty;
        }
    }
}

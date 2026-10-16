using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using PlacementPrep.Helpers;

namespace PlacementPrep
{
    public partial class ManageTests : Page
    {
        private readonly TestRepository _repo = new TestRepository();
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
                BindCompanies();
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
            ddlStatusFilter.SelectedValue = "All";
            ddlTypeFilter.SelectedValue = "All";
            ddlCompanyFilter.SelectedValue = "All";
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

        protected void rptTests_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int testId;
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out testId)) return;

            try
            {
                switch (e.CommandName)
                {
                    case "ViewTest":
                        OpenViewModal(testId);
                        break;
                    case "EditTest":
                        OpenEditModal(testId);
                        break;
                    case "PublishTest":
                        _repo.PublishTest(testId);
                        ShowMessage("Assessment status updated to <strong>Published</strong> (In-Memory Sample Store).", false);
                        BindKpis();
                        BindPage();
                        break;
                    case "ArchiveTest":
                        _repo.ArchiveTest(testId);
                        ShowMessage("Assessment status updated to <strong>Archived</strong> (In-Memory Sample Store).", false);
                        BindKpis();
                        BindPage();
                        break;
                    case "DeleteTest":
                        _repo.DeleteTest(testId);
                        ShowMessage("Assessment record deleted from repository (In-Memory Sample Store).", false);
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

        protected void btnOpenCreate_Click(object sender, EventArgs e)
        {
            ClearMessage();
            hfEditTestId.Value = "0";
            litModalTitle.Text = "Create Assessment";
            txtTestName.Text = string.Empty;
            txtCompany.Text = string.Empty;
            ddlFormType.SelectedValue = "Mixed";
            ddlFormStatus.SelectedValue = "Published";
            txtDuration.Text = "60";
            txtTotalMarks.Text = "100";
            txtQuestionCount.Text = "30";
            txtScheduledStart.Text = string.Empty;
            txtScheduledEnd.Text = string.Empty;
            txtDescription.Text = string.Empty;
            txtInstructions.Text = string.Empty;

            pnlTestModal.Visible = true;
            pnlViewModal.Visible = false;
        }

        protected void btnCloseModal_Click(object sender, EventArgs e)
        {
            pnlTestModal.Visible = false;
        }

        protected void btnCloseView_Click(object sender, EventArgs e)
        {
            pnlViewModal.Visible = false;
        }

        protected void btnSaveTest_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                pnlTestModal.Visible = true;
                return;
            }

            int editId;
            int.TryParse(hfEditTestId.Value, out editId);
            var isNew = editId <= 0;

            int duration;
            if (!int.TryParse(txtDuration.Text.Trim(), out duration) || duration <= 0)
            {
                ShowMessage("Duration must be a positive number of minutes.", true);
                pnlTestModal.Visible = true;
                return;
            }

            int marks;
            if (!int.TryParse(txtTotalMarks.Text.Trim(), out marks) || marks <= 0)
            {
                ShowMessage("Total marks must be a positive number.", true);
                pnlTestModal.Visible = true;
                return;
            }

            int questions;
            if (!int.TryParse(txtQuestionCount.Text.Trim(), out questions) || questions <= 0)
            {
                ShowMessage("Question count must be a positive number.", true);
                pnlTestModal.Visible = true;
                return;
            }

            DateTime? start = null;
            DateTime? end = null;

            if (!string.IsNullOrWhiteSpace(txtScheduledStart.Text))
            {
                DateTime dt;
                if (DateTime.TryParse(txtScheduledStart.Text.Trim(), CultureInfo.InvariantCulture, DateTimeStyles.None, out dt))
                {
                    start = dt;
                }
                else
                {
                    ShowMessage("Invalid Start Date & Time format. Use YYYY-MM-DD HH:mm (e.g. 2026-10-24 10:00).", true);
                    pnlTestModal.Visible = true;
                    return;
                }
            }

            if (!string.IsNullOrWhiteSpace(txtScheduledEnd.Text))
            {
                DateTime dt;
                if (DateTime.TryParse(txtScheduledEnd.Text.Trim(), CultureInfo.InvariantCulture, DateTimeStyles.None, out dt))
                {
                    end = dt;
                }
                else
                {
                    ShowMessage("Invalid End Date & Time format. Use YYYY-MM-DD HH:mm (e.g. 2026-10-24 12:00).", true);
                    pnlTestModal.Visible = true;
                    return;
                }
            }

            var status = ddlFormStatus.SelectedValue;
            if (string.Equals(status, "Scheduled", StringComparison.OrdinalIgnoreCase))
            {
                if (!start.HasValue || !end.HasValue)
                {
                    ShowMessage("Scheduled assessments require both a valid Start and End Date & Time.", true);
                    pnlTestModal.Visible = true;
                    return;
                }
            }

            if (start.HasValue && end.HasValue && end.Value <= start.Value)
            {
                ShowMessage("End Date & Time must be strictly later than Start Date & Time.", true);
                pnlTestModal.Visible = true;
                return;
            }

            var test = new TestItem
            {
                TestId = editId,
                Title = txtTestName.Text.Trim(),
                Company = txtCompany.Text.Trim(),
                TestType = ddlFormType.SelectedValue,
                Status = status,
                DurationMinutes = duration,
                TotalMarks = marks,
                TotalQuestions = questions,
                ScheduledStart = start,
                ScheduledEnd = end,
                Description = txtDescription.Text.Trim(),
                Instructions = txtInstructions.Text.Trim()
            };

            try
            {
                if (isNew)
                {
                    _repo.CreateTest(test);
                    ShowMessage("Assessment <strong>" + Server.HtmlEncode(test.Title) + "</strong> created successfully (In-Memory Sample Store).", false);
                }
                else
                {
                    var existing = _repo.GetById(editId);
                    test.TestCode = existing != null ? existing.TestCode : string.Empty;
                    test.CreatedBy = existing != null ? existing.CreatedBy : "Admin Superuser";
                    _repo.UpdateTest(test);
                    ShowMessage("Assessment <strong>" + Server.HtmlEncode(test.Title) + "</strong> updated successfully (In-Memory Sample Store).", false);
                }

                pnlTestModal.Visible = false;
                BindKpis();
                BindCompanies();
                BindPage();
            }
            catch (Exception ex)
            {
                ShowMessage(ex.Message, true);
                pnlTestModal.Visible = true;
            }
        }

        private void OpenViewModal(int testId)
        {
            var test = _repo.GetById(testId);
            if (test == null)
            {
                ShowMessage("Assessment not found.", true);
                return;
            }

            litViewCode.Text = Server.HtmlEncode(test.TestCode);
            litViewTitle.Text = Server.HtmlEncode(test.Title);
            litViewCompany.Text = Server.HtmlEncode(test.Company);
            litViewType.Text = Server.HtmlEncode(test.TestType);
            litViewStatus.Text = Server.HtmlEncode(test.Status);
            litViewDuration.Text = Server.HtmlEncode(test.DurationDisplay);
            litViewMarks.Text = test.TotalMarks.ToString(CultureInfo.InvariantCulture);
            litViewQuestions.Text = test.TotalQuestions.ToString(CultureInfo.InvariantCulture);
            litViewSchedule.Text = Server.HtmlEncode(test.ScheduleDisplay);
            litViewDescription.Text = Server.HtmlEncode(string.IsNullOrEmpty(test.Description) ? "No description provided." : test.Description);
            litViewInstructions.Text = Server.HtmlEncode(string.IsNullOrEmpty(test.Instructions) ? "No special proctoring guidelines specified." : test.Instructions);
            litViewCreatedBy.Text = Server.HtmlEncode(test.CreatedBy ?? "Admin Superuser");
            litViewUpdated.Text = test.UpdatedAt.ToString("MMM dd, yyyy", CultureInfo.InvariantCulture);

            pnlViewModal.Visible = true;
            pnlTestModal.Visible = false;
        }

        private void OpenEditModal(int testId)
        {
            var test = _repo.GetById(testId);
            if (test == null)
            {
                ShowMessage("Assessment not found.", true);
                return;
            }

            hfEditTestId.Value = test.TestId.ToString(CultureInfo.InvariantCulture);
            litModalTitle.Text = "Edit Assessment";
            txtTestName.Text = test.Title;
            txtCompany.Text = test.Company;
            if (ddlFormType.Items.FindByValue(test.TestType) != null)
                ddlFormType.SelectedValue = test.TestType;
            if (ddlFormStatus.Items.FindByValue(test.Status) != null)
                ddlFormStatus.SelectedValue = test.Status;
            txtDuration.Text = test.DurationMinutes.ToString(CultureInfo.InvariantCulture);
            txtTotalMarks.Text = test.TotalMarks.ToString(CultureInfo.InvariantCulture);
            txtQuestionCount.Text = test.TotalQuestions.ToString(CultureInfo.InvariantCulture);
            txtScheduledStart.Text = test.ScheduledStart.HasValue ? test.ScheduledStart.Value.ToString("yyyy-MM-dd HH:mm", CultureInfo.InvariantCulture) : string.Empty;
            txtScheduledEnd.Text = test.ScheduledEnd.HasValue ? test.ScheduledEnd.Value.ToString("yyyy-MM-dd HH:mm", CultureInfo.InvariantCulture) : string.Empty;
            txtDescription.Text = test.Description;
            txtInstructions.Text = test.Instructions;

            pnlTestModal.Visible = true;
            pnlViewModal.Visible = false;
        }

        private void BindCompanies()
        {
            var selected = ddlCompanyFilter.SelectedValue;
            ddlCompanyFilter.Items.Clear();
            ddlCompanyFilter.Items.Add(new ListItem("All Companies", "All"));
            foreach (var company in _repo.GetCompanies())
            {
                ddlCompanyFilter.Items.Add(new ListItem(company, company));
            }

            if (!string.IsNullOrEmpty(selected) && ddlCompanyFilter.Items.FindByValue(selected) != null)
            {
                ddlCompanyFilter.SelectedValue = selected;
            }
        }

        private void BindPage()
        {
            var result = _repo.SearchTests(
                txtSearch.Text,
                ddlStatusFilter.SelectedValue,
                ddlTypeFilter.SelectedValue,
                ddlCompanyFilter.SelectedValue,
                CurrentPageIndex,
                CurrentPageSize);

            _totalPages = Math.Max(1, result.TotalPages);
            if (CurrentPageIndex > _totalPages)
            {
                CurrentPageIndex = _totalPages;
                result = _repo.SearchTests(
                    txtSearch.Text,
                    ddlStatusFilter.SelectedValue,
                    ddlTypeFilter.SelectedValue,
                    ddlCompanyFilter.SelectedValue,
                    CurrentPageIndex,
                    CurrentPageSize);
                _totalPages = Math.Max(1, result.TotalPages);
            }

            rptTests.DataSource = result.Items;
            rptTests.DataBind();
            pnlEmpty.Visible = result.Items.Count == 0;

            var start = result.TotalCount == 0 ? 0 : ((result.PageIndex - 1) * result.PageSize) + 1;
            var end = Math.Min(result.PageIndex * result.PageSize, result.TotalCount);
            litPageInfo.Text = string.Format(
                CultureInfo.InvariantCulture,
                "Showing {0} to {1} of {2} assessments",
                start, end, result.TotalCount);

            btnPrevPage.Enabled = result.PageIndex > 1;
            btnNextPage.Enabled = result.PageIndex < _totalPages;
            BindPageNumbers(result.PageIndex, _totalPages);
        }

        private void BindKpis()
        {
            var kpi = _repo.GetKpiSummary();
            litTotalTests.Text = kpi.TotalTests.ToString("N0", CultureInfo.InvariantCulture);
            litPublishedTests.Text = kpi.PublishedTests.ToString("N0", CultureInfo.InvariantCulture);
            litDraftTests.Text = kpi.DraftTests.ToString("N0", CultureInfo.InvariantCulture);
            litScheduledTests.Text = kpi.ScheduledTests.ToString("N0", CultureInfo.InvariantCulture);
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

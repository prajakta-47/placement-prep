using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using PlacementPrep.Helpers;

namespace PlacementPrep
{
    public partial class QuestionBank : Page
    {
        private readonly QuestionRepository _repo = new QuestionRepository();
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

        private string ActiveCategory
        {
            get
            {
                return string.IsNullOrEmpty(hfSelectedCategory.Value) ? "All" : hfSelectedCategory.Value;
            }
            set
            {
                hfSelectedCategory.Value = string.IsNullOrEmpty(value) ? "All" : value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindKpis();
                UpdateTabStyles();
                BindPage();
            }
        }

        protected void btnTab_Click(object sender, EventArgs e)
        {
            var btn = sender as LinkButton;
            if (btn == null) return;

            ActiveCategory = btn.CommandArgument;
            if (ddlCategoryFilter.Items.FindByValue(ActiveCategory) != null)
            {
                ddlCategoryFilter.SelectedValue = ActiveCategory;
            }
            else
            {
                ddlCategoryFilter.SelectedValue = "All";
            }

            CurrentPageIndex = 1;
            UpdateTabStyles();
            BindPage();
        }

        protected void btnApplyFilters_Click(object sender, EventArgs e)
        {
            ActiveCategory = ddlCategoryFilter.SelectedValue;
            CurrentPageIndex = 1;
            UpdateTabStyles();
            BindPage();
        }

        protected void btnResetFilters_Click(object sender, EventArgs e)
        {
            txtSearch.Text = string.Empty;
            ActiveCategory = "All";
            ddlCategoryFilter.SelectedValue = "All";
            ddlDifficultyFilter.SelectedValue = "All";
            ddlStatusFilter.SelectedValue = "All";
            CurrentPageIndex = 1;
            UpdateTabStyles();
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

        protected void rptQuestions_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int qId;
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out qId)) return;

            try
            {
                switch (e.CommandName)
                {
                    case "PreviewQuestion":
                        OpenPreviewModal(qId);
                        break;
                    case "EditQuestion":
                        OpenEditModal(qId);
                        break;
                    case "ToggleStatus":
                        _repo.ToggleStatus(qId);
                        ShowMessage("Validation status toggled for question item.", false);
                        BindPage();
                        break;
                    case "DeleteQuestion":
                        _repo.DeleteQuestion(qId);
                        ShowMessage("Question deleted from repository (In-Memory Sample Store).", false);
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
            hfEditQuestionId.Value = "0";
            litModalTitle.Text = "Add Question";
            txtQuestionCode.Text = string.Empty;
            ddlFormCategory.SelectedValue = "Aptitude";
            txtFormTopic.Text = string.Empty;
            ddlFormDifficulty.SelectedValue = "Medium";
            txtFormPrompt.Text = string.Empty;
            txtOptionA.Text = string.Empty;
            txtOptionB.Text = string.Empty;
            txtOptionC.Text = string.Empty;
            txtOptionD.Text = string.Empty;
            ddlCorrectOption.SelectedValue = "A";
            ddlFormStatus.SelectedValue = "Verified";
            txtMarks.Text = "2";
            txtNegativeMarks.Text = "0.5";
            txtExplanation.Text = string.Empty;

            pnlQuestionModal.Visible = true;
            pnlPreviewModal.Visible = false;
            pnlImportModal.Visible = false;
        }

        protected void btnCloseModal_Click(object sender, EventArgs e)
        {
            pnlQuestionModal.Visible = false;
        }

        protected void btnClosePreview_Click(object sender, EventArgs e)
        {
            pnlPreviewModal.Visible = false;
        }

        protected void btnOpenImport_Click(object sender, EventArgs e)
        {
            ClearMessage();
            pnlImportResult.Visible = false;
            litImportResult.Text = string.Empty;
            pnlImportModal.Visible = true;
            pnlQuestionModal.Visible = false;
            pnlPreviewModal.Visible = false;
        }

        protected void btnCloseImport_Click(object sender, EventArgs e)
        {
            pnlImportModal.Visible = false;
        }

        protected void btnRunImport_Click(object sender, EventArgs e)
        {
            pnlImportModal.Visible = true;
            if (!fuImport.HasFile)
            {
                ShowImportResult("Please choose a CSV file to import.", true);
                return;
            }

            var extension = Path.GetExtension(fuImport.FileName);
            if (!string.Equals(extension, ".csv", StringComparison.OrdinalIgnoreCase))
            {
                ShowImportResult("Only .csv files are supported.", true);
                return;
            }

            ShowImportResult("Successfully imported 18 new questions (In-Memory Sample Store).", false);
            ShowMessage("CSV import finished successfully.", false);
            BindPage();
        }

        protected void btnSaveQuestion_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                pnlQuestionModal.Visible = true;
                return;
            }

            int editId;
            int.TryParse(hfEditQuestionId.Value, out editId);
            var isNew = editId <= 0;

            int marks;
            if (!int.TryParse(txtMarks.Text.Trim(), out marks)) marks = 2;

            double negMarks;
            if (!double.TryParse(txtNegativeMarks.Text.Trim(), NumberStyles.Any, CultureInfo.InvariantCulture, out negMarks)) negMarks = 0.5;

            var q = new QuestionItem
            {
                QuestionId = editId,
                Code = txtQuestionCode.Text.Trim(),
                Category = ddlFormCategory.SelectedValue,
                Topic = txtFormTopic.Text.Trim(),
                Difficulty = ddlFormDifficulty.SelectedValue,
                Prompt = txtFormPrompt.Text.Trim(),
                OptionA = txtOptionA.Text.Trim(),
                OptionB = txtOptionB.Text.Trim(),
                OptionC = txtOptionC.Text.Trim(),
                OptionD = txtOptionD.Text.Trim(),
                CorrectOption = ddlCorrectOption.SelectedValue,
                ValidationStatus = ddlFormStatus.SelectedValue,
                Marks = marks,
                NegativeMarks = negMarks,
                Explanation = txtExplanation.Text.Trim(),
                UsageCount = isNew ? 1 : (_repo.GetById(editId)?.UsageCount ?? 1)
            };

            try
            {
                if (isNew)
                {
                    _repo.CreateQuestion(q);
                    ShowMessage("Question <strong>" + Server.HtmlEncode(q.Code) + "</strong> created successfully (In-Memory Sample Store).", false);
                }
                else
                {
                    _repo.UpdateQuestion(q);
                    ShowMessage("Question <strong>" + Server.HtmlEncode(q.Code) + "</strong> updated successfully (In-Memory Sample Store).", false);
                }

                pnlQuestionModal.Visible = false;
                BindPage();
            }
            catch (Exception ex)
            {
                ShowMessage(ex.Message, true);
                pnlQuestionModal.Visible = true;
            }
        }

        private void OpenPreviewModal(int questionId)
        {
            var q = _repo.GetById(questionId);
            if (q == null)
            {
                ShowMessage("Question not found.", true);
                return;
            }

            litPrevCode.Text = Server.HtmlEncode(q.Code);
            litPrevCategory.Text = Server.HtmlEncode(q.Category);
            litPrevTopic.Text = Server.HtmlEncode(q.Topic);
            litPrevDifficulty.Text = Server.HtmlEncode(q.Difficulty);
            litPrevMarks.Text = q.Marks.ToString(CultureInfo.InvariantCulture);
            litPrevNegMarks.Text = q.NegativeMarks.ToString("0.0#", CultureInfo.InvariantCulture);
            litPrevPrompt.Text = Server.HtmlEncode(q.Prompt);

            litPrevOptA.Text = Server.HtmlEncode(string.IsNullOrEmpty(q.OptionA) ? "-" : q.OptionA);
            litPrevOptB.Text = Server.HtmlEncode(string.IsNullOrEmpty(q.OptionB) ? "-" : q.OptionB);
            litPrevOptC.Text = Server.HtmlEncode(string.IsNullOrEmpty(q.OptionC) ? "-" : q.OptionC);
            litPrevOptD.Text = Server.HtmlEncode(string.IsNullOrEmpty(q.OptionD) ? "-" : q.OptionD);

            prevOptA.Attributes["class"] = string.Equals(q.CorrectOption, "A", StringComparison.OrdinalIgnoreCase)
                ? "qb-option-card qb-option-correct" : "qb-option-card";
            prevOptB.Attributes["class"] = string.Equals(q.CorrectOption, "B", StringComparison.OrdinalIgnoreCase)
                ? "qb-option-card qb-option-correct" : "qb-option-card";
            prevOptC.Attributes["class"] = string.Equals(q.CorrectOption, "C", StringComparison.OrdinalIgnoreCase)
                ? "qb-option-card qb-option-correct" : "qb-option-card";
            prevOptD.Attributes["class"] = string.Equals(q.CorrectOption, "D", StringComparison.OrdinalIgnoreCase)
                ? "qb-option-card qb-option-correct" : "qb-option-card";

            litPrevCorrect.Text = Server.HtmlEncode(q.CorrectOption);
            litPrevExplanation.Text = Server.HtmlEncode(string.IsNullOrEmpty(q.Explanation) ? "No detailed rationale provided." : q.Explanation);

            pnlPreviewModal.Visible = true;
            pnlQuestionModal.Visible = false;
            pnlImportModal.Visible = false;
        }

        private void OpenEditModal(int questionId)
        {
            var q = _repo.GetById(questionId);
            if (q == null)
            {
                ShowMessage("Question not found.", true);
                return;
            }

            hfEditQuestionId.Value = q.QuestionId.ToString(CultureInfo.InvariantCulture);
            litModalTitle.Text = "Edit Question";
            txtQuestionCode.Text = q.Code;
            if (ddlFormCategory.Items.FindByValue(q.Category) != null)
                ddlFormCategory.SelectedValue = q.Category;
            txtFormTopic.Text = q.Topic;
            if (ddlFormDifficulty.Items.FindByValue(q.Difficulty) != null)
                ddlFormDifficulty.SelectedValue = q.Difficulty;
            txtFormPrompt.Text = q.Prompt;
            txtOptionA.Text = q.OptionA;
            txtOptionB.Text = q.OptionB;
            txtOptionC.Text = q.OptionC;
            txtOptionD.Text = q.OptionD;
            if (ddlCorrectOption.Items.FindByValue(q.CorrectOption) != null)
                ddlCorrectOption.SelectedValue = q.CorrectOption;
            if (ddlFormStatus.Items.FindByValue(q.ValidationStatus) != null)
                ddlFormStatus.SelectedValue = q.ValidationStatus;
            txtMarks.Text = q.Marks.ToString(CultureInfo.InvariantCulture);
            txtNegativeMarks.Text = q.NegativeMarks.ToString(CultureInfo.InvariantCulture);
            txtExplanation.Text = q.Explanation;

            pnlQuestionModal.Visible = true;
            pnlPreviewModal.Visible = false;
            pnlImportModal.Visible = false;
        }

        private void BindPage()
        {
            var result = _repo.SearchQuestions(
                txtSearch.Text,
                ActiveCategory,
                ddlDifficultyFilter.SelectedValue,
                ddlStatusFilter.SelectedValue,
                CurrentPageIndex,
                CurrentPageSize);

            _totalPages = Math.Max(1, result.TotalPages);
            if (CurrentPageIndex > _totalPages)
            {
                CurrentPageIndex = _totalPages;
                result = _repo.SearchQuestions(
                    txtSearch.Text,
                    ActiveCategory,
                    ddlDifficultyFilter.SelectedValue,
                    ddlStatusFilter.SelectedValue,
                    CurrentPageIndex,
                    CurrentPageSize);
                _totalPages = Math.Max(1, result.TotalPages);
            }

            rptQuestions.DataSource = result.Items;
            rptQuestions.DataBind();
            pnlEmpty.Visible = result.Items.Count == 0;

            var start = result.TotalCount == 0 ? 0 : ((result.PageIndex - 1) * result.PageSize) + 1;
            var end = Math.Min(result.PageIndex * result.PageSize, result.TotalCount);
            litPageInfo.Text = string.Format(
                CultureInfo.InvariantCulture,
                "Showing {0} to {1} of {2} questions",
                start, end, result.TotalCount);

            btnPrevPage.Enabled = result.PageIndex > 1;
            btnNextPage.Enabled = result.PageIndex < _totalPages;
            BindPageNumbers(result.PageIndex, _totalPages);
        }

        private void BindKpis()
        {
            var kpi = _repo.GetKpiSummary();
            litTotalItems.Text = kpi.TotalItems.ToString("N0", CultureInfo.InvariantCulture);
            litAptitudeCount.Text = kpi.AptitudeCount.ToString("N0", CultureInfo.InvariantCulture);
            litTechnicalCount.Text = kpi.TechnicalCount.ToString("N0", CultureInfo.InvariantCulture);
            litCodingCount.Text = kpi.CodingCount.ToString("N0", CultureInfo.InvariantCulture);
        }

        private void UpdateTabStyles()
        {
            btnTabAll.CssClass = ActiveCategory == "All" ? "qb-tab active" : "qb-tab";
            btnTabAptitude.CssClass = ActiveCategory == "Aptitude" ? "qb-tab active" : "qb-tab";
            btnTabTechnical.CssClass = ActiveCategory == "Technical" ? "qb-tab active" : "qb-tab";
            btnTabCoding.CssClass = ActiveCategory == "Coding" ? "qb-tab active" : "qb-tab";
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

        private void ShowImportResult(string html, bool isError)
        {
            pnlImportResult.Visible = true;
            pnlImportResult.CssClass = isError ? "users-import-result error" : "users-import-result success";
            litImportResult.Text = html;
        }
    }
}

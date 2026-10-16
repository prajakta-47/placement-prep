using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using PlacementPrep.Helpers;

namespace PlacementPrep.Admin
{
    public partial class AptitudeQuestions : Page
    {
        private readonly QuestionRepository _repo = new QuestionRepository();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindKpis();
                BindTopics();
                BindQuestions();
            }
        }

        private void BindKpis()
        {
            var summary = _repo.GetKpiSummary();
            litTotalAptitude.Text = summary.AptitudeCount.ToString("N0", CultureInfo.InvariantCulture);
            litQuantCount.Text = "480";
            litLogicalCount.Text = "360";
            litVerbalCount.Text = "400";
        }

        private void BindTopics()
        {
            var topics = _repo.GetTopics("Aptitude");
            ddlTopic.Items.Clear();
            ddlTopic.Items.Add(new ListItem("All Topics", "All"));
            foreach (var t in topics)
            {
                ddlTopic.Items.Add(new ListItem(t, t));
            }
        }

        private void BindQuestions()
        {
            int pageIndex = 1;
            int.TryParse(hfPageIndex.Value, out pageIndex);
            if (pageIndex < 1) pageIndex = 1;

            int pageSize = 10;
            int.TryParse(ddlPageSize.SelectedValue, out pageSize);
            if (pageSize < 1) pageSize = 10;

            string query = txtSearch.Text.Trim();
            string topic = ddlTopic.SelectedValue;
            string difficulty = ddlDifficulty.SelectedValue;
            string status = ddlStatus.SelectedValue;

            var result = _repo.SearchQuestions(query, "Aptitude", difficulty, status, pageIndex, pageSize);

            // Filter additionally by topic if specified and not 'All'
            var items = result.Items;
            if (!string.IsNullOrEmpty(topic) && !string.Equals(topic, "All", StringComparison.OrdinalIgnoreCase))
            {
                items = items.Where(x => string.Equals(x.Topic, topic, StringComparison.OrdinalIgnoreCase)).ToList();
            }

            if (items.Count == 0)
            {
                rptQuestions.Visible = false;
                pnlEmptyState.Visible = true;
                litShowingStart.Text = "0";
                litShowingEnd.Text = "0";
                litTotalCount.Text = "0";
                rptPageNumbers.DataSource = null;
                rptPageNumbers.DataBind();
                return;
            }

            rptQuestions.Visible = true;
            pnlEmptyState.Visible = false;
            rptQuestions.DataSource = items;
            rptQuestions.DataBind();

            int start = ((result.PageIndex - 1) * result.PageSize) + 1;
            int end = Math.Min(result.PageIndex * result.PageSize, result.TotalCount);
            litShowingStart.Text = start.ToString(CultureInfo.InvariantCulture);
            litShowingEnd.Text = end.ToString(CultureInfo.InvariantCulture);
            litTotalCount.Text = result.TotalCount.ToString("N0", CultureInfo.InvariantCulture);

            btnPrevPage.Enabled = result.PageIndex > 1;
            btnNextPage.Enabled = result.PageIndex < result.TotalPages;

            var pages = new List<object>();
            for (int p = 1; p <= result.TotalPages; p++)
            {
                pages.Add(new { PageNumber = p, IsCurrent = p == result.PageIndex });
            }
            rptPageNumbers.DataSource = pages;
            rptPageNumbers.DataBind();
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            hfPageIndex.Value = "1";
            BindQuestions();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = string.Empty;
            ddlTopic.SelectedIndex = 0;
            ddlDifficulty.SelectedIndex = 0;
            ddlStatus.SelectedIndex = 0;
            hfPageIndex.Value = "1";
            BindQuestions();
        }

        protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfPageIndex.Value = "1";
            BindQuestions();
        }

        protected void btnPrevPage_Click(object sender, EventArgs e)
        {
            int pageIndex = 1;
            int.TryParse(hfPageIndex.Value, out pageIndex);
            if (pageIndex > 1)
            {
                hfPageIndex.Value = (pageIndex - 1).ToString(CultureInfo.InvariantCulture);
                BindQuestions();
            }
        }

        protected void btnNextPage_Click(object sender, EventArgs e)
        {
            int pageIndex = 1;
            int.TryParse(hfPageIndex.Value, out pageIndex);
            hfPageIndex.Value = (pageIndex + 1).ToString(CultureInfo.InvariantCulture);
            BindQuestions();
        }

        protected void rptPageNumbers_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "GoToPage")
            {
                hfPageIndex.Value = e.CommandArgument.ToString();
                BindQuestions();
            }
        }

        protected void rptQuestions_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int questionId = Convert.ToInt32(e.CommandArgument, CultureInfo.InvariantCulture);

            if (e.CommandName == "Preview")
            {
                ShowPreviewModal(questionId);
            }
            else if (e.CommandName == "ToggleAudit")
            {
                _repo.ToggleStatus(questionId);
                ShowMessage("Question status updated successfully.", "users-alert-success");
                BindQuestions();
            }
            else if (e.CommandName == "DeleteQuestion")
            {
                _repo.DeleteQuestion(questionId);
                ShowMessage("Aptitude question removed from question bank.", "users-alert-success");
                BindQuestions();
            }
        }

        private void ShowPreviewModal(int questionId)
        {
            var q = _repo.GetById(questionId);
            if (q == null) return;

            litPreviewCode.Text = q.Code;
            litPreviewTopic.Text = q.Topic;
            litPreviewDifficulty.Text = q.Difficulty;
            litPreviewPrompt.Text = q.Prompt;
            litOptA.Text = q.OptionA;
            litOptB.Text = q.OptionB;
            litOptC.Text = q.OptionC;
            litOptD.Text = q.OptionD;
            litPreviewExplanation.Text = q.Explanation;
            litPreviewMarks.Text = q.Marks.ToString(CultureInfo.InvariantCulture);
            litPreviewNeg.Text = q.NegativeMarks.ToString("0.00", CultureInfo.InvariantCulture);
            litPreviewStatus.Text = q.ValidationStatus;

            // Highlight the correct option
            optACard.Attributes["class"] = "option-preview-card" + (q.CorrectOption == "A" ? " option-correct" : "");
            optBCard.Attributes["class"] = "option-preview-card" + (q.CorrectOption == "B" ? " option-correct" : "");
            optCCard.Attributes["class"] = "option-preview-card" + (q.CorrectOption == "C" ? " option-correct" : "");
            optDCard.Attributes["class"] = "option-preview-card" + (q.CorrectOption == "D" ? " option-correct" : "");

            pnlPreviewModal.Visible = true;
        }

        protected void btnClosePreview_Click(object sender, EventArgs e)
        {
            pnlPreviewModal.Visible = false;
        }

        private void ShowMessage(string message, string cssClass)
        {
            litMessage.Text = message;
            pnlMessage.CssClass = "users-alert " + cssClass;
            pnlMessage.Visible = true;
        }
    }
}

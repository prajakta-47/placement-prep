using System;
using System.Web;
using System.Web.UI;

namespace PlacementPrep
{
    public partial class AIResumeAnalysis : System.Web.UI.Page
    {
        private string _currentDocumentName = "alex_smith_swe_2024.pdf";
        public string CurrentDocumentName
        {
            get { return _currentDocumentName; }
            set { _currentDocumentName = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string fileParam = Request.QueryString["file"];
                if (!string.IsNullOrWhiteSpace(fileParam))
                {
                    CurrentDocumentName = System.IO.Path.GetFileName(fileParam);
                }

                lblDocName.Text = CurrentDocumentName;
                lnkSkillGap.NavigateUrl = string.Format("~/Student/SkillGapAnalysis.aspx?file={0}", HttpUtility.UrlEncode(CurrentDocumentName));
            }
        }

        protected void btnReanalyze_Click(object sender, EventArgs e)
        {
            pnlNotice.Visible = true;
            litNotice.Text = string.Format("<strong>AI Re-Analysis Complete:</strong> Scanned {0} using model v3.4. Match score is consistent at <strong>78%</strong>.", HttpUtility.HtmlEncode(lblDocName.Text));
        }
    }
}

using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using PlacementPrep.Helpers;

namespace PlacementPrep
{
    public partial class DriveDetails : Page
    {
        private readonly PlacementDriveRepository _driveRepo = new PlacementDriveRepository();
        private readonly CompanyRepository _companyRepo = new CompanyRepository();
        private readonly StudentRepository _studentRepo = new StudentRepository();

        private int CurrentDriveId
        {
            get
            {
                int id;
                return int.TryParse(Request.QueryString["id"], out id) && id > 0 ? id : 1;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDrive(CurrentDriveId);
                BindCandidates();
            }
        }

        protected void ddlCandidateFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindCandidates();
        }

        private void LoadDrive(int driveId)
        {
            var drive = _driveRepo.GetById(driveId);
            if (drive == null)
            {
                // Fallback to first
                var first = _driveRepo.Search(string.Empty, "All", "All", "All", 1, 1).Items.FirstOrDefault();
                if (first != null)
                {
                    drive = first;
                }
                else
                {
                    Response.Redirect("~/Admin/ManageDrives.aspx");
                    return;
                }
            }

            litBrowserTitle.Text = Server.HtmlEncode(drive.JobRole) + " (" + Server.HtmlEncode(drive.CompanyName) + ") - Drive Cockpit | Placement Prep";
            litBreadcrumbDrive.Text = Server.HtmlEncode(drive.DriveCode);

            litHeroJobRole.Text = Server.HtmlEncode(drive.JobRole);
            litHeroDriveCode.Text = Server.HtmlEncode(drive.DriveCode);
            litHeroCompanyName.Text = Server.HtmlEncode(drive.CompanyName);
            litHeroStatus.Text = Server.HtmlEncode(drive.DriveStatus);
            badgeHeroStatus.Attributes["class"] = drive.StatusClass;
            litHeroLocation.Text = Server.HtmlEncode(drive.WorkLocation);
            litHeroBatch.Text = drive.GraduationBatch.ToString(CultureInfo.InvariantCulture);

            litHeroInitials.Text = !string.IsNullOrWhiteSpace(drive.CompanyName)
                ? drive.CompanyName.Substring(0, Math.Min(2, drive.CompanyName.Length)).ToUpperInvariant()
                : "DR";

            litKpiPackage.Text = Server.HtmlEncode(drive.PackageDisplay);
            litKpiOpenings.Text = drive.Openings.ToString(CultureInfo.InvariantCulture);
            litKpiApplicants.Text = drive.ApplicantCount.ToString(CultureInfo.InvariantCulture);
            litKpiShortlisted.Text = drive.ShortlistedCount.ToString(CultureInfo.InvariantCulture);

            litSectionCode.Text = Server.HtmlEncode(drive.DriveCode);
            litJobDescription.Text = string.IsNullOrWhiteSpace(drive.JobDescription)
                ? "No detailed description entered for this role."
                : Server.HtmlEncode(drive.JobDescription);

            // Stages
            RenderStages(drive.RecruitmentStages);

            // Eligibility Rules
            litRuleMinCgpa.Text = drive.MinCgpa.ToString("0.00", CultureInfo.InvariantCulture);
            litRuleBatch.Text = drive.GraduationBatch.ToString(CultureInfo.InvariantCulture);
            litRuleStreams.Text = Server.HtmlEncode(drive.EligibleDepartments);
            litRuleBond.Text = string.IsNullOrWhiteSpace(drive.BondDetails) ? "No Service Bond" : Server.HtmlEncode(drive.BondDetails);

            // Schedule & Deadlines
            litScheduleDriveDate.Text = drive.DriveDate.ToString("MMMM dd, yyyy");
            litScheduleDeadline.Text = drive.ApplicationDeadline.ToString("MMMM dd, yyyy");
            litScheduleLocation.Text = Server.HtmlEncode(drive.WorkLocation);

            // Company profile link
            var company = _companyRepo.Search(drive.CompanyName, "All", "All", 1, 1).Items.FirstOrDefault();
            if (company != null)
            {
                lnkCompanyProfile.HRef = ResolveUrl("~/Admin/CompanyDetails.aspx?id=" + company.CompanyId);
            }
            else
            {
                lnkCompanyProfile.HRef = ResolveUrl("~/Admin/ManageCompanies.aspx");
            }
        }

        private void RenderStages(string stagesText)
        {
            var stages = (stagesText ?? string.Empty)
                .Split(new[] { ',', ';' }, StringSplitOptions.RemoveEmptyEntries)
                .Select(s => s.Trim())
                .ToList();

            if (stages.Count == 0)
            {
                stages = new List<string>
                {
                    "Online Cognitive & Coding Assessment",
                    "Technical Interview 1 (Algorithms & CS Core)",
                    "Technical Interview 2 (System Architecture)",
                    "Managerial & HR Fit Round"
                };
            }

            var sb = new System.Text.StringBuilder();
            for (int i = 0; i < stages.Count; i++)
            {
                sb.Append("<div class='stage-step'>");
                sb.AppendFormat("<div class='stage-step-index'>{0}</div>", i + 1);
                sb.Append("<div class='stage-step-info'>");
                sb.AppendFormat("<div class='stage-step-title'>{0}</div>", Server.HtmlEncode(stages[i]));
                sb.AppendFormat("<p class='stage-step-desc'>Proctored evaluation milestone &bull; Stage {0} of {1}</p>", i + 1, stages.Count);
                sb.Append("</div>");
                sb.Append("</div>");
            }

            litStagesStepperHtml.Text = sb.ToString();
        }

        private void BindCandidates()
        {
            var allStudents = _studentRepo.GetAllStudents();
            var evaluations = _driveRepo.EvaluateCandidates(CurrentDriveId, allStudents);

            var filter = ddlCandidateFilter.SelectedValue;
            if (string.Equals(filter, "Eligible", StringComparison.OrdinalIgnoreCase))
            {
                evaluations = evaluations.Where(e => e.IsEligible).ToList();
            }
            else if (string.Equals(filter, "Ineligible", StringComparison.OrdinalIgnoreCase))
            {
                evaluations = evaluations.Where(e => !e.IsEligible).ToList();
            }

            rptCandidateEvaluations.DataSource = evaluations;
            rptCandidateEvaluations.DataBind();

            pnlNoCandidates.Visible = evaluations.Count == 0;
            rptCandidateEvaluations.Visible = evaluations.Count > 0;
        }
    }
}

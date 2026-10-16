using System;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using PlacementPrep.Helpers;

namespace PlacementPrep
{
    public partial class Reports : Page
    {
        private readonly AnalyticsRepository _analyticsRepo = new AnalyticsRepository();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindAnalytics();
            }
        }

        protected void btnApplyFilters_Click(object sender, EventArgs e)
        {
            BindAnalytics();
        }

        protected void btnResetFilters_Click(object sender, EventArgs e)
        {
            ddlAcademicYear.SelectedValue = "2025";
            ddlDeptFilter.SelectedValue = "All";
            ddlTierFilter.SelectedValue = "All";
            BindAnalytics();
        }

        protected void btnExportCsv_Click(object sender, EventArgs e)
        {
            try
            {
                var csv = _analyticsRepo.GenerateCsvExport();
                Response.Clear();
                Response.Buffer = true;
                Response.AddHeader("content-disposition", "attachment;filename=Institutional_Placement_Analytics_" + DateTime.UtcNow.ToString("yyyyMMdd") + ".csv");
                Response.Charset = "utf-8";
                Response.ContentType = "text/csv";
                Response.Output.Write(csv);
                Response.Flush();
                Response.End();
            }
            catch (System.Threading.ThreadAbortException)
            {
                // Expected when calling Response.End()
            }
        }

        private void BindAnalytics()
        {
            litKpiPlacementRate.Text = _analyticsRepo.GlobalPlacementRate.ToString("0.0", CultureInfo.InvariantCulture) + "%";
            litDialRate.Text = _analyticsRepo.GlobalPlacementRate.ToString("0.0", CultureInfo.InvariantCulture) + "%";
            litKpiTotalOffers.Text = string.Format(CultureInfo.InvariantCulture, "{0:N0}", _analyticsRepo.TotalOffers);
            litKpiAvgPackage.Text = _analyticsRepo.AverageOverallPackageLpa.ToString("0.0", CultureInfo.InvariantCulture) + " LPA";
            litKpiHighestPackage.Text = _analyticsRepo.HighestOverallPackageLpa.ToString("0.0", CultureInfo.InvariantCulture) + " LPA";

            // Salary distribution
            rptSalaryDistribution.DataSource = _analyticsRepo.GetSalaryDistribution();
            rptSalaryDistribution.DataBind();

            // Department metrics with filter
            var deptList = _analyticsRepo.GetDepartmentMetrics();
            var selDept = ddlDeptFilter.SelectedValue;
            if (!string.Equals(selDept, "All", StringComparison.OrdinalIgnoreCase))
            {
                deptList = deptList.Where(d => d.DepartmentName.IndexOf(selDept, StringComparison.OrdinalIgnoreCase) >= 0).ToList();
            }
            rptDepartments.DataSource = deptList;
            rptDepartments.DataBind();

            // Partner rankings with tier filter
            var partnerList = _analyticsRepo.GetPartnerRankings();
            var selTier = ddlTierFilter.SelectedValue;
            if (!string.Equals(selTier, "All", StringComparison.OrdinalIgnoreCase))
            {
                partnerList = partnerList.Where(p => p.Tier.IndexOf(selTier, StringComparison.OrdinalIgnoreCase) >= 0).ToList();
            }
            rptPartners.DataSource = partnerList;
            rptPartners.DataBind();
        }
    }
}

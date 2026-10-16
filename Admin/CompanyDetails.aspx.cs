using System;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using PlacementPrep.Helpers;

namespace PlacementPrep
{
    public partial class CompanyDetails : Page
    {
        private readonly CompanyRepository _companyRepo = new CompanyRepository();
        private readonly PlacementDriveRepository _driveRepo = new PlacementDriveRepository();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int companyId;
                if (!int.TryParse(Request.QueryString["id"], out companyId) || companyId <= 0)
                {
                    // Fallback to first company in repository
                    var first = _companyRepo.Search(string.Empty, "All", "All", 1, 1).Items.FirstOrDefault();
                    companyId = first != null ? first.CompanyId : 1;
                }

                LoadCompany(companyId);
            }
        }

        private void LoadCompany(int companyId)
        {
            var company = _companyRepo.GetById(companyId);
            if (company == null)
            {
                Response.Redirect("~/Admin/ManageCompanies.aspx");
                return;
            }

            litBrowserTitle.Text = Server.HtmlEncode(company.CompanyName) + " - Corporate Partner Details | Placement Prep";
            litBreadcrumbCompany.Text = Server.HtmlEncode(company.CompanyName);

            litHeroCompanyName.Text = Server.HtmlEncode(company.CompanyName);
            litHeroInitials.Text = Server.HtmlEncode(company.Initials);
            pnlCompanyAvatar.Attributes["class"] = "details-hero-logo " + company.AvatarClass;

            litHeroIndustry.Text = Server.HtmlEncode(company.Industry);
            litHeroLocations.Text = Server.HtmlEncode(company.Locations);

            litHeroTier.Text = Server.HtmlEncode(company.Tier);
            badgeHeroTier.Attributes["class"] = company.TierClass;

            litHeroStatus.Text = Server.HtmlEncode(company.HiringStatus);
            badgeHeroStatus.Attributes["class"] = company.StatusClass;

            litAvgPackage.Text = company.AveragePackageLpa.ToString("0.0", CultureInfo.InvariantCulture);
            litHighestPackage.Text = company.HighestPackageLpa.ToString("0.0", CultureInfo.InvariantCulture);
            litActiveDrives.Text = company.ActiveDrivesCount.ToString(CultureInfo.InvariantCulture);
            litOffersExtended.Text = company.TotalOffersMade.ToString(CultureInfo.InvariantCulture);

            litCompanyAbout.Text = Server.HtmlEncode(company.About);

            if (!string.IsNullOrWhiteSpace(company.WebsiteUrl))
            {
                lnkOfficialSite.HRef = company.WebsiteUrl;
                lnkOfficialSite.Visible = true;
            }
            else
            {
                lnkOfficialSite.Visible = false;
            }

            // Recruiter info
            litSpocName.Text = Server.HtmlEncode(company.RecruiterName);
            litSpocEmail.Text = Server.HtmlEncode(company.RecruiterEmail);
            lnkSpocEmail.HRef = "mailto:" + company.RecruiterEmail;
            litSpocPhone.Text = Server.HtmlEncode(company.RecruiterPhone);

            litSideTier.Text = Server.HtmlEncode(company.Tier);
            badgeSideTier.Attributes["class"] = company.TierClass;
            litAuditDate.Text = company.UpdatedAt.ToString("MMM dd, yyyy");

            // Mock Job Roles for this company
            RenderJobRoles(company);

            // Associated Placement Drives
            RenderAssociatedDrives(company);
        }

        private void RenderJobRoles(CompanyItem company)
        {
            var sb = new System.Text.StringBuilder();

            // Realistic sample job roles based on industry & tier
            if (company.CompanyName.IndexOf("Google", StringComparison.OrdinalIgnoreCase) >= 0)
            {
                sb.Append("<tr><td><strong>Software Development Engineer - I</strong><br/><small class='text-muted'>Core Infrastructure &amp; Apps</small></td><td>Computer Science, Information Technology</td><td><strong class='cgpa-badge cgpa-high'>8.00</strong></td><td><strong>32.0 LPA</strong></td><td>12 Openings</td></tr>");
                sb.Append("<tr><td><strong>Site Reliability Engineer (SRE)</strong><br/><small class='text-muted'>Cloud Automation &amp; Linux</small></td><td>Computer Science, Electronics &amp; Comm</td><td><strong class='cgpa-badge cgpa-high'>7.80</strong></td><td><strong>28.0 LPA</strong></td><td>6 Openings</td></tr>");
                sb.Append("<tr><td><strong>Data &amp; AI Systems Associate</strong><br/><small class='text-muted'>Large Language Model Pipelines</small></td><td>Computer Science, Mathematics</td><td><strong class='cgpa-badge cgpa-high'>8.50</strong></td><td><strong>36.0 LPA</strong></td><td>4 Openings</td></tr>");
            }
            else if (company.CompanyName.IndexOf("Microsoft", StringComparison.OrdinalIgnoreCase) >= 0)
            {
                sb.Append("<tr><td><strong>Cloud Solution Engineer</strong><br/><small class='text-muted'>Azure Enterprise Architecture</small></td><td>Computer Science, Information Technology, Electronics</td><td><strong class='cgpa-badge cgpa-high'>7.50</strong></td><td><strong>26.0 LPA</strong></td><td>18 Openings</td></tr>");
                sb.Append("<tr><td><strong>Software Engineer (Core OS)</strong><br/><small class='text-muted'>Systems &amp; Virtualization</small></td><td>Computer Science</td><td><strong class='cgpa-badge cgpa-high'>8.00</strong></td><td><strong>28.0 LPA</strong></td><td>8 Openings</td></tr>");
            }
            else if (company.CompanyName.IndexOf("Amazon", StringComparison.OrdinalIgnoreCase) >= 0)
            {
                sb.Append("<tr><td><strong>Graduate Software Developer</strong><br/><small class='text-muted'>AWS Platform &amp; Retail Services</small></td><td>Computer Science, Information Technology</td><td><strong class='cgpa-badge cgpa-high'>7.50</strong></td><td><strong>26.5 LPA</strong></td><td>25 Openings</td></tr>");
                sb.Append("<tr><td><strong>Cloud Support Associate</strong><br/><small class='text-muted'>Networking &amp; Distributed Systems</small></td><td>All Engineering Streams</td><td><strong class='cgpa-badge'>7.00</strong></td><td><strong>14.0 LPA</strong></td><td>20 Openings</td></tr>");
            }
            else if (company.CompanyName.IndexOf("Goldman", StringComparison.OrdinalIgnoreCase) >= 0)
            {
                sb.Append("<tr><td><strong>Quantitative &amp; Systems Analyst</strong><br/><small class='text-muted'>Algorithmic Trading &amp; Financial Engineering</small></td><td>Computer Science, Electronics</td><td><strong class='cgpa-badge cgpa-high'>8.00</strong></td><td><strong>24.0 LPA</strong></td><td>10 Openings</td></tr>");
                sb.Append("<tr><td><strong>Risk Operations Analyst</strong><br/><small class='text-muted'>Credit &amp; Market Risk Analytics</small></td><td>All Engineering Streams</td><td><strong class='cgpa-badge'>7.20</strong></td><td><strong>16.0 LPA</strong></td><td>8 Openings</td></tr>");
            }
            else
            {
                sb.AppendFormat("<tr><td><strong>Associate Software Engineer</strong><br/><small class='text-muted'>Enterprise Applications &amp; Cloud</small></td><td>Computer Science, Information Technology, Electronics</td><td><strong class='cgpa-badge'>6.50</strong></td><td><strong>{0:0.0} LPA</strong></td><td>35 Openings</td></tr>", company.AveragePackageLpa);
                sb.AppendFormat("<tr><td><strong>Graduate Trainee Specialist</strong><br/><small class='text-muted'>Full Stack Development &amp; Automation</small></td><td>All Engineering Streams</td><td><strong class='cgpa-badge'>6.00</strong></td><td><strong>{0:0.0} LPA</strong></td><td>50 Openings</td></tr>", Math.Max(4.0, company.AveragePackageLpa * 0.75));
            }

            litJobRolesTableRows.Text = sb.ToString();
        }

        private void RenderAssociatedDrives(CompanyItem company)
        {
            var drives = _driveRepo.GetByCompanyName(company.CompanyName);
            if (drives != null && drives.Count > 0)
            {
                var sb = new System.Text.StringBuilder();
                sb.Append("<table class='users-table compact-table'>");
                sb.Append("<thead><tr><th>Drive Code &amp; Role</th><th>Drive Date</th><th>Deadline</th><th>Openings</th><th>Package</th><th>Status</th><th>Actions</th></tr></thead><tbody>");
                foreach (var d in drives)
                {
                    sb.Append("<tr>");
                    sb.AppendFormat("<td><strong>{0}</strong><br/><small class='text-muted'>{1}</small></td>",
                        Server.HtmlEncode(d.DriveCode), Server.HtmlEncode(d.JobRole));
                    sb.AppendFormat("<td>{0}</td>", d.DriveDate.ToString("MMM dd, yyyy"));
                    sb.AppendFormat("<td><small class='text-muted'>{0}</small></td>", d.ApplicationDeadline.ToString("MMM dd, yyyy"));
                    sb.AppendFormat("<td><strong>{0}</strong></td>", d.Openings);
                    sb.AppendFormat("<td><strong>{0}</strong></td>", Server.HtmlEncode(d.PackageDisplay));
                    sb.AppendFormat("<td><span class='{0}'><i></i>{1}</span></td>", d.StatusClass, Server.HtmlEncode(d.DriveStatus));
                    sb.AppendFormat("<td><a href='{0}' class='table-link'>Cockpit &rarr;</a></td>",
                        ResolveUrl("~/Admin/DriveDetails.aspx?id=" + d.DriveId));
                    sb.Append("</tr>");
                }
                sb.Append("</tbody></table>");
                litAssociatedDrivesTable.Text = sb.ToString();
            }
            else
            {
                litAssociatedDrivesTable.Text = "<p class='users-hint'>No placement drives currently registered for this company.</p>";
            }
        }
    }
}

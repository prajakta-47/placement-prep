<%@ Page Title="Company Details" Language="C#" MasterPageFile="~/Admin.Master"
    AutoEventWireup="true" CodeBehind="CompanyDetails.aspx.cs"
    Inherits="PlacementPrep.CompanyDetails" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title><asp:Literal ID="litBrowserTitle" runat="server" Text="Company Details | Placement Prep Admin" /></title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="admin-shell-page">

    <!-- Breadcrumb & Back Link -->
    <div class="users-breadcrumb" style="margin-bottom: 12px;">
        <a href="<%= ResolveUrl("~/Admin/AdminDashboard.aspx") %>">Dashboard</a>
        <span>/</span>
        <a href="<%= ResolveUrl("~/Admin/ManageCompanies.aspx") %>">Companies</a>
        <span>/</span>
        <span><asp:Literal ID="litBreadcrumbCompany" runat="server" Text="Company Profile" /></span>
    </div>

    <!-- Company Details Hero Banner -->
    <div class="details-hero">
        <div class="details-hero-left">
            <div id="pnlCompanyAvatar" runat="server" class="details-hero-logo users-avatar avatar-teal">
                <asp:Literal ID="litHeroInitials" runat="server" Text="CO" />
            </div>
            <div class="details-hero-title">
                <h1><asp:Literal ID="litHeroCompanyName" runat="server" Text="Corporate Partner" /></h1>
                <div class="details-hero-subtitle">
                    <span id="badgeHeroTier" runat="server" class="tier-badge tier-dream"><asp:Literal ID="litHeroTier" runat="server" Text="Tier 1" /></span>
                    <span id="badgeHeroStatus" runat="server" class="status-pill status-active"><asp:Literal ID="litHeroStatus" runat="server" Text="Hiring" /></span>
                    <span>&bull;</span>
                    <span><strong>Industry:</strong> <asp:Literal ID="litHeroIndustry" runat="server" Text="Technology" /></span>
                    <span>&bull;</span>
                    <span><strong>Campus Locations:</strong> <asp:Literal ID="litHeroLocations" runat="server" Text="Pan-India" /></span>
                </div>
            </div>
        </div>
        <div class="details-actions-bar">
            <a href="<%= ResolveUrl("~/Admin/ManageCompanies.aspx") %>" class="action-button">
                &larr; Back to Directory
            </a>
            <a href="<%= ResolveUrl("~/Admin/ManageDrives.aspx") %>" class="action-button primary">
                <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                    <rect x="3" y="4" width="18" height="18" rx="2" ry="2"/>
                    <line x1="16" y1="2" x2="16" y2="6"/>
                    <line x1="8" y1="2" x2="8" y2="6"/>
                </svg>
                Placement Drives
            </a>
        </div>
    </div>

    <!-- Telemetry Metric Cards -->
    <div class="users-kpi-grid">
        <div class="users-kpi-card">
            <span class="users-kpi-label">Average Package</span>
            <div class="users-kpi-value"><asp:Literal ID="litAvgPackage" runat="server" Text="0.0" /> LPA</div>
            <span class="users-kpi-sub">Campus hire median compensation</span>
        </div>
        <div class="users-kpi-card">
            <span class="users-kpi-label">Highest Package</span>
            <div class="users-kpi-value"><asp:Literal ID="litHighestPackage" runat="server" Text="0.0" /> LPA</div>
            <span class="users-kpi-sub">Maximum offered package</span>
        </div>
        <div class="users-kpi-card">
            <span class="users-kpi-label">Active Drives</span>
            <div class="users-kpi-value"><asp:Literal ID="litActiveDrives" runat="server" Text="0" /></div>
            <span class="users-kpi-sub">Scheduled on-campus drives</span>
        </div>
        <div class="users-kpi-card">
            <span class="users-kpi-label">Offers Extended</span>
            <div class="users-kpi-value"><asp:Literal ID="litOffersExtended" runat="server" Text="0" /></div>
            <span class="users-kpi-sub">Total student selects placed</span>
        </div>
    </div>

    <!-- 2-Column Content Grid -->
    <div class="details-grid-layout">
        
        <!-- Left Main Column -->
        <div class="details-grid-main">
            
            <!-- About Company -->
            <div class="details-section-card">
                <div class="details-section-header">
                    <h2>Company Overview &amp; Technological Domain</h2>
                    <a id="lnkOfficialSite" runat="server" target="_blank" rel="noopener" class="table-link">
                        Visit Careers Site &nearr;
                    </a>
                </div>
                <div class="qb-prompt-box">
                    <p style="margin: 0; line-height: 1.6; font-size: 13px;">
                        <asp:Literal ID="litCompanyAbout" runat="server" />
                    </p>
                </div>
            </div>

            <!-- Job Roles & Eligibility Criteria -->
            <div class="details-section-card">
                <div class="details-section-header">
                    <h2>Offered Job Roles &amp; Eligibility Criteria</h2>
                    <span class="text-muted" style="font-size: 11px;">Institutional Hiring Guidelines</span>
                </div>
                <div class="table-scroll">
                    <table class="users-table compact-table">
                        <thead>
                            <tr>
                                <th>Role Designation</th>
                                <th>Eligible Streams</th>
                                <th style="width: 85px;">Min CGPA</th>
                                <th style="width: 95px;">Est. CTC</th>
                                <th style="width: 80px;">Openings</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Literal ID="litJobRolesTableRows" runat="server" />
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Associated Placement Drives -->
            <div class="details-section-card">
                <div class="details-section-header">
                    <h2>Associated Placement Drives</h2>
                    <a href="<%= ResolveUrl("~/Admin/ManageDrives.aspx") %>" class="table-link">View All Drives &rarr;</a>
                </div>
                <div class="table-scroll">
                    <asp:Literal ID="litAssociatedDrivesTable" runat="server" />
                </div>
            </div>

        </div>

        <!-- Right Side Column -->
        <div class="details-grid-side">

            <!-- Recruiter / Campus SPOC Card -->
            <div class="details-section-card">
                <div class="details-section-header">
                    <h3>Recruiter / SPOC Contact</h3>
                </div>
                <table class="kv-table">
                    <tr>
                        <td class="kv-label">Lead Recruiter</td>
                        <td class="kv-value"><strong><asp:Literal ID="litSpocName" runat="server" /></strong></td>
                    </tr>
                    <tr>
                        <td class="kv-label">Email Address</td>
                        <td class="kv-value"><a id="lnkSpocEmail" runat="server" class="table-link"><asp:Literal ID="litSpocEmail" runat="server" /></a></td>
                    </tr>
                    <tr>
                        <td class="kv-label">Phone Contact</td>
                        <td class="kv-value"><asp:Literal ID="litSpocPhone" runat="server" /></td>
                    </tr>
                    <tr>
                        <td class="kv-label">Engagement</td>
                        <td class="kv-value">University Relations &amp; Talent Acquisition</td>
                    </tr>
                </table>
            </div>

            <!-- Hiring Statistics & Benchmarks -->
            <div class="details-section-card">
                <div class="details-section-header">
                    <h3>Hiring &amp; Applicant Statistics</h3>
                </div>
                <table class="kv-table">
                    <tr>
                        <td class="kv-label">Selection Ratio</td>
                        <td class="kv-value"><strong>~6.4%</strong> of applicants shortlisted</td>
                    </tr>
                    <tr>
                        <td class="kv-label">Median Assessment Score</td>
                        <td class="kv-value"><strong>82.5 / 100</strong> cutoff</td>
                    </tr>
                    <tr>
                        <td class="kv-label">Interview Rounds</td>
                        <td class="kv-value">3 - 4 Technical &amp; Fit Rounds</td>
                    </tr>
                    <tr>
                        <td class="kv-label">Offer Acceptance</td>
                        <td class="kv-value"><strong>94.2%</strong> joining rate</td>
                    </tr>
                </table>
            </div>

            <!-- MoU & Partnership Status -->
            <div class="details-section-card">
                <div class="details-section-header">
                    <h3>MoU &amp; Accreditation Status</h3>
                </div>
                <table class="kv-table">
                    <tr>
                        <td class="kv-label">Partnership Tier</td>
                        <td class="kv-value"><span id="badgeSideTier" runat="server" class="tier-badge tier-dream"><asp:Literal ID="litSideTier" runat="server" /></span></td>
                    </tr>
                    <tr>
                        <td class="kv-label">MoU Status</td>
                        <td class="kv-value"><span class="status-pill status-active"><i></i>Active &amp; Verified</span></td>
                    </tr>
                    <tr>
                        <td class="kv-label">Drive Mode</td>
                        <td class="kv-value">Hybrid (Online Test + In-Person Interviews)</td>
                    </tr>
                    <tr>
                        <td class="kv-label">Record Audit</td>
                        <td class="kv-value"><small class="text-muted">Updated <asp:Literal ID="litAuditDate" runat="server" /></small></td>
                    </tr>
                </table>
            </div>

            <!-- Demonstration Notice -->
            <div class="users-hint">
                <strong>Demonstration Sample Data:</strong> All corporate partner profiles, recruiter contacts, package statistics, and drives shown here represent mock demonstration benchmarks for administrative UI review. No actual live corporate databases are contacted.
            </div>

        </div>

    </div>

</div>
</asp:Content>

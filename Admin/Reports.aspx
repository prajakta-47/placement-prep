<%@ Page Title="Reports & Analytics" Language="C#" MasterPageFile="~/Admin.Master"
    AutoEventWireup="true" CodeBehind="Reports.aspx.cs"
    Inherits="PlacementPrep.Reports" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Reports &amp; Analytics | Placement Prep Admin</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="admin-shell-page">

    <!-- Page Header -->
    <div class="users-header">
        <div>
            <div class="users-breadcrumb">
                <a href="<%= ResolveUrl("~/Admin/AdminDashboard.aspx") %>">Dashboard</a>
                <span>/</span>
                <span>Intelligence &amp; Audit</span>
                <span>/</span>
                <span>Reports &amp; Analytics</span>
            </div>
            <h1 class="users-title">Institutional Placement Intelligence &amp; Analytics</h1>
            <p class="users-subtitle">
                Comprehensive seasonal conversion metrics, salary bracket distributions, department benchmarks, and corporate partner rankings.
            </p>
        </div>
        <div class="users-header-actions">
            <button type="button" class="action-button" onclick="window.print();" aria-label="Print Report">
                <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                    <polyline points="6 9 6 2 18 2 18 9"/>
                    <path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"/>
                    <rect x="6" y="14" width="12" height="8"/>
                </svg>
                Printable Bulletin
            </button>
            <asp:LinkButton ID="btnExportCsv" runat="server" CssClass="action-button primary"
                OnClick="btnExportCsv_Click" CausesValidation="false">
                <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                    <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/>
                    <polyline points="7 10 12 15 17 10"/>
                    <line x1="12" y1="15" x2="12" y2="3"/>
                </svg>
                Export CSV Summary
            </asp:LinkButton>
        </div>
    </div>

    <!-- Filter & Scope Toolbar -->
    <div class="users-filter-bar">
        <div class="users-filter-group">
            <label for="<%= ddlAcademicYear.ClientID %>">Placement Season</label>
            <asp:DropDownList ID="ddlAcademicYear" runat="server" AutoPostBack="true"
                OnSelectedIndexChanged="btnApplyFilters_Click" CssClass="users-filter-select">
                <asp:ListItem Text="2024 - 2025 (Active Season)" Value="2025" Selected="True" />
                <asp:ListItem Text="2023 - 2024 (Archived)" Value="2024" />
                <asp:ListItem Text="2022 - 2023 (Archived)" Value="2023" />
            </asp:DropDownList>
        </div>

        <div class="users-filter-group">
            <label for="<%= ddlDeptFilter.ClientID %>">Department Filter</label>
            <asp:DropDownList ID="ddlDeptFilter" runat="server" AutoPostBack="true"
                OnSelectedIndexChanged="btnApplyFilters_Click" CssClass="users-filter-select">
                <asp:ListItem Text="All Departments" Value="All" Selected="True" />
                <asp:ListItem Text="Computer Science" Value="Computer Science" />
                <asp:ListItem Text="Information Technology" Value="Information Technology" />
                <asp:ListItem Text="Electronics &amp; Comm" Value="Electronics &amp; Comm" />
                <asp:ListItem Text="Mechanical Engineering" Value="Mechanical Engineering" />
            </asp:DropDownList>
        </div>

        <div class="users-filter-group">
            <label for="<%= ddlTierFilter.ClientID %>">Partner Tier</label>
            <asp:DropDownList ID="ddlTierFilter" runat="server" AutoPostBack="true"
                OnSelectedIndexChanged="btnApplyFilters_Click" CssClass="users-filter-select">
                <asp:ListItem Text="All Partnership Tiers" Value="All" Selected="True" />
                <asp:ListItem Text="Tier 1 (Dream 18+ LPA)" Value="Tier 1" />
                <asp:ListItem Text="Tier 2 (Core 8-18 LPA)" Value="Tier 2" />
                <asp:ListItem Text="Mass Recruiters" Value="Mass" />
            </asp:DropDownList>
        </div>

        <asp:LinkButton ID="btnApplyFilters" runat="server" CssClass="action-button primary users-filter-btn"
            OnClick="btnApplyFilters_Click" CausesValidation="false">
            Apply Filters
        </asp:LinkButton>
        <asp:LinkButton ID="btnResetFilters" runat="server" CssClass="action-button users-filter-btn"
            OnClick="btnResetFilters_Click" CausesValidation="false">
            Reset
        </asp:LinkButton>
    </div>

    <!-- 4 Global Telemetry KPI Cards -->
    <div class="users-kpi-grid">
        <div class="users-kpi-card">
            <span class="users-kpi-label">Global Placement Rate</span>
            <div class="users-kpi-value" style="color:var(--admin-teal);"><asp:Literal ID="litKpiPlacementRate" runat="server" Text="84.6%" /></div>
            <span class="users-kpi-sub">5,482 placed of 6,480 eligible</span>
        </div>
        <div class="users-kpi-card">
            <span class="users-kpi-label">Cumulative Offers</span>
            <div class="users-kpi-value"><asp:Literal ID="litKpiTotalOffers" runat="server" Text="6,820" /></div>
            <span class="users-kpi-sub">1.24 offers per placed candidate</span>
        </div>
        <div class="users-kpi-card">
            <span class="users-kpi-label">Average Annual CTC</span>
            <div class="users-kpi-value"><asp:Literal ID="litKpiAvgPackage" runat="server" Text="14.8 LPA" /></div>
            <span class="users-kpi-sub">Campus median: 12.5 LPA</span>
        </div>
        <div class="users-kpi-card">
            <span class="users-kpi-label">Highest Package Offered</span>
            <div class="users-kpi-value" style="color:#d97706;"><asp:Literal ID="litKpiHighestPackage" runat="server" Text="48.0 LPA" /></div>
            <span class="users-kpi-sub">Google SDE-I Campus Select</span>
        </div>
    </div>

    <!-- 2-Column Visual Charts Section -->
    <div class="details-grid-layout">
        
        <!-- Left: Salary Distribution Breakdown -->
        <div class="details-section-card">
            <div class="details-section-header">
                <h2>Salary Compensation Distribution (Offers by Bracket)</h2>
                <span class="text-muted" style="font-size: 11px;">Annual CTC Brackets</span>
            </div>
            
            <div class="analytics-chart-container">
                <asp:Repeater ID="rptSalaryDistribution" runat="server">
                    <ItemTemplate>
                        <div class="analytics-bar-row">
                            <div class="analytics-bar-header">
                                <span><strong><%# Eval("BracketLabel") %></strong></span>
                                <span><%# Eval("OffersCount") %> Offers (<%# string.Format("{0:0.0}%", Eval("Percentage")) %>)</span>
                            </div>
                            <div class="analytics-bar-track">
                                <div class='<%# "analytics-bar-fill " + Eval("ColorClass") %>' style='<%# "width:" + Eval("Percentage") + "%;" %>'></div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <!-- Conversion Readiness Circle Widget -->
            <div class="analytics-rate-circle">
                <div class="rate-circle-dial">
                    <div class="rate-circle-inner"><asp:Literal ID="litDialRate" runat="server" Text="84.6%" /></div>
                </div>
                <div class="rate-circle-meta">
                    <h3>Overall Placement Season Conversion</h3>
                    <p>
                        84.6% of verified eligible candidates have accepted verified on-campus offers. 
                        Target institution benchmark is 90.0% by June 2025.
                    </p>
                </div>
            </div>
        </div>

        <!-- Right: Assessment & Readiness Correlation -->
        <div class="details-section-card">
            <div class="details-section-header">
                <h2>Placement Readiness &amp; Test Correlation</h2>
                <span class="text-muted" style="font-size: 11px;">Skill Telemetry</span>
            </div>

            <table class="kv-table">
                <tr>
                    <td class="kv-label">Average ATS Resume Score</td>
                    <td class="kv-value"><strong style="color:var(--admin-teal);">88.4 / 100</strong> (Verified Parsed)</td>
                </tr>
                <tr>
                    <td class="kv-label">Mean Coding Acceptance</td>
                    <td class="kv-value"><strong>67.2%</strong> on DSA benchmark challenges</td>
                </tr>
                <tr>
                    <td class="kv-label">Aptitude Cutoff Clearance</td>
                    <td class="kv-value"><strong>82.8%</strong> cleared quantitative reasoning</td>
                </tr>
                <tr>
                    <td class="kv-label">Mock Interview Pass Rate</td>
                    <td class="kv-value"><strong>74.5%</strong> cleared Technical Round 1</td>
                </tr>
                <tr>
                    <td class="kv-label">Proctoring Integrity Index</td>
                    <td class="kv-value"><strong>98.9%</strong> clean session compliance</td>
                </tr>
                <tr>
                    <td class="kv-label">Dream Tier (18+ LPA) Conversion</td>
                    <td class="kv-value"><strong style="color:#d97706;">18.6%</strong> of total campus offers</td>
                </tr>
            </table>

            <div class="users-hint" style="margin-top: 16px;">
                <strong>Key Insight:</strong> Candidates completing &ge;15 mock assessments achieve a <strong>2.4&times; higher selection rate</strong> in Tier 1 corporate placement drives.
            </div>
        </div>

    </div>

    <!-- Department-Wise Placement Performance League -->
    <div class="details-section-card">
        <div class="details-section-header">
            <div>
                <h2>Academic Department Placement Performance League</h2>
                <p class="text-muted" style="margin: 3px 0 0; font-size: 11px;">
                    Departmental placement rates, candidate cohorts, median and maximum compensation packages.
                </p>
            </div>
        </div>

        <div class="table-scroll">
            <asp:Repeater ID="rptDepartments" runat="server">
                <HeaderTemplate>
                    <table class="users-table">
                        <thead>
                            <tr>
                                <th>Department Stream</th>
                                <th style="width: 100px;">Total Cohort</th>
                                <th style="width: 100px;">Students Placed</th>
                                <th style="width: 130px;">Placement Rate</th>
                                <th style="width: 120px;">Average CTC</th>
                                <th style="width: 120px;">Highest CTC</th>
                                <th>Leading Recruiter</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <strong><%# Server.HtmlEncode(Convert.ToString(Eval("DepartmentName"))) %></strong>
                        </td>
                        <td>
                            <%# Eval("TotalStudents") %> Students
                        </td>
                        <td>
                            <strong class="qb-usage-count"><%# Eval("PlacedCount") %></strong>
                        </td>
                        <td>
                            <span class='<%# (double)Eval("PlacementPercentage") >= 85.0 ? "status-pill status-active" : "status-pill status-process" %>'>
                                <i></i><%# string.Format("{0:0.0}%", Eval("PlacementPercentage")) %>
                            </span>
                        </td>
                        <td>
                            <strong><%# string.Format("{0:0.0} LPA", Eval("AveragePackageLpa")) %></strong>
                        </td>
                        <td>
                            <strong style="color:#d97706;"><%# string.Format("{0:0.0} LPA", Eval("HighestPackageLpa")) %></strong>
                        </td>
                        <td>
                            <strong class="placed-company">@ <%# Server.HtmlEncode(Convert.ToString(Eval("TopRecruiter"))) %></strong>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                        </tbody>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </div>

    <!-- Top Hiring Corporate Partners -->
    <div class="details-section-card">
        <div class="details-section-header">
            <div>
                <h2>Top Hiring Corporate Partners (Ranked by Offers &amp; Intake)</h2>
                <p class="text-muted" style="margin: 3px 0 0; font-size: 11px;">
                    Leading enterprise recruiters, tier classification, total campus offers, and compensation benchmarks.
                </p>
            </div>
            <a href="<%= ResolveUrl("~/Admin/ManageCompanies.aspx") %>" class="table-link">Manage Partners &rarr;</a>
        </div>

        <div class="table-scroll">
            <asp:Repeater ID="rptPartners" runat="server">
                <HeaderTemplate>
                    <table class="users-table">
                        <thead>
                            <tr>
                                <th style="width: 60px;">Rank</th>
                                <th>Corporate Partner</th>
                                <th style="width: 140px;">Tier Category</th>
                                <th style="width: 110px;">Offers Extended</th>
                                <th style="width: 120px;">Average CTC</th>
                                <th style="width: 120px;">Highest CTC</th>
                                <th style="width: 100px;">Active Drives</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <strong class="qb-code">#<%# Eval("Rank") %></strong>
                        </td>
                        <td>
                            <strong><%# Server.HtmlEncode(Convert.ToString(Eval("CompanyName"))) %></strong>
                        </td>
                        <td>
                            <span class='<%# Convert.ToString(Eval("Tier")).IndexOf("Dream") >= 0 ? "tier-badge tier-dream" : Convert.ToString(Eval("Tier")).IndexOf("Tier 2") >= 0 ? "tier-badge tier-standard" : "tier-badge tier-mass" %>'>
                                <%# Server.HtmlEncode(Convert.ToString(Eval("Tier"))) %>
                            </span>
                        </td>
                        <td>
                            <strong class="qb-usage-count" style="font-size:13px;"><%# Eval("OffersMade") %></strong>
                        </td>
                        <td>
                            <strong><%# string.Format("{0:0.0} LPA", Eval("AveragePackageLpa")) %></strong>
                        </td>
                        <td>
                            <strong style="color:#d97706;"><%# string.Format("{0:0.0} LPA", Eval("HighestPackageLpa")) %></strong>
                        </td>
                        <td>
                            <span><%# Eval("ActiveDrives") %> Drives</span>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                        </tbody>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>

        <!-- Demonstration Notice Banner -->
        <div class="users-hint" style="margin-top: 14px;">
            <strong>Demonstration Sample Data:</strong> Placement statistics, salary brackets, and corporate partner performance figures represent mock institutional metrics for UI demonstration and administrative reporting review.
        </div>
    </div>

</div>
</asp:Content>

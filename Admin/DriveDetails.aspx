<%@ Page Title="Drive Details & Candidate Eligibility" Language="C#" MasterPageFile="~/Admin.Master"
    AutoEventWireup="true" CodeBehind="DriveDetails.aspx.cs"
    Inherits="PlacementPrep.DriveDetails" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title><asp:Literal ID="litBrowserTitle" runat="server" Text="Placement Drive Cockpit | Placement Prep Admin" /></title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="admin-shell-page">

    <!-- Breadcrumb & Back Link -->
    <div class="users-breadcrumb" style="margin-bottom: 12px;">
        <a href="<%= ResolveUrl("~/Admin/AdminDashboard.aspx") %>">Dashboard</a>
        <span>/</span>
        <a href="<%= ResolveUrl("~/Admin/ManageDrives.aspx") %>">Placement Drives</a>
        <span>/</span>
        <span><asp:Literal ID="litBreadcrumbDrive" runat="server" Text="Drive Cockpit" /></span>
    </div>

    <!-- Alert Message Banner -->
    <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="users-alert users-alert-success">
        <asp:Literal ID="litMessage" runat="server" />
    </asp:Panel>

    <!-- Drive Details Hero Banner -->
    <div class="details-hero">
        <div class="details-hero-left">
            <div id="pnlCompanyAvatar" runat="server" class="details-hero-logo users-avatar avatar-teal">
                <asp:Literal ID="litHeroInitials" runat="server" Text="DR" />
            </div>
            <div class="details-hero-title">
                <h1>
                    <asp:Literal ID="litHeroJobRole" runat="server" Text="Software Engineer" />
                    <span class="qb-code" style="font-size: 14px; margin-left: 8px;"><asp:Literal ID="litHeroDriveCode" runat="server" Text="DRV-2025-001" /></span>
                </h1>
                <div class="details-hero-subtitle">
                    <span><strong>Sponsoring Partner:</strong> <asp:Literal ID="litHeroCompanyName" runat="server" Text="Company" /></span>
                    <span>&bull;</span>
                    <span id="badgeHeroStatus" runat="server" class="status-pill status-active"><asp:Literal ID="litHeroStatus" runat="server" Text="Open" /></span>
                    <span>&bull;</span>
                    <span><strong>Location:</strong> <asp:Literal ID="litHeroLocation" runat="server" Text="Bangalore" /></span>
                    <span>&bull;</span>
                    <span><strong>Batch:</strong> Class of <asp:Literal ID="litHeroBatch" runat="server" Text="2025" /></span>
                </div>
            </div>
        </div>
        <div class="details-actions-bar">
            <a href="<%= ResolveUrl("~/Admin/ManageDrives.aspx") %>" class="action-button">
                &larr; Back to Drives
            </a>
            <a id="lnkCompanyProfile" runat="server" class="action-button">
                Company Profile &rarr;
            </a>
        </div>
    </div>

    <!-- 4 Telemetry Metric Cards -->
    <div class="users-kpi-grid">
        <div class="users-kpi-card">
            <span class="users-kpi-label">Offered Compensation</span>
            <div class="users-kpi-value"><asp:Literal ID="litKpiPackage" runat="server" Text="0.0 LPA" /></div>
            <span class="users-kpi-sub">Annual package (CTC)</span>
        </div>
        <div class="users-kpi-card">
            <span class="users-kpi-label">Confirmed Openings</span>
            <div class="users-kpi-value"><asp:Literal ID="litKpiOpenings" runat="server" Text="0" /></div>
            <span class="users-kpi-sub">Total intake positions</span>
        </div>
        <div class="users-kpi-card">
            <span class="users-kpi-label">Total Applicants</span>
            <div class="users-kpi-value"><asp:Literal ID="litKpiApplicants" runat="server" Text="0" /></div>
            <span class="users-kpi-sub">Simulated registered students</span>
        </div>
        <div class="users-kpi-card">
            <span class="users-kpi-label">Shortlisted Candidates</span>
            <div class="users-kpi-value"><asp:Literal ID="litKpiShortlisted" runat="server" Text="0" /></div>
            <span class="users-kpi-sub">Cleared evaluation stages</span>
        </div>
    </div>

    <!-- 2-Column Overview Layout -->
    <div class="details-grid-layout">
        
        <!-- Left Main Column -->
        <div class="details-grid-main">
            
            <!-- Job Role & Responsibilities -->
            <div class="details-section-card">
                <div class="details-section-header">
                    <h2>Job Role Description &amp; Scope</h2>
                    <span class="qb-code"><asp:Literal ID="litSectionCode" runat="server" /></span>
                </div>
                <div class="qb-prompt-box">
                    <p style="margin: 0; line-height: 1.6; font-size: 13px;">
                        <asp:Literal ID="litJobDescription" runat="server" />
                    </p>
                </div>
            </div>

            <!-- Recruitment Evaluation Stages -->
            <div class="details-section-card">
                <div class="details-section-header">
                    <h2>Recruitment Evaluation Stages</h2>
                    <span class="text-muted" style="font-size: 11px;">Hiring Pipeline Workflow</span>
                </div>
                <div class="stages-stepper">
                    <asp:Literal ID="litStagesStepperHtml" runat="server" />
                </div>
            </div>

        </div>

        <!-- Right Side Column -->
        <div class="details-grid-side">

            <!-- Eligibility Rules Card -->
            <div class="details-section-card">
                <div class="details-section-header">
                    <h3>Eligibility Criteria Rules</h3>
                </div>
                <table class="kv-table">
                    <tr>
                        <td class="kv-label">Cutoff CGPA</td>
                        <td class="kv-value"><strong class="cgpa-badge cgpa-high"><asp:Literal ID="litRuleMinCgpa" runat="server" />+</strong></td>
                    </tr>
                    <tr>
                        <td class="kv-label">Graduation Batch</td>
                        <td class="kv-value">Class of <strong><asp:Literal ID="litRuleBatch" runat="server" /></strong></td>
                    </tr>
                    <tr>
                        <td class="kv-label">Eligible Streams</td>
                        <td class="kv-value"><asp:Literal ID="litRuleStreams" runat="server" /></td>
                    </tr>
                    <tr>
                        <td class="kv-label">Service Agreement</td>
                        <td class="kv-value"><asp:Literal ID="litRuleBond" runat="server" /></td>
                    </tr>
                </table>
            </div>

            <!-- Schedule & Deadlines Card -->
            <div class="details-section-card">
                <div class="details-section-header">
                    <h3>Schedule &amp; Deadlines</h3>
                </div>
                <table class="kv-table">
                    <tr>
                        <td class="kv-label">Drive Execution Date</td>
                        <td class="kv-value"><strong><asp:Literal ID="litScheduleDriveDate" runat="server" /></strong></td>
                    </tr>
                    <tr>
                        <td class="kv-label">Application Deadline</td>
                        <td class="kv-value"><strong style="color:#b91c1c;"><asp:Literal ID="litScheduleDeadline" runat="server" /></strong></td>
                    </tr>
                    <tr>
                        <td class="kv-label">Interview Mode</td>
                        <td class="kv-value">Hybrid (Proctored Test + Video/Campus)</td>
                    </tr>
                    <tr>
                        <td class="kv-label">Work Location</td>
                        <td class="kv-value"><asp:Literal ID="litScheduleLocation" runat="server" /></td>
                    </tr>
                </table>
            </div>

        </div>

    </div>

    <!-- Candidate Eligibility Evaluation & Applicant Roster -->
    <div class="details-section-card" style="margin-top: 10px;">
        <div class="details-section-header">
            <div>
                <h2 style="font-size: 16px;">Candidate Eligibility Roster &amp; Applicant Pipeline</h2>
                <p class="text-muted" style="margin: 3px 0 0; font-size: 11px;">
                    Simulated dynamic evaluation of institutional students against this drive's CGPA benchmark, academic department, and graduation cohort.
                </p>
            </div>
            <div style="display: flex; gap: 8px; align-items: center;">
                <asp:DropDownList ID="ddlCandidateFilter" runat="server" AutoPostBack="true"
                    OnSelectedIndexChanged="ddlCandidateFilter_SelectedIndexChanged" CssClass="users-filter-select compact">
                    <asp:ListItem Text="All Students Evaluated" Value="All" Selected="True" />
                    <asp:ListItem Text="Eligible Candidates Only" Value="Eligible" />
                    <asp:ListItem Text="Ineligible Candidates Only" Value="Ineligible" />
                </asp:DropDownList>
            </div>
        </div>

        <!-- Dynamic Eligibility Evaluation Table -->
        <div class="table-scroll">
            <asp:Repeater ID="rptCandidateEvaluations" runat="server">
                <HeaderTemplate>
                    <table class="users-table">
                        <thead>
                            <tr>
                                <th>Candidate Identity</th>
                                <th>Enrollment ID</th>
                                <th>Department Stream</th>
                                <th style="width: 75px;">Batch</th>
                                <th style="width: 75px;">CGPA</th>
                                <th style="width: 120px;">Drive Eligibility</th>
                                <th>Evaluation Audit Rationale</th>
                                <th style="width: 140px;">Recruitment Stage</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <div class="users-identity">
                                <span class='<%# Eval("AvatarClass") %>'><%# Eval("Initials") %></span>
                                <span>
                                    <strong><%# Server.HtmlEncode(Convert.ToString(Eval("FullName"))) %></strong>
                                    <small><%# Server.HtmlEncode(Convert.ToString(Eval("Email"))) %></small>
                                </span>
                            </div>
                        </td>
                        <td>
                            <strong class="qb-code"><%# Server.HtmlEncode(Convert.ToString(Eval("EnrollmentId"))) %></strong>
                        </td>
                        <td>
                            <%# Server.HtmlEncode(Convert.ToString(Eval("Department"))) %>
                        </td>
                        <td>
                            <span class="qb-usage-count"><%# Eval("GraduationYear") %></span>
                        </td>
                        <td>
                            <strong class='<%# (double)Eval("Cgpa") >= 8.0 ? "cgpa-badge cgpa-high" : "cgpa-badge" %>'>
                                <%# string.Format("{0:0.00}", Eval("Cgpa")) %>
                            </strong>
                        </td>
                        <td>
                            <span class='<%# (bool)Eval("IsEligible") ? "elig-pill elig-eligible" : "elig-pill elig-ineligible" %>'>
                                <%# (bool)Eval("IsEligible") ? "Eligible" : "Ineligible" %>
                            </span>
                        </td>
                        <td>
                            <span class='<%# (bool)Eval("IsEligible") ? "elig-reason-text pass" : "elig-reason-text fail" %>'>
                                <%# Server.HtmlEncode(Convert.ToString(Eval("EligibilityReason"))) %>
                            </span>
                        </td>
                        <td>
                            <span class='<%# (bool)Eval("IsEligible") ? "status-pill status-process" : "status-pill status-suspended" %>'>
                                <i></i><%# Server.HtmlEncode(Convert.ToString(Eval("ApplicationStage"))) %>
                            </span>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                        </tbody>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>

        <asp:Panel ID="pnlNoCandidates" runat="server" Visible="false" CssClass="users-empty">
            <p>No student candidates match the selected eligibility roster filter.</p>
        </asp:Panel>

        <!-- Demonstration Notice Banner -->
        <div class="users-hint" style="margin-top: 14px;">
            <strong>Demonstration Sample Data:</strong> The candidate evaluation above dynamically checks students from the in-memory <code>StudentRepository</code> against this drive's criteria (CGPA cutoff, Department stream, and Batch). Real emails, applicant submission portals, or live external assessment engines are strictly out of scope.
        </div>
    </div>

</div>
</asp:Content>

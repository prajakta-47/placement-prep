<%@ Page Title="Student Placement Dossier" Language="C#" MasterPageFile="~/Admin.Master"
    AutoEventWireup="true" CodeBehind="StudentDetails.aspx.cs"
    Inherits="PlacementPrep.StudentDetails" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title><asp:Literal ID="litBrowserTitle" runat="server" Text="Student Placement Dossier | Placement Prep Admin" /></title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="admin-shell-page">

    <!-- Breadcrumb & Navigation -->
    <div class="users-breadcrumb" style="margin-bottom: 12px;">
        <a href="<%= ResolveUrl("~/Admin/AdminDashboard.aspx") %>">Dashboard</a>
        <span>/</span>
        <a href="<%= ResolveUrl("~/Admin/ManageStudents.aspx") %>">Students</a>
        <span>/</span>
        <span><asp:Literal ID="litBreadcrumbStudent" runat="server" Text="Student Profile" /></span>
    </div>

    <!-- Alert / Notice Panel -->
    <asp:Panel ID="pnlNotice" runat="server" Visible="false" CssClass="users-alert users-alert-success" style="margin-bottom: 16px;">
        <asp:Literal ID="litNoticeMsg" runat="server" />
    </asp:Panel>

    <!-- Student Details Hero Banner -->
    <div class="details-hero">
        <div class="details-hero-left">
            <div id="pnlStudentAvatar" runat="server" class="details-hero-logo users-avatar avatar-purple">
                <asp:Literal ID="litHeroInitials" runat="server" Text="ST" />
            </div>
            <div class="details-hero-title">
                <h1><asp:Literal ID="litHeroName" runat="server" Text="Student Candidate" /></h1>
                <div class="details-hero-subtitle">
                    <span id="badgeHeroElig" runat="server" class="elig-pill elig-eligible">
                        <asp:Literal ID="litHeroElig" runat="server" Text="Eligible" />
                    </span>
                    <span id="badgeHeroStatus" runat="server" class="status-pill status-active">
                        <asp:Literal ID="litHeroStatus" runat="server" Text="In Process" />
                    </span>
                    <span>&bull;</span>
                    <span><strong>Roll ID:</strong> <asp:Literal ID="litHeroEnrollment" runat="server" Text="STU-00000" /></span>
                    <span>&bull;</span>
                    <span><strong>Department:</strong> <asp:Literal ID="litHeroDept" runat="server" Text="Computer Science" /></span>
                    <span>&bull;</span>
                    <span><strong>Graduation Batch:</strong> <asp:Literal ID="litHeroBatch" runat="server" Text="2025" /></span>
                </div>
            </div>
        </div>
        <div class="details-actions-bar">
            <a href="<%= ResolveUrl("~/Admin/ManageStudents.aspx") %>" class="action-button">
                &larr; Back to Students
            </a>
            <a href="<%= ResolveUrl("~/Admin/ManageDrives.aspx") %>" class="action-button primary">
                <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                    <rect x="3" y="4" width="18" height="18" rx="2" ry="2"/>
                    <line x1="16" y1="2" x2="16" y2="6"/>
                    <line x1="8" y1="2" x2="8" y2="6"/>
                </svg>
                Placement Drives
            </a>
            <asp:Button ID="btnToggleAudit" runat="server" CssClass="action-button"
                Text="Toggle Eligibility" OnClick="btnToggleAudit_Click" CausesValidation="false" />
        </div>
    </div>

    <!-- Telemetry Metric Cards -->
    <div class="users-kpi-grid">
        <div class="users-kpi-card">
            <span class="users-kpi-label">Cumulative GPA</span>
            <div class="users-kpi-value"><asp:Literal ID="litCgpa" runat="server" Text="0.00" /></div>
            <span class="users-kpi-sub">
                <asp:Literal ID="litCgpaStanding" runat="server" Text="Standing: Benchmark Cleared" />
            </span>
        </div>
        <div class="users-kpi-card">
            <span class="users-kpi-label">Placement Readiness Index</span>
            <div class="users-kpi-value"><asp:Literal ID="litPriScore" runat="server" Text="0" /> / 100</div>
            <span class="users-kpi-sub">Adaptive AI Readiness Benchmark</span>
        </div>
        <div class="users-kpi-card">
            <span class="users-kpi-label">ATS Resume Score</span>
            <div class="users-kpi-value"><asp:Literal ID="litAtsScore" runat="server" Text="0" /> %</div>
            <span class="users-kpi-sub">Industry Resume Parser Match</span>
        </div>
        <div class="users-kpi-card">
            <span class="users-kpi-label">Completed Assessments</span>
            <div class="users-kpi-value"><asp:Literal ID="litAssessments" runat="server" Text="0" /></div>
            <span class="users-kpi-sub">Standard Proctored Evaluations</span>
        </div>
    </div>

    <!-- 2-Column Detailed Layout -->
    <div class="details-grid">

        <!-- Left Column: Academic Profile & Pipeline -->
        <div class="details-left">

            <!-- Academic Profile & Eligibility Checklist -->
            <div class="users-card" style="margin-bottom: 24px;">
                <h3 class="users-card-title">Institutional Placement Eligibility Checklist</h3>
                <p class="users-hint" style="margin-bottom: 16px;">
                    Automated pre-flight compliance audit evaluated against senate-approved recruitment criteria.
                </p>

                <div class="details-kv-grid">
                    <div class="details-kv-item">
                        <span class="details-kv-label">Institutional Email</span>
                        <span class="details-kv-value"><asp:Literal ID="litEmail" runat="server" Text="student@university.edu" /></span>
                    </div>
                    <div class="details-kv-item">
                        <span class="details-kv-label">Academic Stream</span>
                        <span class="details-kv-value"><asp:Literal ID="litDeptFull" runat="server" Text="Computer Science & Engineering" /></span>
                    </div>
                    <div class="details-kv-item">
                        <span class="details-kv-label">Active Academic Backlogs</span>
                        <span class="details-kv-value"><strong style="color: #059669;">0 Active Backlogs (Cleared)</strong></span>
                    </div>
                    <div class="details-kv-item">
                        <span class="details-kv-label">Attendance Compliance</span>
                        <span class="details-kv-value"><strong style="color: #059669;">92.4% (Mandate &ge; 85%)</strong></span>
                    </div>
                    <div class="details-kv-item">
                        <span class="details-kv-label">Placement Cell Status</span>
                        <span class="details-kv-value"><asp:Literal ID="litStatusDesc" runat="server" Text="Active Candidate" /></span>
                    </div>
                    <div class="details-kv-item">
                        <span class="details-kv-label">Current Offer Extended</span>
                        <span class="details-kv-value"><asp:Literal ID="litOfferPackage" runat="server" Text="None (Seeking Placement)" /></span>
                    </div>
                </div>
            </div>

            <!-- Recruitment Applications & Selection Pipeline -->
            <div class="users-card" style="margin-bottom: 24px;">
                <h3 class="users-card-title">Recruitment Applications &amp; Drive Pipeline History</h3>
                <p class="users-hint" style="margin-bottom: 16px;">
                    Chronological audit of campus placement drives, assessment rounds, and extended corporate offers.
                </p>

                <div class="table-responsive">
                    <asp:Repeater ID="rptApplications" runat="server">
                        <HeaderTemplate>
                            <table class="users-table compact-table">
                                <thead>
                                    <tr>
                                        <th>Corporate Partner</th>
                                        <th>Job Role</th>
                                        <th>Current Stage</th>
                                        <th>Application Status</th>
                                        <th>Package (LPA)</th>
                                        <th>Applied Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td><strong><%# Server.HtmlEncode(Convert.ToString(Eval("CompanyName"))) %></strong></td>
                                <td><%# Server.HtmlEncode(Convert.ToString(Eval("JobRole"))) %></td>
                                <td><span class="qb-badge qb-badge-topic"><%# Server.HtmlEncode(Convert.ToString(Eval("RecruitmentStage"))) %></span></td>
                                <td><span class='<%# Eval("StatusBadgeClass") %>'><%# Server.HtmlEncode(Convert.ToString(Eval("ApplicationStatus"))) %></span></td>
                                <td>
                                    <strong><%# Eval("OfferPackageLpa") != null ? Convert.ToDouble(Eval("OfferPackageLpa")).ToString("0.0") + " LPA" : "-" %></strong>
                                </td>
                                <td><span class="qb-usage-count"><%# Server.HtmlEncode(Convert.ToString(Eval("AppliedDate"))) %></span></td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                                </tbody>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>

                    <asp:Panel ID="pnlNoApps" runat="server" Visible="false" CssClass="users-empty">
                        No active campus drive applications recorded for this candidate.
                    </asp:Panel>
                </div>
            </div>

            <!-- Technical Skills & Portfolios -->
            <div class="users-card">
                <h3 class="users-card-title">Technical Competencies &amp; Repositories</h3>
                <div style="margin-top: 12px; margin-bottom: 16px;">
                    <asp:Literal ID="litSkillTags" runat="server" Text="<span class='users-hint'>No verified skills recorded.</span>" />
                </div>
                <div class="details-kv-grid">
                    <div class="details-kv-item">
                        <span class="details-kv-label">GitHub Portfolio</span>
                        <span class="details-kv-value"><asp:Literal ID="litGithub" runat="server" Text="Not provided" /></span>
                    </div>
                    <div class="details-kv-item">
                        <span class="details-kv-label">LinkedIn Profile</span>
                        <span class="details-kv-value"><asp:Literal ID="litLinkedin" runat="server" Text="Not provided" /></span>
                    </div>
                </div>
            </div>

        </div>

        <!-- Right Column: Performance Breakdown & Counseling Log -->
        <div class="details-right">

            <!-- Central Benchmark Score Breakdown -->
            <div class="users-card" style="margin-bottom: 24px;">
                <h3 class="users-card-title">Central Placement Benchmark Performance</h3>
                <p class="users-hint" style="margin-bottom: 16px;">
                    Standardized institutional placement benchmark scores across core evaluation axes.
                </p>

                <div style="display: flex; flex-direction: column; gap: 14px;">
                    <div>
                        <div style="display: flex; justify-content: space-between; font-size: 13px; font-weight: 600; margin-bottom: 4px;">
                            <span>Quantitative &amp; Logical Aptitude</span>
                            <span style="color: #0d9488;"><asp:Literal ID="litAptitudeScore" runat="server" Text="88%" /></span>
                        </div>
                        <div class="analytics-bar-bg">
                            <div id="barAptitude" runat="server" class="analytics-bar-fill" style="width: 88%; background: #0d9488;"></div>
                        </div>
                    </div>

                    <div>
                        <div style="display: flex; justify-content: space-between; font-size: 13px; font-weight: 600; margin-bottom: 4px;">
                            <span>Core CS &amp; Technical Domain</span>
                            <span style="color: #2563eb;"><asp:Literal ID="litTechScore" runat="server" Text="82%" /></span>
                        </div>
                        <div class="analytics-bar-bg">
                            <div id="barTech" runat="server" class="analytics-bar-fill" style="width: 82%; background: #2563eb;"></div>
                        </div>
                    </div>

                    <div>
                        <div style="display: flex; justify-content: space-between; font-size: 13px; font-weight: 600; margin-bottom: 4px;">
                            <span>Algorithmic Problem Solving (DSA)</span>
                            <span style="color: #7c3aed;"><asp:Literal ID="litCodingScore" runat="server" Text="79%" /></span>
                        </div>
                        <div class="analytics-bar-bg">
                            <div id="barCoding" runat="server" class="analytics-bar-fill" style="width: 79%; background: #7c3aed;"></div>
                        </div>
                    </div>
                </div>

                <div style="margin-top: 20px; padding-top: 14px; border-top: 1px solid #e2e8f0; display: flex; justify-content: space-between; align-items: center;">
                    <span style="font-size: 13px; color: #64748b;">AI Mock Interviews Completed:</span>
                    <strong style="font-size: 14px;"><asp:Literal ID="litMockCount" runat="server" Text="4 Sessions" /></strong>
                </div>
            </div>

            <!-- Placement Cell Counseling & Mentorship Log -->
            <div class="users-card">
                <h3 class="users-card-title">Placement Counseling &amp; Advisory Notes</h3>
                <p class="users-hint" style="margin-bottom: 16px;">
                    Confidential internal counseling records maintained by faculty mentors and placement officers.
                </p>

                <div style="margin-bottom: 16px;">
                    <asp:TextBox ID="txtCounselingNote" runat="server" TextMode="MultiLine" Rows="3"
                        CssClass="form-control" placeholder="Record student counseling observation, mock interview feedback, or corporate feedback..." />
                    <asp:RequiredFieldValidator ID="rfvCounselingNote" runat="server"
                        ControlToValidate="txtCounselingNote" ValidationGroup="CounselingGroup"
                        ErrorMessage="Please enter a counseling note before saving."
                        CssClass="text-danger" Display="Dynamic" style="font-size: 12px; margin-top: 4px; display: block;" />
                    <div style="margin-top: 8px; text-align: right;">
                        <asp:Button ID="btnAddCounselingNote" runat="server" CssClass="action-button primary"
                            Text="Add Counseling Note" ValidationGroup="CounselingGroup" OnClick="btnAddCounselingNote_Click" />
                    </div>
                </div>

                <div style="border-top: 1px solid #e2e8f0; padding-top: 12px;">
                    <asp:Repeater ID="rptCounselingNotes" runat="server">
                        <ItemTemplate>
                            <div style="padding: 10px 12px; background: #f8fafc; border-left: 3px solid #0d9488; border-radius: 4px; margin-bottom: 10px;">
                                <div style="display: flex; justify-content: space-between; font-size: 11px; color: #64748b; margin-bottom: 4px;">
                                    <strong><%# Server.HtmlEncode(Convert.ToString(Eval("Author"))) %></strong>
                                    <span><%# Server.HtmlEncode(Convert.ToString(Eval("Timestamp"))) %></span>
                                </div>
                                <div style="font-size: 13px; color: #1e293b;"><%# Server.HtmlEncode(Convert.ToString(Eval("NoteText"))) %></div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    <asp:Panel ID="pnlNoNotes" runat="server" Visible="false" style="font-size: 12px; color: #94a3b8; font-style: italic; text-align: center; padding: 12px 0;">
                        No counseling notes recorded for this candidate yet.
                    </asp:Panel>
                </div>
            </div>

        </div>

    </div>

</div>
</asp:Content>

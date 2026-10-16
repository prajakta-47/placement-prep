<%@ Page Title="Student Placement Management" Language="C#" MasterPageFile="~/Admin.Master"
    AutoEventWireup="true" CodeBehind="ManageStudents.aspx.cs"
    Inherits="PlacementPrep.ManageStudents" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="users-page-container">
    <asp:HiddenField ID="hfPageIndex" runat="server" Value="1" />
    <asp:HiddenField ID="hfEditStudentId" runat="server" Value="0" />

    <!-- Breadcrumb & Header -->
    <div class="users-header">
        <div>
            <div class="users-breadcrumb">
                <span>ACADEMIC &amp; RECRUITMENT OPERATIONS</span>
                <span class="users-sep">/</span>
                <span>Student Placement Dossier</span>
            </div>
            <h1 class="users-title">Student Placement Management</h1>
            <p class="users-subtitle">Comprehensive cohort dossier tracking student academic records, placement readiness index, campus interview pipelines, and corporate offer rollouts.</p>
        </div>
        <div class="users-top-actions">
            <asp:LinkButton ID="btnOpenAdd" runat="server" CssClass="action-button primary" OnClick="btnOpenAdd_Click" CausesValidation="false">
                <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <line x1="12" y1="5" x2="12" y2="19"></line>
                    <line x1="5" y1="12" x2="19" y2="12"></line>
                </svg>
                <span>Add Student</span>
            </asp:LinkButton>
        </div>
    </div>

    <!-- Alert / Feedback Banner -->
    <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="users-alert" role="status">
        <asp:Literal ID="litMessage" runat="server" />
    </asp:Panel>

    <!-- KPI Cards Grid -->
    <div class="users-kpi-grid">
        <article class="users-kpi-card">
            <div class="users-kpi-top">
                <span class="users-kpi-label">TOTAL STUDENTS</span>
                <span class="users-kpi-icon users-kpi-icon-blue">
                    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                        <circle cx="9" cy="7" r="4"></circle>
                        <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                        <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                    </svg>
                </span>
            </div>
            <div class="users-kpi-value">
                <asp:Literal ID="litTotalStudents" runat="server" Text="8,192" />
            </div>
            <div class="users-kpi-meta">
                Enrolled across all academic cohorts
            </div>
        </article>

        <article class="users-kpi-card">
            <div class="users-kpi-top">
                <span class="users-kpi-label">ELIGIBLE FOR PLACEMENT</span>
                <span class="users-kpi-icon users-kpi-icon-mint">
                    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                        <polyline points="22 4 12 14.01 9 11.01"></polyline>
                    </svg>
                </span>
            </div>
            <div class="users-kpi-value">
                <asp:Literal ID="litEligibleCount" runat="server" Text="6,480" />
            </div>
            <div class="users-kpi-meta">
                <strong class="users-kpi-good">79.1%</strong> &middot; benchmark cleared
            </div>
        </article>

        <article class="users-kpi-card">
            <div class="users-kpi-top">
                <span class="users-kpi-label">PLACED STUDENTS</span>
                <span class="users-kpi-icon users-kpi-icon-teal">
                    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <rect x="2" y="7" width="20" height="14" rx="2" ry="2"></rect>
                        <path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"></path>
                    </svg>
                </span>
            </div>
            <div class="users-kpi-value">
                <asp:Literal ID="litPlacedCount" runat="server" Text="1,240" />
            </div>
            <div class="users-kpi-meta">
                <strong class="users-kpi-good">&uarr;19.1%</strong> &middot; 44 LPA peak CTC
            </div>
        </article>

        <article class="users-kpi-card">
            <div class="users-kpi-top">
                <span class="users-kpi-label">PROFILES INCOMPLETE</span>
                <span class="users-kpi-icon users-kpi-icon-blue">
                    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <circle cx="12" cy="12" r="10"></circle>
                        <line x1="12" y1="8" x2="12" y2="12"></line>
                        <line x1="12" y1="16" x2="12.01" y2="16"></line>
                    </svg>
                </span>
            </div>
            <div class="users-kpi-value">
                <asp:Literal ID="litIncompleteCount" runat="server" Text="472" />
            </div>
            <div class="users-kpi-meta">
                Pending resume &amp; academic verification
            </div>
        </article>
    </div>

    <!-- Filters & Search Toolbar -->
    <div class="users-filter-bar">
        <div class="users-search-field">
            <span class="users-search-icon" aria-hidden="true">
                <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="11" cy="11" r="8"></circle>
                    <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                </svg>
            </span>
            <asp:TextBox ID="txtSearch" runat="server" CssClass="users-search-input"
                placeholder="Search by student name, enrollment ID, or email..." />
        </div>
        <asp:DropDownList ID="ddlDepartmentFilter" runat="server" CssClass="users-filter-select" />
        <asp:DropDownList ID="ddlBatchFilter" runat="server" CssClass="users-filter-select" />
        <asp:DropDownList ID="ddlEligibilityFilter" runat="server" CssClass="users-filter-select">
            <asp:ListItem Text="All Eligibility" Value="All" />
            <asp:ListItem Text="Eligible" Value="Eligible" />
            <asp:ListItem Text="Ineligible" Value="Ineligible" />
            <asp:ListItem Text="Pending Review" Value="Pending Review" />
        </asp:DropDownList>
        <asp:DropDownList ID="ddlPlacementStatusFilter" runat="server" CssClass="users-filter-select">
            <asp:ListItem Text="All Placement Status" Value="All" />
            <asp:ListItem Text="Placed" Value="Placed" />
            <asp:ListItem Text="In Process" Value="In Process" />
            <asp:ListItem Text="Unplaced" Value="Unplaced" />
            <asp:ListItem Text="Opted Out" Value="Opted Out" />
        </asp:DropDownList>
        <asp:LinkButton ID="btnApplyFilters" runat="server" CssClass="users-filter-button"
            OnClick="btnApplyFilters_Click" CausesValidation="false" ToolTip="Apply filters">
            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3"></polygon>
            </svg>
        </asp:LinkButton>
        <asp:LinkButton ID="btnResetFilters" runat="server" CssClass="action-button secondary compact-btn"
            OnClick="btnResetFilters_Click" CausesValidation="false" ToolTip="Reset filters">
            Reset
        </asp:LinkButton>
    </div>

    <!-- Students Data Table -->
    <div class="users-table-panel">
        <asp:Repeater ID="rptStudents" runat="server" OnItemCommand="rptStudents_ItemCommand">
            <HeaderTemplate>
                <div class="table-scroll">
                <table class="users-table">
                    <thead>
                        <tr>
                            <th>Student Identity</th>
                            <th>Enrollment ID</th>
                            <th>Department</th>
                            <th style="width: 70px;">Batch</th>
                            <th style="width: 70px;">CGPA</th>
                            <th style="width: 110px;">Eligibility</th>
                            <th style="width: 120px;">Placement Status</th>
                            <th style="width: 170px;">Actions</th>
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
                                <a href='<%# ResolveUrl("~/Admin/StudentDetails.aspx?id=" + Eval("StudentId")) %>' style="color: #0f172a; text-decoration: none; font-weight: 600;">
                                    <%# Server.HtmlEncode(Convert.ToString(Eval("FullName"))) %>
                                </a>
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
                            <%# Eval("CgpaDisplay") %>
                        </strong>
                    </td>
                    <td>
                        <span class='<%# Eval("EligibilityClass") %>'>
                            <%# Server.HtmlEncode(Convert.ToString(Eval("PlacementEligibility"))) %>
                        </span>
                    </td>
                    <td>
                        <span class='<%# Eval("PlacementStatusClass") %>'>
                            <i></i><%# Server.HtmlEncode(Convert.ToString(Eval("PlacementStatus"))) %>
                        </span>
                        <%# !string.IsNullOrEmpty(Convert.ToString(Eval("CompanyPlaced"))) ? "<small class='placed-company'>@ " + Server.HtmlEncode(Convert.ToString(Eval("CompanyPlaced"))) + "</small>" : "" %>
                    </td>
                    <td class="users-actions">
                        <a href='<%# ResolveUrl("~/Admin/StudentDetails.aspx?id=" + Eval("StudentId")) %>' class="table-link" title="Open full student profile">Dossier &rarr;</a>
                        <asp:LinkButton ID="lnkViewDossier" runat="server" CssClass="table-link"
                            CommandName="ViewDossier" CommandArgument='<%# Eval("StudentId") %>'
                            CausesValidation="false">Quick View</asp:LinkButton>
                        <asp:LinkButton ID="lnkEdit" runat="server" CssClass="table-link"
                            CommandName="EditStudent" CommandArgument='<%# Eval("StudentId") %>'
                            CausesValidation="false">Edit</asp:LinkButton>
                        <asp:LinkButton ID="lnkToggleElig" runat="server" CssClass="table-link"
                            CommandName="ToggleEligibility" CommandArgument='<%# Eval("StudentId") %>'
                            CausesValidation="false">Audit</asp:LinkButton>
                        <asp:LinkButton ID="lnkDelete" runat="server" CssClass="table-link text-danger"
                            CommandName="DeleteStudent" CommandArgument='<%# Eval("StudentId") %>'
                            CausesValidation="false"
                            OnClientClick="return confirm('Permanently remove this student record?');">Delete</asp:LinkButton>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                    </tbody>
                </table>
                </div>
            </FooterTemplate>
        </asp:Repeater>

        <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="users-empty">
            No student records match the selected filters.
        </asp:Panel>

        <!-- Pagination Bar -->
        <div class="users-pagination">
            <span class="users-page-info">
                <asp:Literal ID="litPageInfo" runat="server" />
            </span>
            <div class="users-page-size">
                <span>Rows per page</span>
                <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true"
                    OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged" CssClass="users-filter-select compact">
                    <asp:ListItem Text="10" Value="10" Selected="True" />
                    <asp:ListItem Text="25" Value="25" />
                    <asp:ListItem Text="50" Value="50" />
                </asp:DropDownList>
            </div>
            <div class="users-page-nav">
                <asp:LinkButton ID="btnPrevPage" runat="server" CssClass="users-page-btn"
                    OnClick="btnPrevPage_Click" CausesValidation="false">&lsaquo;</asp:LinkButton>
                <asp:Repeater ID="rptPages" runat="server" OnItemCommand="rptPages_ItemCommand">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkPage" runat="server"
                            CssClass='<%# (bool)Eval("IsCurrent") ? "users-page-btn active" : "users-page-btn" %>'
                            CommandName="GoPage" CommandArgument='<%# Eval("PageNumber") %>'
                            CausesValidation="false"
                            Text='<%# Eval("PageNumber") %>' />
                    </ItemTemplate>
                </asp:Repeater>
                <asp:LinkButton ID="btnNextPage" runat="server" CssClass="users-page-btn"
                    OnClick="btnNextPage_Click" CausesValidation="false">&rsaquo;</asp:LinkButton>
            </div>
        </div>
    </div>

    <!-- Student Dossier Modal -->
    <asp:Panel ID="pnlDossierModal" runat="server" Visible="false" CssClass="users-modal-backdrop">
        <div class="users-modal users-modal-large" role="dialog" aria-modal="true" aria-labelledby="dossierModalTitle">
            <div class="users-modal-header">
                <h2 id="dossierModalTitle">Candidate Placement Dossier</h2>
                <asp:LinkButton ID="btnCloseDossier" runat="server" CssClass="users-modal-close"
                    OnClick="btnCloseDossier_Click" CausesValidation="false" aria-label="Close">&times;</asp:LinkButton>
            </div>
            <div class="users-modal-body qb-preview-body">
                <!-- Candidate Header Banner -->
                <div class="dossier-hero">
                    <div class="dossier-avatar"><asp:Literal ID="litDossierInitials" runat="server" /></div>
                    <div class="dossier-hero-info">
                        <h3><asp:Literal ID="litDossierName" runat="server" /></h3>
                        <p>
                            <strong class="qb-code"><asp:Literal ID="litDossierEnrollment" runat="server" /></strong> &middot;
                            <span><asp:Literal ID="litDossierEmail" runat="server" /></span> &middot;
                            <span><asp:Literal ID="litDossierDept" runat="server" /></span> (Batch of <asp:Literal ID="litDossierBatch" runat="server" />)
                        </p>
                    </div>
                    <div class="dossier-hero-badges">
                        <span id="badgeDossierElig" runat="server" class="elig-pill elig-eligible"><asp:Literal ID="litDossierElig" runat="server" /></span>
                        <span id="badgeDossierStatus" runat="server" class="status-pill status-active"><asp:Literal ID="litDossierStatus" runat="server" /></span>
                    </div>
                </div>

                <!-- 4 Performance Telemetry Widgets -->
                <div class="dossier-metrics-grid">
                    <div class="dossier-metric-card">
                        <span class="dossier-metric-num"><asp:Literal ID="litDossierPri" runat="server" />/100</span>
                        <span class="dossier-metric-lbl">Placement Readiness Index</span>
                    </div>
                    <div class="dossier-metric-card">
                        <span class="dossier-metric-num"><asp:Literal ID="litDossierAts" runat="server" />%</span>
                        <span class="dossier-metric-lbl">ATS Resume Score</span>
                    </div>
                    <div class="dossier-metric-card">
                        <span class="dossier-metric-num"><asp:Literal ID="litDossierCgpa" runat="server" /></span>
                        <span class="dossier-metric-lbl">Academic CGPA</span>
                    </div>
                    <div class="dossier-metric-card">
                        <span class="dossier-metric-num"><asp:Literal ID="litDossierTests" runat="server" /> Tests</span>
                        <span class="dossier-metric-lbl">Evaluations Completed</span>
                    </div>
                </div>

                <!-- Technical Skills -->
                <div class="qb-preview-section">
                    <h3 class="qb-section-heading">Verified Technical Competencies</h3>
                    <div class="dossier-skills-box">
                        <asp:Literal ID="litDossierSkills" runat="server" />
                    </div>
                </div>

                <!-- Placement Applications & Pipeline -->
                <div class="qb-preview-section">
                    <h3 class="qb-section-heading">Recruitment Pipeline &amp; Active Applications</h3>
                    <div class="qb-prompt-box">
                        <asp:Literal ID="litDossierPipeline" runat="server" />
                    </div>
                </div>

                <!-- Profile Links -->
                <div class="qb-preview-section">
                    <h3 class="qb-section-heading">Professional Profile Links</h3>
                    <div class="qb-options-grid">
                        <div class="qb-option-card">
                            <span class="qb-opt-letter">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><rect x="2" y="3" width="20" height="14" rx="2" ry="2"></rect><line x1="8" y1="21" x2="16" y2="21"></line><line x1="12" y1="17" x2="12" y2="21"></line></svg>
                            </span>
                            <span class="qb-opt-text">GitHub: <strong><asp:Literal ID="litDossierGithub" runat="server" /></strong></span>
                        </div>
                        <div class="qb-option-card">
                            <span class="qb-opt-letter">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><rect x="2" y="7" width="20" height="14" rx="2" ry="2"></rect><path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"></path></svg>
                            </span>
                            <span class="qb-opt-text">LinkedIn: <strong><asp:Literal ID="litDossierLinkedin" runat="server" /></strong></span>
                        </div>
                    </div>
                </div>

                <div class="users-hint">
                    <strong>Demonstration Sample Data:</strong> The dossier values above reflect simulated institutional benchmark records for UI review.
                </div>
            </div>
            <div class="users-modal-footer">
                <a id="btnFullDossierPage" runat="server" class="action-button" href="#">Open Full Profile &rarr;</a>
                <asp:LinkButton ID="btnDismissDossier" runat="server" CssClass="action-button primary"
                    OnClick="btnCloseDossier_Click" CausesValidation="false">Close Dossier</asp:LinkButton>
            </div>
        </div>
    </asp:Panel>

    <!-- Create / Edit Student Modal -->
    <asp:Panel ID="pnlStudentModal" runat="server" Visible="false" CssClass="users-modal-backdrop">
        <div class="users-modal users-modal-large" role="dialog" aria-modal="true" aria-labelledby="studentModalTitle">
            <div class="users-modal-header">
                <h2 id="studentModalTitle"><asp:Literal ID="litModalTitle" runat="server" Text="Add Student Record" /></h2>
                <asp:LinkButton ID="btnCloseModal" runat="server" CssClass="users-modal-close"
                    OnClick="btnCloseModal_Click" CausesValidation="false" aria-label="Close">&times;</asp:LinkButton>
            </div>
            <div class="users-modal-body">
                <asp:ValidationSummary ID="valSummaryStudent" runat="server" CssClass="users-validation"
                    ValidationGroup="StudentForm" HeaderText="Please fix the following validation errors:" />

                <div class="users-form-grid">
                    <div class="users-field">
                        <label for="<%= txtFullName.ClientID %>">Full Name *</label>
                        <asp:TextBox ID="txtFullName" runat="server" MaxLength="150" placeholder="e.g. Rahul Sharma" />
                        <asp:RequiredFieldValidator ID="rfvFullName" runat="server"
                            ControlToValidate="txtFullName" ValidationGroup="StudentForm"
                            ErrorMessage="Full name is required." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field">
                        <label for="<%= txtEnrollmentId.ClientID %>">Enrollment ID *</label>
                        <asp:TextBox ID="txtEnrollmentId" runat="server" MaxLength="50" placeholder="e.g. EN-2022-CS041" />
                        <asp:RequiredFieldValidator ID="rfvEnrollmentId" runat="server"
                            ControlToValidate="txtEnrollmentId" ValidationGroup="StudentForm"
                            ErrorMessage="Enrollment ID is required." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field">
                        <label for="<%= txtEmail.ClientID %>">Institutional Email *</label>
                        <asp:TextBox ID="txtEmail" runat="server" MaxLength="256" TextMode="Email" placeholder="e.g. r.sharma@student.univ.edu" />
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                            ControlToValidate="txtEmail" ValidationGroup="StudentForm"
                            ErrorMessage="Email address is required." Display="Dynamic" CssClass="field-error" />
                        <asp:RegularExpressionValidator ID="revEmail" runat="server"
                            ControlToValidate="txtEmail" ValidationGroup="StudentForm"
                            ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                            ErrorMessage="Enter a valid email address format." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field">
                        <label for="<%= ddlFormDepartment.ClientID %>">Department</label>
                        <asp:DropDownList ID="ddlFormDepartment" runat="server">
                            <asp:ListItem Text="Computer Science" Value="Computer Science" />
                            <asp:ListItem Text="Information Technology" Value="Information Technology" />
                            <asp:ListItem Text="Electronics &amp; Comm" Value="Electronics &amp; Comm" />
                            <asp:ListItem Text="Mechanical" Value="Mechanical" />
                        </asp:DropDownList>
                    </div>

                    <div class="users-field">
                        <label for="<%= txtGradYear.ClientID %>">Graduation Batch *</label>
                        <asp:TextBox ID="txtGradYear" runat="server" Text="2025" MaxLength="4" />
                        <asp:RequiredFieldValidator ID="rfvGradYear" runat="server"
                            ControlToValidate="txtGradYear" ValidationGroup="StudentForm"
                            ErrorMessage="Graduation batch is required." Display="Dynamic" CssClass="field-error" />
                        <asp:RangeValidator ID="rvGradYear" runat="server"
                            ControlToValidate="txtGradYear" ValidationGroup="StudentForm"
                            Type="Integer" MinimumValue="2020" MaximumValue="2035"
                            ErrorMessage="Graduation year must be between 2020 and 2035." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field">
                        <label for="<%= txtCgpa.ClientID %>">Academic CGPA (0.00 - 10.00) *</label>
                        <asp:TextBox ID="txtCgpa" runat="server" Text="8.00" MaxLength="5" />
                        <asp:RequiredFieldValidator ID="rfvCgpa" runat="server"
                            ControlToValidate="txtCgpa" ValidationGroup="StudentForm"
                            ErrorMessage="CGPA is required." Display="Dynamic" CssClass="field-error" />
                        <asp:RangeValidator ID="rvCgpa" runat="server"
                            ControlToValidate="txtCgpa" ValidationGroup="StudentForm"
                            Type="Double" MinimumValue="0.00" MaximumValue="10.00"
                            ErrorMessage="CGPA must be between 0.00 and 10.00." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field">
                        <label for="<%= ddlFormEligibility.ClientID %>">Placement Eligibility</label>
                        <asp:DropDownList ID="ddlFormEligibility" runat="server">
                            <asp:ListItem Text="Eligible" Value="Eligible" Selected="True" />
                            <asp:ListItem Text="Ineligible" Value="Ineligible" />
                            <asp:ListItem Text="Pending Review" Value="Pending Review" />
                        </asp:DropDownList>
                    </div>

                    <div class="users-field">
                        <label for="<%= ddlFormPlacementStatus.ClientID %>">Placement Status</label>
                        <asp:DropDownList ID="ddlFormPlacementStatus" runat="server">
                            <asp:ListItem Text="Unplaced" Value="Unplaced" Selected="True" />
                            <asp:ListItem Text="In Process" Value="In Process" />
                            <asp:ListItem Text="Placed" Value="Placed" />
                            <asp:ListItem Text="Opted Out" Value="Opted Out" />
                        </asp:DropDownList>
                    </div>

                    <div class="users-field">
                        <label for="<%= txtCompanyPlaced.ClientID %>">Company Placed (If Placed)</label>
                        <asp:TextBox ID="txtCompanyPlaced" runat="server" MaxLength="100" placeholder="e.g. Amazon, TCS, Microsoft" />
                    </div>

                    <div class="users-field">
                        <label for="<%= txtPackageLpa.ClientID %>">Package LPA (If Placed)</label>
                        <asp:TextBox ID="txtPackageLpa" runat="server" MaxLength="6" placeholder="e.g. 18.5" />
                    </div>

                    <div class="users-field users-field-span">
                        <label for="<%= txtTechnicalSkills.ClientID %>">Technical Skills</label>
                        <asp:TextBox ID="txtTechnicalSkills" runat="server" MaxLength="500" placeholder="Comma separated, e.g. Python, Data Structures, SQL, React" />
                    </div>

                    <div class="users-field">
                        <label for="<%= txtGithub.ClientID %>">GitHub Profile (Optional)</label>
                        <asp:TextBox ID="txtGithub" runat="server" MaxLength="100" placeholder="e.g. github.com/username" />
                    </div>

                    <div class="users-field">
                        <label for="<%= txtLinkedin.ClientID %>">LinkedIn Profile (Optional)</label>
                        <asp:TextBox ID="txtLinkedin" runat="server" MaxLength="100" placeholder="e.g. linkedin.com/in/username" />
                    </div>
                </div>
            </div>
            <div class="users-modal-footer">
                <asp:LinkButton ID="btnCancelModal" runat="server" CssClass="action-button"
                    OnClick="btnCloseModal_Click" CausesValidation="false">Cancel</asp:LinkButton>
                <asp:LinkButton ID="btnSaveStudent" runat="server" CssClass="action-button primary"
                    OnClick="btnSaveStudent_Click" ValidationGroup="StudentForm">Save Student</asp:LinkButton>
            </div>
        </div>
    </asp:Panel>

</div>
</asp:Content>

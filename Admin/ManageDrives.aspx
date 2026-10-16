<%@ Page Title="Placement Drives" Language="C#" MasterPageFile="~/Admin.Master"
    AutoEventWireup="true" CodeBehind="ManageDrives.aspx.cs"
    Inherits="PlacementPrep.ManageDrives" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Placement Drives | Placement Prep Admin</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="admin-shell-page">

    <!-- Page Header -->
    <div class="users-header">
        <div>
            <div class="users-breadcrumb">
                <a href="<%= ResolveUrl("~/Admin/AdminDashboard.aspx") %>">Dashboard</a>
                <span>/</span>
                <a href="<%= ResolveUrl("~/Admin/ManageCompanies.aspx") %>">Companies</a>
                <span>/</span>
                <span>Placement Drives</span>
            </div>
            <h1 class="users-title">Placement Drive Management</h1>
            <p class="users-subtitle">
                Schedule campus recruitment drives, configure candidate eligibility cutoffs, track recruitment stages, and evaluate student applicant rosters.
            </p>
        </div>
        <div class="users-header-actions">
            <a href="<%= ResolveUrl("~/Admin/ManageCompanies.aspx") %>" class="action-button">
                Corporate Partners
            </a>
            <asp:LinkButton ID="btnOpenAddDrive" runat="server" CssClass="action-button primary"
                OnClick="btnOpenAddDrive_Click" CausesValidation="false">
                <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                    <line x1="12" y1="5" x2="12" y2="19"/>
                    <line x1="5" y1="12" x2="19" y2="12"/>
                </svg>
                Schedule Placement Drive
            </asp:LinkButton>
        </div>
    </div>

    <!-- Alert Message Banner -->
    <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="users-alert users-alert-success">
        <asp:Literal ID="litMessage" runat="server" />
    </asp:Panel>

    <!-- 4 Placement Drive KPI Summary Cards -->
    <div class="users-kpi-grid">
        <div class="users-kpi-card">
            <span class="users-kpi-label">Total Placement Drives</span>
            <div class="users-kpi-value"><asp:Literal ID="litKpiTotalDrives" runat="server" Text="0" /></div>
            <span class="users-kpi-sub">Total seasonal drives registered</span>
        </div>
        <div class="users-kpi-card">
            <span class="users-kpi-label">Open Drives</span>
            <div class="users-kpi-value"><asp:Literal ID="litKpiOpenDrives" runat="server" Text="0" /></div>
            <span class="users-kpi-sub">Accepting candidate applications</span>
        </div>
        <div class="users-kpi-card">
            <span class="users-kpi-label">Upcoming Drives</span>
            <div class="users-kpi-value"><asp:Literal ID="litKpiUpcomingDrives" runat="server" Text="0" /></div>
            <span class="users-kpi-sub">Announced for next 30 days</span>
        </div>
        <div class="users-kpi-card">
            <span class="users-kpi-label">Aggregate Openings</span>
            <div class="users-kpi-value"><asp:Literal ID="litKpiTotalOpenings" runat="server" Text="0" /></div>
            <span class="users-kpi-sub">Confirmed job vacancies</span>
        </div>
    </div>

    <!-- Filter & Search Toolbar -->
    <div class="users-filter-bar">
        <asp:HiddenField ID="hfPageIndex" runat="server" Value="1" />
        <asp:HiddenField ID="hfEditDriveId" runat="server" Value="0" />

        <div class="users-filter-group users-filter-search">
            <label for="<%= txtSearch.ClientID %>">Search Drives</label>
            <asp:TextBox ID="txtSearch" runat="server" placeholder="Company, role, drive code, location..." />
        </div>

        <div class="users-filter-group">
            <label for="<%= ddlCompanyFilter.ClientID %>">Company</label>
            <asp:DropDownList ID="ddlCompanyFilter" runat="server" AutoPostBack="true"
                OnSelectedIndexChanged="btnApplyFilters_Click" CssClass="users-filter-select">
                <asp:ListItem Text="All Companies" Value="All" Selected="True" />
            </asp:DropDownList>
        </div>

        <div class="users-filter-group">
            <label for="<%= ddlStatusFilter.ClientID %>">Drive Status</label>
            <asp:DropDownList ID="ddlStatusFilter" runat="server" AutoPostBack="true"
                OnSelectedIndexChanged="btnApplyFilters_Click" CssClass="users-filter-select">
                <asp:ListItem Text="All Statuses" Value="All" Selected="True" />
                <asp:ListItem Text="Open" Value="Open" />
                <asp:ListItem Text="Upcoming" Value="Upcoming" />
                <asp:ListItem Text="Completed" Value="Completed" />
                <asp:ListItem Text="Closed" Value="Closed" />
                <asp:ListItem Text="Draft" Value="Draft" />
            </asp:DropDownList>
        </div>

        <div class="users-filter-group">
            <label for="<%= ddlDeptFilter.ClientID %>">Department Stream</label>
            <asp:DropDownList ID="ddlDeptFilter" runat="server" AutoPostBack="true"
                OnSelectedIndexChanged="btnApplyFilters_Click" CssClass="users-filter-select">
                <asp:ListItem Text="All Streams" Value="All" Selected="True" />
                <asp:ListItem Text="Computer Science" Value="Computer Science" />
                <asp:ListItem Text="Information Technology" Value="Information Technology" />
                <asp:ListItem Text="Electronics &amp; Comm" Value="Electronics &amp; Comm" />
                <asp:ListItem Text="Mechanical" Value="Mechanical" />
            </asp:DropDownList>
        </div>

        <asp:LinkButton ID="btnApplyFilters" runat="server" CssClass="action-button primary users-filter-btn"
            OnClick="btnApplyFilters_Click" CausesValidation="false">
            Filter
        </asp:LinkButton>
        <asp:LinkButton ID="btnResetFilters" runat="server" CssClass="action-button users-filter-btn"
            OnClick="btnResetFilters_Click" CausesValidation="false">
            Reset
        </asp:LinkButton>
    </div>

    <!-- Drives Table Panel -->
    <div class="users-table-panel">
        <asp:Repeater ID="rptDrives" runat="server" OnItemCommand="rptDrives_ItemCommand">
            <HeaderTemplate>
                <div class="table-scroll">
                <table class="users-table">
                    <thead>
                        <tr>
                            <th>Drive Code &amp; Role</th>
                            <th>Company</th>
                            <th>Schedule &amp; Deadline</th>
                            <th>Eligibility Rules</th>
                            <th style="width: 110px;">Package</th>
                            <th style="width: 75px;">Openings</th>
                            <th style="width: 100px;">Status</th>
                            <th style="width: 200px;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <strong class="qb-code"><%# Server.HtmlEncode(Convert.ToString(Eval("DriveCode"))) %></strong>
                        <div style="font-size:12px; font-weight:700; color:var(--admin-ink); margin-top:2px;">
                            <%# Server.HtmlEncode(Convert.ToString(Eval("JobRole"))) %>
                        </div>
                        <small class="text-muted"><%# Server.HtmlEncode(Convert.ToString(Eval("WorkLocation"))) %></small>
                    </td>
                    <td>
                        <strong><%# Server.HtmlEncode(Convert.ToString(Eval("CompanyName"))) %></strong>
                    </td>
                    <td>
                        <div><strong>Drive:</strong> <%# string.Format("{0:MMM dd, yyyy}", Eval("DriveDate")) %></div>
                        <small class="text-muted">Deadline: <%# string.Format("{0:MMM dd, yyyy}", Eval("ApplicationDeadline")) %></small>
                    </td>
                    <td>
                        <div>
                            <span class="cgpa-badge cgpa-high">Min CGPA: <%# string.Format("{0:0.00}", Eval("MinCgpa")) %></span>
                            <span class="qb-usage-count">Batch '<%# Eval("GraduationBatch") %></span>
                        </div>
                        <small class="text-muted" style="display:block; margin-top:2px;">
                            <%# Server.HtmlEncode(Convert.ToString(Eval("EligibleDepartments"))) %>
                        </small>
                    </td>
                    <td>
                        <strong><%# Server.HtmlEncode(Convert.ToString(Eval("PackageDisplay"))) %></strong>
                    </td>
                    <td>
                        <strong class="qb-usage-count"><%# Eval("Openings") %></strong>
                    </td>
                    <td>
                        <span class='<%# Eval("StatusClass") %>'>
                            <i></i><%# Server.HtmlEncode(Convert.ToString(Eval("DriveStatus"))) %>
                        </span>
                    </td>
                    <td class="users-actions">
                        <a href='<%# ResolveUrl("~/Admin/DriveDetails.aspx?id=" + Eval("DriveId")) %>' class="table-link">Cockpit &rarr;</a>
                        <asp:LinkButton ID="lnkQuickView" runat="server" CssClass="table-link"
                            CommandName="QuickView" CommandArgument='<%# Eval("DriveId") %>'
                            CausesValidation="false">Quick View</asp:LinkButton>
                        <asp:LinkButton ID="lnkEdit" runat="server" CssClass="table-link"
                            CommandName="EditDrive" CommandArgument='<%# Eval("DriveId") %>'
                            CausesValidation="false">Edit</asp:LinkButton>
                        <asp:LinkButton ID="lnkToggleStatus" runat="server" CssClass="table-link"
                            CommandName="ToggleStatus" CommandArgument='<%# Eval("DriveId") %>'
                            CausesValidation="false">Status</asp:LinkButton>
                        <asp:LinkButton ID="lnkDelete" runat="server" CssClass="table-link text-danger"
                            CommandName="DeleteDrive" CommandArgument='<%# Eval("DriveId") %>'
                            CausesValidation="false"
                            OnClientClick="return confirm('Permanently remove this placement drive?');">Delete</asp:LinkButton>
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
            <p><strong>No placement drives match the selected filter criteria.</strong></p>
            <p class="text-muted">Try clearing the search query or adjusting your filters.</p>
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

    <!-- Quick View Drive Modal -->
    <asp:Panel ID="pnlDriveDetailsModal" runat="server" Visible="false" CssClass="users-modal-backdrop">
        <div class="users-modal users-modal-large" role="dialog" aria-modal="true" aria-labelledby="driveDetailsModalTitle">
            <div class="users-modal-header">
                <h2 id="driveDetailsModalTitle">Placement Drive Snapshot</h2>
                <asp:LinkButton ID="btnCloseDriveDetails" runat="server" CssClass="users-modal-close"
                    OnClick="btnCloseDriveDetails_Click" CausesValidation="false" aria-label="Close">&times;</asp:LinkButton>
            </div>
            <div class="users-modal-body qb-preview-body">
                <div class="dossier-hero">
                    <div class="dossier-avatar"><asp:Literal ID="litQuickCompanyInitials" runat="server" Text="DR" /></div>
                    <div class="dossier-hero-info">
                        <h3><asp:Literal ID="litQuickJobRole" runat="server" /></h3>
                        <p>
                            <strong><asp:Literal ID="litQuickCompany" runat="server" /></strong> &middot;
                            <span class="qb-code"><asp:Literal ID="litQuickDriveCode" runat="server" /></span> &middot;
                            <span><asp:Literal ID="litQuickLocation" runat="server" /></span>
                        </p>
                    </div>
                    <div class="dossier-hero-badges">
                        <span id="badgeQuickStatus" runat="server" class="status-pill status-active"><asp:Literal ID="litQuickStatus" runat="server" /></span>
                    </div>
                </div>

                <div class="dossier-metrics-grid">
                    <div class="dossier-metric-card">
                        <span class="dossier-metric-num"><asp:Literal ID="litQuickPackage" runat="server" /></span>
                        <span class="dossier-metric-lbl">CTC Package</span>
                    </div>
                    <div class="dossier-metric-card">
                        <span class="dossier-metric-num"><asp:Literal ID="litQuickOpenings" runat="server" /></span>
                        <span class="dossier-metric-lbl">Confirmed Openings</span>
                    </div>
                    <div class="dossier-metric-card">
                        <span class="dossier-metric-num"><asp:Literal ID="litQuickMinCgpa" runat="server" /></span>
                        <span class="dossier-metric-lbl">Cutoff CGPA</span>
                    </div>
                    <div class="dossier-metric-card">
                        <span class="dossier-metric-num"><asp:Literal ID="litQuickDriveDate" runat="server" /></span>
                        <span class="dossier-metric-lbl">Drive Date</span>
                    </div>
                </div>

                <!-- Eligibility Criteria -->
                <div class="qb-preview-section">
                    <h3 class="qb-section-heading">Eligibility Requirements</h3>
                    <div class="qb-options-grid">
                        <div class="qb-option-card">
                            <span class="qb-opt-letter">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M22 10v6M2 10l10-5 10 5-10 5z"></path><path d="M6 12v5c3 3 9 3 12 0v-5"></path></svg>
                            </span>
                            <span class="qb-opt-text">Eligible Streams: <strong><asp:Literal ID="litQuickDepts" runat="server" /></strong></span>
                        </div>
                        <div class="qb-option-card">
                            <span class="qb-opt-letter">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
                            </span>
                            <span class="qb-opt-text">Graduation Batch: <strong>Class of <asp:Literal ID="litQuickBatch" runat="server" /></strong></span>
                        </div>
                        <div class="qb-option-card">
                            <span class="qb-opt-letter">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                            </span>
                            <span class="qb-opt-text">Application Deadline: <strong><asp:Literal ID="litQuickDeadline" runat="server" /></strong></span>
                        </div>
                        <div class="qb-option-card">
                            <span class="qb-opt-letter">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line><polyline points="10 9 9 9 8 9"></polyline></svg>
                            </span>
                            <span class="qb-opt-text">Service Bond: <strong><asp:Literal ID="litQuickBond" runat="server" /></strong></span>
                        </div>
                    </div>
                </div>

                <!-- Recruitment Stages -->
                <div class="qb-preview-section">
                    <h3 class="qb-section-heading">Recruitment Evaluation Stages</h3>
                    <div class="qb-prompt-box">
                        <asp:Literal ID="litQuickStages" runat="server" />
                    </div>
                </div>

                <!-- Description -->
                <div class="qb-preview-section">
                    <h3 class="qb-section-heading">Job Role Description</h3>
                    <div class="qb-prompt-box">
                        <asp:Literal ID="litQuickDescription" runat="server" />
                    </div>
                </div>

                <div class="users-hint">
                    <strong>Demonstration Sample Data:</strong> Placement drive telemetry and cutoff parameters represent simulated institutional recruitment benchmarks.
                </div>
            </div>
            <div class="users-modal-footer">
                <a id="btnFullDrivePage" runat="server" class="action-button">Open Dedicated Drive Cockpit &rarr;</a>
                <asp:LinkButton ID="btnDismissDriveDetails" runat="server" CssClass="action-button primary"
                    OnClick="btnCloseDriveDetails_Click" CausesValidation="false">Close Snapshot</asp:LinkButton>
            </div>
        </div>
    </asp:Panel>

    <!-- Create / Edit Placement Drive Modal -->
    <asp:Panel ID="pnlDriveModal" runat="server" Visible="false" CssClass="users-modal-backdrop">
        <div class="users-modal users-modal-large" role="dialog" aria-modal="true" aria-labelledby="driveModalTitle">
            <div class="users-modal-header">
                <h2 id="driveModalTitle"><asp:Literal ID="litDriveModalTitle" runat="server" Text="Schedule Placement Drive" /></h2>
                <asp:LinkButton ID="btnCloseDriveModal" runat="server" CssClass="users-modal-close"
                    OnClick="btnCloseDriveModal_Click" CausesValidation="false" aria-label="Close">&times;</asp:LinkButton>
            </div>
            <div class="users-modal-body">
                <asp:ValidationSummary ID="valSummaryDrive" runat="server" CssClass="users-validation"
                    ValidationGroup="DriveForm" HeaderText="Please address the following drive configuration errors:" />

                <div class="users-form-grid">
                    <div class="users-field">
                        <label for="<%= ddlFormCompany.ClientID %>">Sponsoring Corporate Partner *</label>
                        <asp:DropDownList ID="ddlFormCompany" runat="server" />
                    </div>

                    <div class="users-field">
                        <label for="<%= txtJobRole.ClientID %>">Job Role Designation *</label>
                        <asp:TextBox ID="txtJobRole" runat="server" MaxLength="120" placeholder="e.g. Software Development Engineer - I" />
                        <asp:RequiredFieldValidator ID="rfvJobRole" runat="server"
                            ControlToValidate="txtJobRole" ValidationGroup="DriveForm"
                            ErrorMessage="Job role designation is required." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field">
                        <label for="<%= txtDriveDate.ClientID %>">Drive Execution Date *</label>
                        <asp:TextBox ID="txtDriveDate" runat="server" TextMode="Date" />
                        <asp:RequiredFieldValidator ID="rfvDriveDate" runat="server"
                            ControlToValidate="txtDriveDate" ValidationGroup="DriveForm"
                            ErrorMessage="Drive execution date is required." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field">
                        <label for="<%= txtDeadline.ClientID %>">Application Deadline *</label>
                        <asp:TextBox ID="txtDeadline" runat="server" TextMode="Date" />
                        <asp:RequiredFieldValidator ID="rfvDeadline" runat="server"
                            ControlToValidate="txtDeadline" ValidationGroup="DriveForm"
                            ErrorMessage="Application deadline is required." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field">
                        <label for="<%= txtMinCgpa.ClientID %>">Minimum Cutoff CGPA (0.00 - 10.00) *</label>
                        <asp:TextBox ID="txtMinCgpa" runat="server" Text="7.50" MaxLength="5" />
                        <asp:RequiredFieldValidator ID="rfvMinCgpa" runat="server"
                            ControlToValidate="txtMinCgpa" ValidationGroup="DriveForm"
                            ErrorMessage="Minimum CGPA is required." Display="Dynamic" CssClass="field-error" />
                        <asp:RangeValidator ID="rvMinCgpa" runat="server"
                            ControlToValidate="txtMinCgpa" ValidationGroup="DriveForm"
                            Type="Double" MinimumValue="0.00" MaximumValue="10.00"
                            ErrorMessage="CGPA cutoff must be between 0.00 and 10.00." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field">
                        <label for="<%= txtGradBatch.ClientID %>">Graduation Batch *</label>
                        <asp:TextBox ID="txtGradBatch" runat="server" Text="2025" MaxLength="4" />
                        <asp:RequiredFieldValidator ID="rfvGradBatch" runat="server"
                            ControlToValidate="txtGradBatch" ValidationGroup="DriveForm"
                            ErrorMessage="Graduation batch is required." Display="Dynamic" CssClass="field-error" />
                        <asp:RangeValidator ID="rvGradBatch" runat="server"
                            ControlToValidate="txtGradBatch" ValidationGroup="DriveForm"
                            Type="Integer" MinimumValue="2020" MaximumValue="2035"
                            ErrorMessage="Graduation batch must be between 2020 and 2035." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field">
                        <label for="<%= txtOpenings.ClientID %>">Openings Count (Min 1) *</label>
                        <asp:TextBox ID="txtOpenings" runat="server" Text="10" MaxLength="5" />
                        <asp:RequiredFieldValidator ID="rfvOpenings" runat="server"
                            ControlToValidate="txtOpenings" ValidationGroup="DriveForm"
                            ErrorMessage="Openings count is required." Display="Dynamic" CssClass="field-error" />
                        <asp:RangeValidator ID="rvOpenings" runat="server"
                            ControlToValidate="txtOpenings" ValidationGroup="DriveForm"
                            Type="Integer" MinimumValue="1" MaximumValue="10000"
                            ErrorMessage="Openings count must be at least 1." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field">
                        <label for="<%= ddlFormStatus.ClientID %>">Drive Status</label>
                        <asp:DropDownList ID="ddlFormStatus" runat="server">
                            <asp:ListItem Text="Open" Value="Open" Selected="True" />
                            <asp:ListItem Text="Upcoming" Value="Upcoming" />
                            <asp:ListItem Text="Draft" Value="Draft" />
                            <asp:ListItem Text="Closed" Value="Closed" />
                            <asp:ListItem Text="Completed" Value="Completed" />
                        </asp:DropDownList>
                    </div>

                    <div class="users-field">
                        <label for="<%= txtPkgMin.ClientID %>">Min Package LPA *</label>
                        <asp:TextBox ID="txtPkgMin" runat="server" Text="18.0" MaxLength="5" />
                        <asp:RequiredFieldValidator ID="rfvPkgMin" runat="server"
                            ControlToValidate="txtPkgMin" ValidationGroup="DriveForm"
                            ErrorMessage="Minimum package is required." Display="Dynamic" CssClass="field-error" />
                        <asp:RangeValidator ID="rvPkgMin" runat="server"
                            ControlToValidate="txtPkgMin" ValidationGroup="DriveForm"
                            Type="Double" MinimumValue="0.0" MaximumValue="150.0"
                            ErrorMessage="Minimum package must be between 0.0 and 150.0 LPA." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field">
                        <label for="<%= txtPkgMax.ClientID %>">Max Package LPA *</label>
                        <asp:TextBox ID="txtPkgMax" runat="server" Text="24.0" MaxLength="5" />
                        <asp:RequiredFieldValidator ID="rfvPkgMax" runat="server"
                            ControlToValidate="txtPkgMax" ValidationGroup="DriveForm"
                            ErrorMessage="Maximum package is required." Display="Dynamic" CssClass="field-error" />
                        <asp:RangeValidator ID="rvPkgMax" runat="server"
                            ControlToValidate="txtPkgMax" ValidationGroup="DriveForm"
                            Type="Double" MinimumValue="0.0" MaximumValue="150.0"
                            ErrorMessage="Maximum package must be between 0.0 and 150.0 LPA." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field">
                        <label for="<%= txtWorkLocation.ClientID %>">Work Locations</label>
                        <asp:TextBox ID="txtWorkLocation" runat="server" MaxLength="150" placeholder="e.g. Bangalore, Hyderabad, Pune" />
                    </div>

                    <div class="users-field">
                        <label for="<%= txtBondDetails.ClientID %>">Service Agreement / Bond</label>
                        <asp:TextBox ID="txtBondDetails" runat="server" MaxLength="100" placeholder="e.g. No Service Bond" />
                    </div>

                    <div class="users-field users-field-span">
                        <label for="<%= txtEligibleDepts.ClientID %>">Eligible Department Streams (Comma separated) *</label>
                        <asp:TextBox ID="txtEligibleDepts" runat="server" MaxLength="250" placeholder="e.g. Computer Science, Information Technology, Electronics & Comm" />
                        <asp:RequiredFieldValidator ID="rfvEligibleDepts" runat="server"
                            ControlToValidate="txtEligibleDepts" ValidationGroup="DriveForm"
                            ErrorMessage="Eligible streams are required." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field users-field-span">
                        <label for="<%= txtRecruitmentStages.ClientID %>">Recruitment Evaluation Stages</label>
                        <asp:TextBox ID="txtRecruitmentStages" runat="server" MaxLength="300" placeholder="e.g. Online Assessment, Technical Interview 1, Technical Interview 2, HR Round" />
                    </div>

                    <div class="users-field users-field-span">
                        <label for="<%= txtDescription.ClientID %>">Role Description &amp; Responsibilities</label>
                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="3" MaxLength="600" placeholder="Core problem domains, expected candidate capabilities..." />
                    </div>
                </div>
            </div>
            <div class="users-modal-footer">
                <asp:LinkButton ID="btnCancelDriveModal" runat="server" CssClass="action-button"
                    OnClick="btnCloseDriveModal_Click" CausesValidation="false">Cancel</asp:LinkButton>
                <asp:LinkButton ID="btnSaveDrive" runat="server" CssClass="action-button primary"
                    OnClick="btnSaveDrive_Click" ValidationGroup="DriveForm">Save Placement Drive</asp:LinkButton>
            </div>
        </div>
    </asp:Panel>

</div>
</asp:Content>

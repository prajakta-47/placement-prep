<%@ Page Title="Test Management" Language="C#" MasterPageFile="~/Admin.Master"
    AutoEventWireup="true" CodeBehind="ManageTests.aspx.cs"
    Inherits="PlacementPrep.ManageTests" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="users-page-container">
    <asp:HiddenField ID="hfPageIndex" runat="server" Value="1" />
    <asp:HiddenField ID="hfEditTestId" runat="server" Value="0" />

    <!-- Breadcrumb & Header -->
    <div class="users-header">
        <div>
            <div class="users-breadcrumb">
                <span>ASSESSMENT ENGINE</span>
                <span class="users-sep">/</span>
                <span>Official Assessments</span>
            </div>
            <h1 class="users-title">Test Management</h1>
            <p class="users-subtitle">Schedule, publish, and monitor comprehensive placement tests, aptitude assessments, and algorithmic coding challenges.</p>
        </div>
        <div class="users-top-actions">
            <a href="CreateTest.aspx" class="action-button primary">
                <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <line x1="12" y1="5" x2="12" y2="19"></line>
                    <line x1="5" y1="12" x2="19" y2="12"></line>
                </svg>
                <span>Create Assessment</span>
            </a>
            <asp:LinkButton ID="btnOpenCreate" runat="server" CssClass="action-button" OnClick="btnOpenCreate_Click" CausesValidation="false">
                <span>Quick Test</span>
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
                <span class="users-kpi-label">TOTAL TESTS</span>
                <span class="users-kpi-icon users-kpi-icon-blue">
                    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                        <polyline points="14 2 14 8 20 8"></polyline>
                        <line x1="16" y1="13" x2="8" y2="13"></line>
                        <line x1="16" y1="17" x2="8" y2="17"></line>
                        <polyline points="10 9 9 9 8 9"></polyline>
                    </svg>
                </span>
            </div>
            <div class="users-kpi-value">
                <asp:Literal ID="litTotalTests" runat="server" Text="124" />
            </div>
            <div class="users-kpi-meta">
                <strong class="users-kpi-good">All Time</strong> &middot; 12 active cohorts
            </div>
        </article>

        <article class="users-kpi-card">
            <div class="users-kpi-top">
                <span class="users-kpi-label">PUBLISHED TESTS</span>
                <span class="users-kpi-icon users-kpi-icon-mint">
                    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                        <polyline points="22 4 12 14.01 9 11.01"></polyline>
                    </svg>
                </span>
            </div>
            <div class="users-kpi-value">
                <asp:Literal ID="litPublishedTests" runat="server" Text="86" />
            </div>
            <div class="users-kpi-meta">
                Available for candidates
            </div>
        </article>

        <article class="users-kpi-card">
            <div class="users-kpi-top">
                <span class="users-kpi-label">DRAFT TESTS</span>
                <span class="users-kpi-icon users-kpi-icon-teal">
                    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M12 20h9"></path>
                        <path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path>
                    </svg>
                </span>
            </div>
            <div class="users-kpi-value">
                <asp:Literal ID="litDraftTests" runat="server" Text="24" />
            </div>
            <div class="users-kpi-meta">
                Under faculty composition review
            </div>
        </article>

        <article class="users-kpi-card">
            <div class="users-kpi-top">
                <span class="users-kpi-label">SCHEDULED TESTS</span>
                <span class="users-kpi-icon users-kpi-icon-blue">
                    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                        <line x1="16" y1="2" x2="16" y2="6"></line>
                        <line x1="8" y1="2" x2="8" y2="6"></line>
                        <line x1="3" y1="10" x2="21" y2="10"></line>
                    </svg>
                </span>
            </div>
            <div class="users-kpi-value">
                <asp:Literal ID="litScheduledTests" runat="server" Text="14" />
            </div>
            <div class="users-kpi-meta">
                Timed campus recruitment drives
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
                placeholder="Search by test name, code, or company..." />
        </div>
        <asp:DropDownList ID="ddlStatusFilter" runat="server" CssClass="users-filter-select">
            <asp:ListItem Text="All Status" Value="All" />
            <asp:ListItem Text="Published" Value="Published" />
            <asp:ListItem Text="Scheduled" Value="Scheduled" />
            <asp:ListItem Text="Draft" Value="Draft" />
            <asp:ListItem Text="Archived" Value="Archived" />
        </asp:DropDownList>
        <asp:DropDownList ID="ddlTypeFilter" runat="server" CssClass="users-filter-select">
            <asp:ListItem Text="All Types" Value="All" />
            <asp:ListItem Text="Aptitude" Value="Aptitude" />
            <asp:ListItem Text="Technical" Value="Technical" />
            <asp:ListItem Text="Coding" Value="Coding" />
            <asp:ListItem Text="Mixed" Value="Mixed" />
        </asp:DropDownList>
        <asp:DropDownList ID="ddlCompanyFilter" runat="server" CssClass="users-filter-select" />
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

    <!-- Tests Data Table -->
    <div class="users-table-panel">
        <asp:Repeater ID="rptTests" runat="server" OnItemCommand="rptTests_ItemCommand">
            <HeaderTemplate>
                <div class="table-scroll">
                <table class="users-table">
                    <thead>
                        <tr>
                            <th style="width: 110px;">Test Code</th>
                            <th>Assessment Title &amp; Details</th>
                            <th style="width: 110px;">Company</th>
                            <th style="width: 90px;">Track Type</th>
                            <th style="width: 70px;">Questions</th>
                            <th style="width: 80px;">Duration</th>
                            <th style="width: 170px;">Scheduled Window</th>
                            <th style="width: 95px;">Status</th>
                            <th style="width: 180px;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <strong class="qb-code"><%# Server.HtmlEncode(Convert.ToString(Eval("TestCode"))) %></strong>
                    </td>
                    <td>
                        <div class="qb-prompt-container">
                            <strong class="test-title"><%# Server.HtmlEncode(Convert.ToString(Eval("Title"))) %></strong>
                            <span class="qb-prompt-text"><%# Server.HtmlEncode(Convert.ToString(Eval("Description"))) %></span>
                        </div>
                    </td>
                    <td>
                        <span class="company-badge"><%# Server.HtmlEncode(Convert.ToString(Eval("Company"))) %></span>
                    </td>
                    <td>
                        <span class='<%# Eval("TypeClass") %>'>
                            <%# Server.HtmlEncode(Convert.ToString(Eval("TestType"))) %>
                        </span>
                    </td>
                    <td>
                        <span class="qb-usage-count"><%# Eval("TotalQuestions") %> Qs</span>
                    </td>
                    <td>
                        <span class="qb-usage-count"><%# Eval("DurationDisplay") %></span>
                    </td>
                    <td>
                        <span class="test-schedule-text"><%# Server.HtmlEncode(Convert.ToString(Eval("ScheduleDisplay"))) %></span>
                    </td>
                    <td>
                        <span class='<%# Eval("StatusClass") %>'>
                            <i></i><%# Server.HtmlEncode(Convert.ToString(Eval("Status"))) %>
                        </span>
                    </td>
                    <td class="users-actions">
                        <a href='TestDetails.aspx?id=<%# Eval("TestId") %>' class="table-link">Cockpit</a>
                        <asp:LinkButton ID="lnkView" runat="server" CssClass="table-link"
                            CommandName="ViewTest" CommandArgument='<%# Eval("TestId") %>'
                            CausesValidation="false">Quick View</asp:LinkButton>
                        <asp:LinkButton ID="lnkEdit" runat="server" CssClass="table-link"
                            CommandName="EditTest" CommandArgument='<%# Eval("TestId") %>'
                            CausesValidation="false">Edit</asp:LinkButton>
                        <asp:LinkButton ID="lnkPublish" runat="server" CssClass="table-link"
                            CommandName="PublishTest" CommandArgument='<%# Eval("TestId") %>'
                            CausesValidation="false"
                            Visible='<%# Convert.ToString(Eval("Status")) != "Published" %>'>Publish</asp:LinkButton>
                        <asp:LinkButton ID="lnkArchive" runat="server" CssClass="table-link text-warning"
                            CommandName="ArchiveTest" CommandArgument='<%# Eval("TestId") %>'
                            CausesValidation="false"
                            Visible='<%# Convert.ToString(Eval("Status")) != "Archived" %>'
                            OnClientClick="return confirm('Archive this assessment? Candidates will no longer be able to take it.');">Archive</asp:LinkButton>
                        <asp:LinkButton ID="lnkDelete" runat="server" CssClass="table-link text-danger"
                            CommandName="DeleteTest" CommandArgument='<%# Eval("TestId") %>'
                            CausesValidation="false"
                            OnClientClick="return confirm('Are you sure you want to permanently delete this assessment record?');">Delete</asp:LinkButton>
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
            No assessments found matching the selected filters.
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

    <!-- Create / Edit Test Modal -->
    <asp:Panel ID="pnlTestModal" runat="server" Visible="false" CssClass="users-modal-backdrop">
        <div class="users-modal users-modal-large" role="dialog" aria-modal="true" aria-labelledby="testModalTitle">
            <div class="users-modal-header">
                <h2 id="testModalTitle"><asp:Literal ID="litModalTitle" runat="server" Text="Create Assessment" /></h2>
                <asp:LinkButton ID="btnCloseModal" runat="server" CssClass="users-modal-close"
                    OnClick="btnCloseModal_Click" CausesValidation="false" aria-label="Close">&times;</asp:LinkButton>
            </div>
            <div class="users-modal-body">
                <asp:ValidationSummary ID="valSummaryTest" runat="server" CssClass="users-validation"
                    ValidationGroup="TestForm" HeaderText="Please address the following validation items:" />

                <div class="users-form-grid">
                    <div class="users-field users-field-span">
                        <label for="<%= txtTestName.ClientID %>">Test Name / Title *</label>
                        <asp:TextBox ID="txtTestName" runat="server" MaxLength="150" placeholder="e.g. TCS NQT National Qualifier 2026" />
                        <asp:RequiredFieldValidator ID="rfvTestName" runat="server"
                            ControlToValidate="txtTestName" ValidationGroup="TestForm"
                            ErrorMessage="Test name is required." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field">
                        <label for="<%= txtCompany.ClientID %>">Company / Assessment Owner *</label>
                        <asp:TextBox ID="txtCompany" runat="server" MaxLength="100" placeholder="e.g. Amazon, TCS, Placement Cell" />
                        <asp:RequiredFieldValidator ID="rfvCompany" runat="server"
                            ControlToValidate="txtCompany" ValidationGroup="TestForm"
                            ErrorMessage="Company or assessment owner is required." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field">
                        <label for="<%= ddlFormType.ClientID %>">Track Type</label>
                        <asp:DropDownList ID="ddlFormType" runat="server">
                            <asp:ListItem Text="Aptitude" Value="Aptitude" />
                            <asp:ListItem Text="Technical" Value="Technical" />
                            <asp:ListItem Text="Coding" Value="Coding" />
                            <asp:ListItem Text="Mixed" Value="Mixed" Selected="True" />
                        </asp:DropDownList>
                    </div>

                    <div class="users-field">
                        <label for="<%= txtDuration.ClientID %>">Duration (Minutes) *</label>
                        <asp:TextBox ID="txtDuration" runat="server" Text="60" MaxLength="4" />
                        <asp:RequiredFieldValidator ID="rfvDuration" runat="server"
                            ControlToValidate="txtDuration" ValidationGroup="TestForm"
                            ErrorMessage="Duration is required." Display="Dynamic" CssClass="field-error" />
                        <asp:RangeValidator ID="rvDuration" runat="server"
                            ControlToValidate="txtDuration" ValidationGroup="TestForm"
                            Type="Integer" MinimumValue="1" MaximumValue="1440"
                            ErrorMessage="Duration must be between 1 and 1440 minutes." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field">
                        <label for="<%= txtTotalMarks.ClientID %>">Total Marks *</label>
                        <asp:TextBox ID="txtTotalMarks" runat="server" Text="100" MaxLength="4" />
                        <asp:RequiredFieldValidator ID="rfvTotalMarks" runat="server"
                            ControlToValidate="txtTotalMarks" ValidationGroup="TestForm"
                            ErrorMessage="Total marks is required." Display="Dynamic" CssClass="field-error" />
                        <asp:RangeValidator ID="rvTotalMarks" runat="server"
                            ControlToValidate="txtTotalMarks" ValidationGroup="TestForm"
                            Type="Integer" MinimumValue="1" MaximumValue="1000"
                            ErrorMessage="Total marks must be between 1 and 1000." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field">
                        <label for="<%= txtQuestionCount.ClientID %>">Number of Questions *</label>
                        <asp:TextBox ID="txtQuestionCount" runat="server" Text="30" MaxLength="4" />
                        <asp:RequiredFieldValidator ID="rfvQuestionCount" runat="server"
                            ControlToValidate="txtQuestionCount" ValidationGroup="TestForm"
                            ErrorMessage="Question count is required." Display="Dynamic" CssClass="field-error" />
                        <asp:RangeValidator ID="rvQuestionCount" runat="server"
                            ControlToValidate="txtQuestionCount" ValidationGroup="TestForm"
                            Type="Integer" MinimumValue="1" MaximumValue="500"
                            ErrorMessage="Question count must be between 1 and 500." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field">
                        <label for="<%= ddlFormStatus.ClientID %>">Status</label>
                        <asp:DropDownList ID="ddlFormStatus" runat="server">
                            <asp:ListItem Text="Draft" Value="Draft" />
                            <asp:ListItem Text="Published" Value="Published" Selected="True" />
                            <asp:ListItem Text="Scheduled" Value="Scheduled" />
                            <asp:ListItem Text="Archived" Value="Archived" />
                        </asp:DropDownList>
                    </div>

                    <div class="users-field">
                        <label for="<%= txtScheduledStart.ClientID %>">Start Date &amp; Time (Optional)</label>
                        <asp:TextBox ID="txtScheduledStart" runat="server" placeholder="YYYY-MM-DD HH:mm (e.g. 2026-10-24 10:00)" />
                        <small class="users-hint">Required if Status is set to 'Scheduled'.</small>
                    </div>

                    <div class="users-field">
                        <label for="<%= txtScheduledEnd.ClientID %>">End Date &amp; Time (Optional)</label>
                        <asp:TextBox ID="txtScheduledEnd" runat="server" placeholder="YYYY-MM-DD HH:mm (e.g. 2026-10-24 12:00)" />
                        <small class="users-hint">Must be after Start Date &amp; Time.</small>
                    </div>

                    <div class="users-field users-field-span">
                        <label for="<%= txtDescription.ClientID %>">Description / Syllabus Overview</label>
                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="2" MaxLength="1000"
                            placeholder="Brief description of subjects, eligible departments, and benchmark purpose..." />
                    </div>

                    <div class="users-field users-field-span">
                        <label for="<%= txtInstructions.ClientID %>">Proctoring Rules &amp; Candidate Instructions</label>
                        <asp:TextBox ID="txtInstructions" runat="server" TextMode="MultiLine" Rows="2" MaxLength="1000"
                            placeholder="Guidelines for webcam monitoring, tab-switching limits, negative marks, and calculator usage..." />
                    </div>
                </div>
            </div>
            <div class="users-modal-footer">
                <asp:LinkButton ID="btnCancelModal" runat="server" CssClass="action-button"
                    OnClick="btnCloseModal_Click" CausesValidation="false">Cancel</asp:LinkButton>
                <asp:LinkButton ID="btnSaveTest" runat="server" CssClass="action-button primary"
                    OnClick="btnSaveTest_Click" ValidationGroup="TestForm">Save Test</asp:LinkButton>
            </div>
        </div>
    </asp:Panel>

    <!-- View Test Details Modal -->
    <asp:Panel ID="pnlViewModal" runat="server" Visible="false" CssClass="users-modal-backdrop">
        <div class="users-modal users-modal-large" role="dialog" aria-modal="true" aria-labelledby="viewTestModalTitle">
            <div class="users-modal-header">
                <h2 id="viewTestModalTitle">Assessment Details</h2>
                <asp:LinkButton ID="btnCloseView" runat="server" CssClass="users-modal-close"
                    OnClick="btnCloseView_Click" CausesValidation="false" aria-label="Close">&times;</asp:LinkButton>
            </div>
            <div class="users-modal-body qb-preview-body">
                <div class="qb-preview-meta-row">
                    <span class="qb-code-pill"><asp:Literal ID="litViewCode" runat="server" /></span>
                    <span class="company-badge"><asp:Literal ID="litViewCompany" runat="server" /></span>
                    <span class="test-type-pill type-mixed"><asp:Literal ID="litViewType" runat="server" /></span>
                    <span class="test-status-pill status-published"><asp:Literal ID="litViewStatus" runat="server" /></span>
                    <span class="qb-weight-pill">Marks: <asp:Literal ID="litViewMarks" runat="server" /> | <asp:Literal ID="litViewQuestions" runat="server" /> Questions</span>
                </div>

                <div class="qb-preview-section">
                    <h3 class="qb-section-heading">Assessment Title</h3>
                    <div class="qb-prompt-box">
                        <strong style="font-size: 13px; color: #1e293b;"><asp:Literal ID="litViewTitle" runat="server" /></strong>
                        <p style="margin: 6px 0 0; color: #64748b; font-size: 11px;"><asp:Literal ID="litViewDescription" runat="server" /></p>
                    </div>
                </div>

                <div class="qb-preview-section">
                    <h3 class="qb-section-heading">Configuration &amp; Schedule Window</h3>
                    <div class="qb-options-grid">
                        <div class="qb-option-card">
                            <span class="qb-opt-letter">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                            </span>
                            <span class="qb-opt-text">Duration: <strong><asp:Literal ID="litViewDuration" runat="server" /></strong></span>
                        </div>
                        <div class="qb-option-card">
                            <span class="qb-opt-letter">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
                            </span>
                            <span class="qb-opt-text">Window: <strong><asp:Literal ID="litViewSchedule" runat="server" /></strong></span>
                        </div>
                        <div class="qb-option-card">
                            <span class="qb-opt-letter">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                            </span>
                            <span class="qb-opt-text">Owner: <strong><asp:Literal ID="litViewCreatedBy" runat="server" /></strong></span>
                        </div>
                        <div class="qb-option-card">
                            <span class="qb-opt-letter">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line><polyline points="10 9 9 9 8 9"></polyline></svg>
                            </span>
                            <span class="qb-opt-text">Last Updated: <strong><asp:Literal ID="litViewUpdated" runat="server" /></strong></span>
                        </div>
                    </div>
                </div>

                <div class="qb-preview-section">
                    <h3 class="qb-section-heading">Proctoring Rules &amp; Candidate Guidelines</h3>
                    <div class="qb-explanation-box">
                        <p class="qb-explanation-text"><asp:Literal ID="litViewInstructions" runat="server" /></p>
                    </div>
                </div>
            </div>
            <div class="users-modal-footer">
                <asp:LinkButton ID="btnDismissView" runat="server" CssClass="action-button primary"
                    OnClick="btnCloseView_Click" CausesValidation="false">Close Details</asp:LinkButton>
            </div>
        </div>
    </asp:Panel>

</div>
</asp:Content>

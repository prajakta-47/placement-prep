<%@ Page Title="Test Details" Language="C#" MasterPageFile="~/Admin.Master"
    AutoEventWireup="true" CodeBehind="TestDetails.aspx.cs"
    Inherits="PlacementPrep.Admin.TestDetails" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="users-page-container">
    <asp:HiddenField ID="hfTestId" runat="server" Value="0" />
    <asp:HiddenField ID="hfActiveTab" runat="server" Value="overview" />

    <!-- Breadcrumb & Header -->
    <div class="users-header">
        <div>
            <div class="users-breadcrumb">
                <span>ACADEMIC &amp; ASSESSMENT OPERATIONS</span>
                <span class="users-sep">/</span>
                <a href="ManageTests.aspx" style="color: #64748b; text-decoration: none;">Test Management</a>
                <span class="users-sep">/</span>
                <span>Assessment Cockpit</span>
            </div>
            <h1 class="users-title">
                <asp:Literal ID="litTestTitle" runat="server" Text="Assessment Details" />
            </h1>
            <p class="users-subtitle">
                <asp:Literal ID="litTestCodeBadge" runat="server" /> &middot; Sponsoring Partner: <strong><asp:Literal ID="litCompany" runat="server" /></strong> &middot; Track: <asp:Literal ID="litType" runat="server" />
            </p>
        </div>
        <div class="users-top-actions">
            <a href="ManageTests.aspx" class="action-button">
                <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <line x1="19" y1="12" x2="5" y2="12"></line>
                    <polyline points="12 19 5 12 12 5"></polyline>
                </svg>
                <span>All Assessments</span>
            </a>
            <asp:LinkButton ID="btnPublish" runat="server" CssClass="action-button primary" OnClick="btnPublish_Click">
                <span>Publish Test</span>
            </asp:LinkButton>
            <asp:LinkButton ID="btnRevertDraft" runat="server" CssClass="action-button" OnClick="btnRevertDraft_Click">
                <span>Revert to Draft</span>
            </asp:LinkButton>
        </div>
    </div>

    <!-- Alert Banner -->
    <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="users-alert" role="status">
        <asp:Literal ID="litMessage" runat="server" />
    </asp:Panel>

    <!-- KPI Cards Grid -->
    <div class="users-kpi-grid">
        <article class="users-kpi-card">
            <div class="users-kpi-top">
                <span class="users-kpi-label">TOTAL MARKS</span>
                <span class="users-kpi-icon users-kpi-icon-blue">
                    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon>
                    </svg>
                </span>
            </div>
            <div class="users-kpi-value">
                <asp:Literal ID="litKpiMarks" runat="server" Text="100" />
            </div>
            <div class="users-kpi-meta">
                Passing Cutoff: <strong><asp:Literal ID="litKpiPassScore" runat="server" Text="65%" /></strong>
            </div>
        </article>

        <article class="users-kpi-card">
            <div class="users-kpi-top">
                <span class="users-kpi-label">TIME DURATION</span>
                <span class="users-kpi-icon users-kpi-icon-mint">
                    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <circle cx="12" cy="12" r="10"></circle>
                        <polyline points="12 6 12 12 14 14"></polyline>
                    </svg>
                </span>
            </div>
            <div class="users-kpi-value">
                <asp:Literal ID="litKpiDuration" runat="server" Text="90 mins" />
            </div>
            <div class="users-kpi-meta">
                Window: <asp:Literal ID="litKpiSchedule" runat="server" Text="On-Demand" />
            </div>
        </article>

        <article class="users-kpi-card">
            <div class="users-kpi-top">
                <span class="users-kpi-label">BLUEPRINT QUESTIONS</span>
                <span class="users-kpi-icon users-kpi-icon-teal">
                    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <rect x="4" y="3" width="16" height="18" rx="2"></rect>
                        <path d="M8 7h8M8 11h8M8 15h5"></path>
                    </svg>
                </span>
            </div>
            <div class="users-kpi-value">
                <asp:Literal ID="litKpiQuestions" runat="server" Text="25" />
            </div>
            <div class="users-kpi-meta">
                Multi-domain coverage
            </div>
        </article>

        <article class="users-kpi-card">
            <div class="users-kpi-top">
                <span class="users-kpi-label">STATUS &amp; PROCTORING</span>
                <span class="users-kpi-icon users-kpi-icon-blue">
                    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
                    </svg>
                </span>
            </div>
            <div class="users-kpi-value" style="font-size: 16px; margin-top: 10px;">
                <asp:Literal ID="litKpiStatusPill" runat="server" />
            </div>
            <div class="users-kpi-meta">
                <asp:Literal ID="litKpiProctoring" runat="server" Text="Strict Lockdown" />
            </div>
        </article>
    </div>

    <!-- Navigation Tabs -->
    <div class="qb-tabs-bar" style="margin-bottom: 20px;">
        <asp:LinkButton ID="tabBtnOverview" runat="server" CssClass="qb-tab active" OnClick="tabBtn_Click" CommandArgument="overview">
            Assessment Overview
        </asp:LinkButton>
        <asp:LinkButton ID="tabBtnQuestions" runat="server" CssClass="qb-tab" OnClick="tabBtn_Click" CommandArgument="questions">
            Question Composition (<asp:Literal ID="litTabQuestionCount" runat="server" Text="0" />)
        </asp:LinkButton>
        <asp:LinkButton ID="tabBtnRoster" runat="server" CssClass="qb-tab" OnClick="tabBtn_Click" CommandArgument="roster">
            Candidate Submissions (<asp:Literal ID="litTabStudentCount" runat="server" Text="5" />)
        </asp:LinkButton>
        <asp:LinkButton ID="tabBtnEdit" runat="server" CssClass="qb-tab" OnClick="tabBtn_Click" CommandArgument="edit">
            Edit Configuration
        </asp:LinkButton>
    </div>

    <!-- Tab 1: Overview Panel -->
    <asp:Panel ID="pnlTabOverview" runat="server" Visible="true">
        <div style="background: #ffffff; border: 1px solid #e2e8f0; border-radius: 8px; padding: 24px; margin-bottom: 24px;">
            <div style="font-size: 14px; font-weight: 700; color: #0f172a; margin-bottom: 16px; padding-bottom: 8px; border-bottom: 1px solid #f1f5f9;">
                Comprehensive Examination Overview
            </div>

            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 24px; margin-bottom: 24px;">
                <div>
                    <h4 style="font-size: 11px; text-transform: uppercase; color: #64748b; font-weight: 700; margin-bottom: 6px;">Target Cohorts &amp; Departments</h4>
                    <p style="font-size: 13px; color: #334155; margin: 0 0 12px;">
                        Department: <strong><asp:Literal ID="litTargetDept" runat="server" Text="All Departments" /></strong><br />
                        Batch Cohort: <strong><asp:Literal ID="litTargetBatch" runat="server" Text="Batch 2025" /></strong>
                    </p>

                    <h4 style="font-size: 11px; text-transform: uppercase; color: #64748b; font-weight: 700; margin-bottom: 6px;">Schedule Availability</h4>
                    <p style="font-size: 13px; color: #334155; margin: 0 0 12px;">
                        <asp:Literal ID="litScheduleDetail" runat="server" Text="On-Demand Assessment" />
                    </p>

                    <h4 style="font-size: 11px; text-transform: uppercase; color: #64748b; font-weight: 700; margin-bottom: 6px;">Scoring &amp; Shuffling Policies</h4>
                    <p style="font-size: 13px; color: #334155; margin: 0;">
                        Negative Marking: <strong><asp:Literal ID="litNegativeMarkingDisplay" runat="server" Text="Enabled (0.50 pts)" /></strong><br />
                        Question Shuffling: <strong><asp:Literal ID="litShufflingDisplay" runat="server" Text="Enabled" /></strong>
                    </p>
                </div>

                <div>
                    <h4 style="font-size: 11px; text-transform: uppercase; color: #64748b; font-weight: 700; margin-bottom: 6px;">Description &amp; Syllabus</h4>
                    <div style="font-size: 13px; color: #334155; line-height: 1.6; background: #f8fafc; padding: 12px; border-radius: 6px; border: 1px solid #e2e8f0; margin-bottom: 12px;">
                        <asp:Literal ID="litDescription" runat="server" Text="No description provided." />
                    </div>

                    <h4 style="font-size: 11px; text-transform: uppercase; color: #64748b; font-weight: 700; margin-bottom: 6px;">Candidate Proctoring Guidelines</h4>
                    <div style="font-size: 12px; color: #475569; line-height: 1.5; background: #fffbeb; padding: 12px; border-radius: 6px; border: 1px solid #fef3c7;">
                        <asp:Literal ID="litInstructions" runat="server" Text="Standard code of conduct applies." />
                    </div>
                </div>
            </div>

            <div style="font-size: 11px; color: #94a3b8; border-top: 1px solid #f1f5f9; padding-top: 12px; display: flex; justify-content: space-between;">
                <span>Created by: <strong><asp:Literal ID="litCreatedBy" runat="server" Text="Admin" /></strong></span>
                <span>Last Updated: <strong><asp:Literal ID="litUpdatedAt" runat="server" /></strong></span>
            </div>
        </div>
    </asp:Panel>

    <!-- Tab 2: Questions in Assessment -->
    <asp:Panel ID="pnlTabQuestions" runat="server" Visible="false">
        <div class="users-table-card" style="margin-bottom: 24px;">
            <asp:Repeater ID="rptTestQuestions" runat="server">
                <HeaderTemplate>
                    <table class="users-table" role="table">
                        <thead>
                            <tr>
                                <th style="width: 140px;">CODE</th>
                                <th style="width: 110px;">TYPE</th>
                                <th>QUESTION SUMMARY</th>
                                <th style="width: 110px;">DIFFICULTY</th>
                                <th style="width: 90px;">MARKS</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <strong class="user-id-badge"><%# Eval("Code") %></strong>
                        </td>
                        <td>
                            <span class="user-dept" style="padding: 2px 7px; font-size: 10px; font-weight: 600; border-radius: 4px; background: #e0f2fe; color: #0369a1;">
                                <%# Eval("Type") %>
                            </span>
                        </td>
                        <td>
                            <span style="font-weight: 600; color: #0f172a;"><%# Eval("Title") %></span>
                            <div style="font-size: 11px; color: #64748b; margin-top: 2px;"><%# Eval("Snippet") %></div>
                        </td>
                        <td>
                            <span class='<%# Eval("DifficultyClass") %>'><%# Eval("Difficulty") %></span>
                        </td>
                        <td>
                            <strong>+<%# Eval("Marks") %></strong>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                        </tbody>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </asp:Panel>

    <!-- Tab 3: Candidate Submissions Roster -->
    <asp:Panel ID="pnlTabRoster" runat="server" Visible="false">
        <div class="users-table-card" style="margin-bottom: 24px;">
            <asp:Repeater ID="rptStudentRoster" runat="server">
                <HeaderTemplate>
                    <table class="users-table" role="table">
                        <thead>
                            <tr>
                                <th style="width: 140px;">ROLL NO</th>
                                <th>STUDENT NAME &amp; DEPT</th>
                                <th style="width: 110px;">SCORE</th>
                                <th style="width: 110px;">PERCENTAGE</th>
                                <th style="width: 140px;">PROCTOR FLAGS</th>
                                <th style="width: 150px;">VERDICT</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <strong class="user-id-badge"><%# Eval("RollNo") %></strong>
                        </td>
                        <td>
                            <span style="font-weight: 600; color: #0f172a;"><%# Eval("FullName") %></span>
                            <div style="font-size: 11px; color: #64748b;"><%# Eval("Department") %></div>
                        </td>
                        <td>
                            <strong style="color: #0f172a;"><%# Eval("Score") %></strong> / <%# Eval("MaxScore") %>
                        </td>
                        <td>
                            <strong style="color: #059669;"><%# Eval("Percentage") %>%</strong>
                        </td>
                        <td>
                            <span style='<%# (int)Eval("ProctorFlags") > 0 ? "color: #dc2626; font-weight: 600;" : "color: #16a34a;" %>'>
                                <%# Eval("ProctorFlags") %> flags
                            </span>
                        </td>
                        <td>
                            <span class='<%# (bool)Eval("Passed") ? "status-pill status-verified" : "status-pill status-draft" %>'>
                                <%# (bool)Eval("Passed") ? "Cutoff Cleared" : "Needs Review" %>
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
    </asp:Panel>

    <!-- Tab 4: Edit Assessment Configuration -->
    <asp:Panel ID="pnlTabEdit" runat="server" Visible="false">
        <div style="background: #ffffff; border: 1px solid #e2e8f0; border-radius: 8px; padding: 24px; margin-bottom: 24px;">

            <asp:ValidationSummary ID="valSummaryEdit" runat="server" CssClass="users-alert users-alert-error"
                HeaderText="Please fix the following validation errors:" DisplayMode="BulletList" ValidationGroup="EditTestGroup" />

            <div style="font-size: 14px; font-weight: 700; color: #0f172a; margin-bottom: 16px; padding-bottom: 8px; border-bottom: 1px solid #f1f5f9;">
                Modify Assessment Parameters
            </div>

            <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 16px; margin-bottom: 20px;">
                <div class="users-form-group">
                    <label class="users-form-label" for="<%= txtEditTitle.ClientID %>">Assessment Title <span style="color: #dc2626;">*</span></label>
                    <asp:TextBox ID="txtEditTitle" runat="server" CssClass="users-form-control" />
                    <asp:RequiredFieldValidator ID="rfvEditTitle" runat="server" ControlToValidate="txtEditTitle"
                        ValidationGroup="EditTestGroup" ErrorMessage="Title is required." ForeColor="#dc2626" Display="Dynamic" />
                </div>

                <div class="users-form-group">
                    <label class="users-form-label" for="<%= txtEditCompany.ClientID %>">Sponsoring Company <span style="color: #dc2626;">*</span></label>
                    <asp:TextBox ID="txtEditCompany" runat="server" CssClass="users-form-control" />
                    <asp:RequiredFieldValidator ID="rfvEditCompany" runat="server" ControlToValidate="txtEditCompany"
                        ValidationGroup="EditTestGroup" ErrorMessage="Company is required." ForeColor="#dc2626" Display="Dynamic" />
                </div>
            </div>

            <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px; margin-bottom: 20px;">
                <div class="users-form-group">
                    <label class="users-form-label" for="<%= ddlEditType.ClientID %>">Track / Type</label>
                    <asp:DropDownList ID="ddlEditType" runat="server" CssClass="users-form-control">
                        <asp:ListItem Text="Aptitude" Value="Aptitude" />
                        <asp:ListItem Text="Technical" Value="Technical" />
                        <asp:ListItem Text="Coding" Value="Coding" />
                        <asp:ListItem Text="Mixed" Value="Mixed" />
                    </asp:DropDownList>
                </div>

                <div class="users-form-group">
                    <label class="users-form-label" for="<%= ddlEditStatus.ClientID %>">Status</label>
                    <asp:DropDownList ID="ddlEditStatus" runat="server" CssClass="users-form-control">
                        <asp:ListItem Text="Draft" Value="Draft" />
                        <asp:ListItem Text="Published" Value="Published" />
                        <asp:ListItem Text="Scheduled" Value="Scheduled" />
                        <asp:ListItem Text="Archived" Value="Archived" />
                    </asp:DropDownList>
                </div>

                <div class="users-form-group">
                    <label class="users-form-label" for="<%= txtEditDuration.ClientID %>">Duration (Minutes) <span style="color: #dc2626;">*</span></label>
                    <asp:TextBox ID="txtEditDuration" runat="server" CssClass="users-form-control" TextMode="Number" />
                    <asp:RequiredFieldValidator ID="rfvEditDuration" runat="server" ControlToValidate="txtEditDuration"
                        ValidationGroup="EditTestGroup" ErrorMessage="Duration is required." ForeColor="#dc2626" Display="Dynamic" />
                    <asp:RangeValidator ID="rvEditDuration" runat="server" ControlToValidate="txtEditDuration"
                        ValidationGroup="EditTestGroup" Type="Integer" MinimumValue="15" MaximumValue="360"
                        ErrorMessage="Duration must be 15-360 mins." ForeColor="#dc2626" Display="Dynamic" />
                </div>

                <div class="users-form-group">
                    <label class="users-form-label" for="<%= txtEditMarks.ClientID %>">Total Marks <span style="color: #dc2626;">*</span></label>
                    <asp:TextBox ID="txtEditMarks" runat="server" CssClass="users-form-control" TextMode="Number" />
                    <asp:RequiredFieldValidator ID="rfvEditMarks" runat="server" ControlToValidate="txtEditMarks"
                        ValidationGroup="EditTestGroup" ErrorMessage="Total marks are required." ForeColor="#dc2626" Display="Dynamic" />
                </div>
            </div>

            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 20px;">
                <div class="users-form-group">
                    <label class="users-form-label" for="<%= txtEditScheduledStart.ClientID %>">Start Date &amp; Time</label>
                    <asp:TextBox ID="txtEditScheduledStart" runat="server" CssClass="users-form-control" placeholder="YYYY-MM-DD HH:mm" />
                </div>

                <div class="users-form-group">
                    <label class="users-form-label" for="<%= txtEditScheduledEnd.ClientID %>">End Date &amp; Time</label>
                    <asp:TextBox ID="txtEditScheduledEnd" runat="server" CssClass="users-form-control" placeholder="YYYY-MM-DD HH:mm" />
                </div>
            </div>

            <div class="users-form-group" style="margin-bottom: 20px;">
                <label class="users-form-label" for="<%= txtEditInstructions.ClientID %>">Instructions &amp; Proctoring Rules</label>
                <asp:TextBox ID="txtEditInstructions" runat="server" TextMode="MultiLine" Rows="3" CssClass="users-form-control" />
            </div>

            <div style="display: flex; justify-content: flex-end; gap: 12px; padding-top: 16px; border-top: 1px solid #f1f5f9;">
                <asp:LinkButton ID="btnSaveEdit" runat="server" CssClass="action-button primary" ValidationGroup="EditTestGroup" OnClick="btnSaveEdit_Click">
                    Update Assessment Settings
                </asp:LinkButton>
            </div>
        </div>
    </asp:Panel>

</div>
</asp:Content>

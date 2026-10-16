<%@ Page Title="Create Assessment" Language="C#" MasterPageFile="~/Admin.Master"
    AutoEventWireup="true" CodeBehind="CreateTest.aspx.cs"
    Inherits="PlacementPrep.Admin.CreateTest" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="users-page-container">

    <!-- Breadcrumb & Header -->
    <div class="users-header">
        <div>
            <div class="users-breadcrumb">
                <span>ACADEMIC &amp; ASSESSMENT OPERATIONS</span>
                <span class="users-sep">/</span>
                <a href="ManageTests.aspx" style="color: #64748b; text-decoration: none;">Test Management</a>
                <span class="users-sep">/</span>
                <span>Create Assessment</span>
            </div>
            <h1 class="users-title">Create Campus Assessment</h1>
            <p class="users-subtitle">Configure assessment blueprint parameters, proctoring security rules, schedule windows, and question composition cart.</p>
        </div>
        <div class="users-top-actions">
            <a href="ManageTests.aspx" class="action-button">
                <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <line x1="19" y1="12" x2="5" y2="12"></line>
                    <polyline points="12 19 5 12 12 5"></polyline>
                </svg>
                <span>Back to Tests</span>
            </a>
            <asp:LinkButton ID="btnSaveTopDraft" runat="server" CssClass="action-button" OnClick="btnSaveDraft_Click">
                <span>Save as Draft</span>
            </asp:LinkButton>
            <asp:LinkButton ID="btnPublishTop" runat="server" CssClass="action-button primary" OnClick="btnPublish_Click">
                <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <polyline points="20 6 9 17 4 12"></polyline>
                </svg>
                <span>Publish Assessment</span>
            </asp:LinkButton>
        </div>
    </div>

    <!-- Alert Banner -->
    <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="users-alert" role="status">
        <asp:Literal ID="litMessage" runat="server" />
    </asp:Panel>

    <!-- Validation Summary -->
    <asp:ValidationSummary ID="valSummary" runat="server" CssClass="users-alert users-alert-error"
        HeaderText="Please review the following requirements:" DisplayMode="BulletList" />

    <div class="users-modal-body" style="background: #ffffff; border: 1px solid #e2e8f0; border-radius: 8px; padding: 24px; margin-bottom: 24px;">

        <!-- Section 1: Basic Info -->
        <div style="font-size: 14px; font-weight: 700; color: #0f172a; margin-bottom: 16px; padding-bottom: 8px; border-bottom: 1px solid #f1f5f9;">
            1. Assessment Identity &amp; Corporate Sponsorship
        </div>

        <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 16px; margin-bottom: 20px;">
            <div class="users-form-group">
                <label class="users-form-label" for="<%= txtTitle.ClientID %>">Assessment Title <span style="color: #dc2626;">*</span></label>
                <asp:TextBox ID="txtTitle" runat="server" CssClass="users-form-control" placeholder="e.g. National Aptitude &amp; Technical Benchmark Assessment 2026" />
                <asp:RequiredFieldValidator ID="rfvTitle" runat="server" ControlToValidate="txtTitle"
                    ErrorMessage="Assessment title is required." ForeColor="#dc2626" Display="Dynamic" />
            </div>

            <div class="users-form-group">
                <label class="users-form-label" for="<%= txtCompany.ClientID %>">Sponsoring Company / Drive Owner <span style="color: #dc2626;">*</span></label>
                <asp:TextBox ID="txtCompany" runat="server" CssClass="users-form-control" placeholder="e.g. Amazon, Google, Central TPO" />
                <asp:RequiredFieldValidator ID="rfvCompany" runat="server" ControlToValidate="txtCompany"
                    ErrorMessage="Company or sponsoring owner is required." ForeColor="#dc2626" Display="Dynamic" />
            </div>
        </div>

        <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 16px; margin-bottom: 20px;">
            <div class="users-form-group">
                <label class="users-form-label" for="<%= ddlTestType.ClientID %>">Track / Type <span style="color: #dc2626;">*</span></label>
                <asp:DropDownList ID="ddlTestType" runat="server" CssClass="users-form-control">
                    <asp:ListItem Text="Aptitude Track" Value="Aptitude" />
                    <asp:ListItem Text="Technical Domain" Value="Technical" />
                    <asp:ListItem Text="Coding Challenge" Value="Coding" />
                    <asp:ListItem Text="Comprehensive Combined (Mixed)" Value="Mixed" Selected="True" />
                </asp:DropDownList>
            </div>

            <div class="users-form-group">
                <label class="users-form-label" for="<%= ddlTargetDepartment.ClientID %>">Target Department</label>
                <asp:DropDownList ID="ddlTargetDepartment" runat="server" CssClass="users-form-control">
                    <asp:ListItem Text="All Departments (CSE/IT/ECE/ME)" Value="All Departments" Selected="True" />
                    <asp:ListItem Text="Computer Science &amp; IT" Value="Computer Science &amp; IT" />
                    <asp:ListItem Text="Electronics &amp; Communication" Value="Electronics &amp; Communication" />
                    <asp:ListItem Text="Mechanical &amp; Civil" Value="Mechanical &amp; Civil" />
                </asp:DropDownList>
            </div>

            <div class="users-form-group">
                <label class="users-form-label" for="<%= ddlTargetBatch.ClientID %>">Target Cohort Batch</label>
                <asp:DropDownList ID="ddlTargetBatch" runat="server" CssClass="users-form-control">
                    <asp:ListItem Text="Batch 2025 (Graduating Seniors)" Value="Batch 2025" Selected="True" />
                    <asp:ListItem Text="Batch 2026 (Pre-final Year)" Value="Batch 2026" />
                    <asp:ListItem Text="Batch 2027 (Sophomores)" Value="Batch 2027" />
                </asp:DropDownList>
            </div>
        </div>

        <div class="users-form-group" style="margin-bottom: 24px;">
            <label class="users-form-label" for="<%= txtDescription.ClientID %>">Description &amp; Syllabus Overview</label>
            <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="2" CssClass="users-form-control"
                placeholder="High-level assessment summary and learning outcomes evaluated..." />
        </div>

        <!-- Section 2: Exam Rules & Proctoring -->
        <div style="font-size: 14px; font-weight: 700; color: #0f172a; margin-bottom: 16px; padding-bottom: 8px; border-bottom: 1px solid #f1f5f9;">
            2. Rules, Duration, Proctoring &amp; Scoring Benchmarks
        </div>

        <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px; margin-bottom: 20px;">
            <div class="users-form-group">
                <label class="users-form-label" for="<%= txtDuration.ClientID %>">Duration (Minutes) <span style="color: #dc2626;">*</span></label>
                <asp:TextBox ID="txtDuration" runat="server" CssClass="users-form-control" Text="90" TextMode="Number" />
                <asp:RequiredFieldValidator ID="rfvDuration" runat="server" ControlToValidate="txtDuration"
                    ErrorMessage="Duration in minutes is required." ForeColor="#dc2626" Display="Dynamic" />
                <asp:RangeValidator ID="rvDuration" runat="server" ControlToValidate="txtDuration"
                    Type="Integer" MinimumValue="15" MaximumValue="360"
                    ErrorMessage="Duration must be between 15 and 360 minutes." ForeColor="#dc2626" Display="Dynamic" />
            </div>

            <div class="users-form-group">
                <label class="users-form-label" for="<%= txtTotalMarks.ClientID %>">Total Marks (Max Score) <span style="color: #dc2626;">*</span></label>
                <asp:TextBox ID="txtTotalMarks" runat="server" CssClass="users-form-control" Text="100" TextMode="Number" />
                <asp:RequiredFieldValidator ID="rfvTotalMarks" runat="server" ControlToValidate="txtTotalMarks"
                    ErrorMessage="Total marks are required." ForeColor="#dc2626" Display="Dynamic" />
                <asp:RangeValidator ID="rvTotalMarks" runat="server" ControlToValidate="txtTotalMarks"
                    Type="Integer" MinimumValue="10" MaximumValue="1000"
                    ErrorMessage="Total marks must be between 10 and 1000." ForeColor="#dc2626" Display="Dynamic" />
            </div>

            <div class="users-form-group">
                <label class="users-form-label" for="<%= txtPassingPercentage.ClientID %>">Passing Benchmark (%) <span style="color: #dc2626;">*</span></label>
                <asp:TextBox ID="txtPassingPercentage" runat="server" CssClass="users-form-control" Text="65" TextMode="Number" />
                <asp:RequiredFieldValidator ID="rfvPassing" runat="server" ControlToValidate="txtPassingPercentage"
                    ErrorMessage="Passing percentage benchmark is required." ForeColor="#dc2626" Display="Dynamic" />
                <asp:RangeValidator ID="rvPassing" runat="server" ControlToValidate="txtPassingPercentage"
                    Type="Integer" MinimumValue="20" MaximumValue="100"
                    ErrorMessage="Passing percentage must be between 20% and 100%." ForeColor="#dc2626" Display="Dynamic" />
            </div>

            <div class="users-form-group">
                <label class="users-form-label" for="<%= ddlProctoringLevel.ClientID %>">Proctoring Lockdown Level</label>
                <asp:DropDownList ID="ddlProctoringLevel" runat="server" CssClass="users-form-control">
                    <asp:ListItem Text="Strict Lockdown (Webcam + Fullscreen)" Value="Strict Lockdown (Webcam + Fullscreen)" Selected="True" />
                    <asp:ListItem Text="Moderate (Tab Switch Warning Only)" Value="Moderate (Tab Switch Warning Only)" />
                    <asp:ListItem Text="Standard Open Window" Value="Standard Open Window" />
                </asp:DropDownList>
            </div>
        </div>

        <div style="display: flex; gap: 24px; align-items: center; background: #f8fafc; padding: 12px 16px; border-radius: 6px; border: 1px solid #e2e8f0; margin-bottom: 24px;">
            <label style="display: flex; align-items: center; gap: 8px; font-weight: 600; color: #334155; cursor: pointer;">
                <asp:CheckBox ID="chkNegativeMarking" runat="server" Checked="true" />
                <span>Enable Negative Marking</span>
            </label>
            <div style="display: flex; align-items: center; gap: 8px;">
                <span style="font-size: 11px; color: #64748b;">Penalty Per Wrong MCQ:</span>
                <asp:TextBox ID="txtNegativeMarkVal" runat="server" CssClass="users-form-control" Text="0.50" style="width: 80px;" />
            </div>
            <label style="display: flex; align-items: center; gap: 8px; font-weight: 600; color: #334155; cursor: pointer;">
                <asp:CheckBox ID="chkShuffleQuestions" runat="server" Checked="true" />
                <span>Shuffle Questions for Each Candidate</span>
            </label>
        </div>

        <!-- Section 3: Schedule Window & Guidelines -->
        <div style="font-size: 14px; font-weight: 700; color: #0f172a; margin-bottom: 16px; padding-bottom: 8px; border-bottom: 1px solid #f1f5f9;">
            3. Examination Schedule Window &amp; Candidate Instructions
        </div>

        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 20px;">
            <div class="users-form-group">
                <label class="users-form-label" for="<%= txtScheduledStart.ClientID %>">Window Opens (Start Date &amp; Time)</label>
                <asp:TextBox ID="txtScheduledStart" runat="server" CssClass="users-form-control" placeholder="YYYY-MM-DD HH:mm (e.g. 2026-10-20 10:00)" />
            </div>

            <div class="users-form-group">
                <label class="users-form-label" for="<%= txtScheduledEnd.ClientID %>">Window Closes (End Date &amp; Time)</label>
                <asp:TextBox ID="txtScheduledEnd" runat="server" CssClass="users-form-control" placeholder="YYYY-MM-DD HH:mm (e.g. 2026-10-20 18:00)" />
            </div>
        </div>

        <div class="users-form-group" style="margin-bottom: 24px;">
            <label class="users-form-label" for="<%= txtInstructions.ClientID %>">Instructions &amp; Code of Conduct</label>
            <asp:TextBox ID="txtInstructions" runat="server" TextMode="MultiLine" Rows="3" CssClass="users-form-control"
                placeholder="Guidelines for students: e.g. Webcam must stay active throughout the test. Any attempt to leave fullscreen will result in test termination..." />
        </div>

        <!-- Section 4: Question Composition Cart -->
        <div style="font-size: 14px; font-weight: 700; color: #0f172a; margin-bottom: 16px; padding-bottom: 8px; border-bottom: 1px solid #f1f5f9; display: flex; justify-content: space-between; align-items: center;">
            <span>4. Demo Question Selection Cart</span>
            <span style="font-size: 12px; font-weight: 500; color: #0284c7;">
                Select sample questions from the question bank to populate this assessment blueprint
            </span>
        </div>

        <div style="border: 1px solid #e2e8f0; border-radius: 6px; overflow: hidden; margin-bottom: 24px;">
            <table class="users-table" style="margin: 0;">
                <thead>
                    <tr>
                        <th style="width: 40px; text-align: center;">SELECT</th>
                        <th style="width: 130px;">CODE</th>
                        <th style="width: 100px;">TYPE</th>
                        <th>QUESTION / PROBLEM SUMMARY</th>
                        <th style="width: 100px;">DIFFICULTY</th>
                        <th style="width: 80px;">MARKS</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptDemoQuestions" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td style="text-align: center;">
                                    <asp:CheckBox ID="chkSelectQuestion" runat="server" Checked="true" />
                                    <asp:HiddenField ID="hfQuestionCode" runat="server" Value='<%# Eval("Code") %>' />
                                </td>
                                <td>
                                    <strong class="user-id-badge"><%# Eval("Code") %></strong>
                                </td>
                                <td>
                                    <span class="user-dept" style="padding: 2px 6px; font-size: 10px; font-weight: 600; border-radius: 4px; background: #e0f2fe; color: #0369a1;">
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
                    </asp:Repeater>
                </tbody>
            </table>
        </div>

        <!-- Action Buttons -->
        <div style="display: flex; justify-content: flex-end; gap: 12px; padding-top: 16px; border-top: 1px solid #f1f5f9;">
            <a href="ManageTests.aspx" class="action-button">Cancel</a>
            <asp:LinkButton ID="btnSaveBottomDraft" runat="server" CssClass="action-button" OnClick="btnSaveDraft_Click">
                Save as Draft
            </asp:LinkButton>
            <asp:LinkButton ID="btnPublishBottom" runat="server" CssClass="action-button primary" OnClick="btnPublish_Click">
                Publish Assessment
            </asp:LinkButton>
        </div>

    </div>

</div>
</asp:Content>

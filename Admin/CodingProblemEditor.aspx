<%@ Page Title="Coding Problem Editor" Language="C#" MasterPageFile="~/Admin.Master"
    AutoEventWireup="true" CodeBehind="CodingProblemEditor.aspx.cs"
    Inherits="PlacementPrep.Admin.CodingProblemEditor" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="users-page-container">
    <asp:HiddenField ID="hfProblemId" runat="server" Value="0" />

    <!-- Breadcrumb & Header -->
    <div class="users-header">
        <div>
            <div class="users-breadcrumb">
                <span>ACADEMIC &amp; ASSESSMENT OPERATIONS</span>
                <span class="users-sep">/</span>
                <a href="QuestionBank.aspx" style="color: #64748b; text-decoration: none;">Question Bank</a>
                <span class="users-sep">/</span>
                <a href="CodingQuestions.aspx" style="color: #64748b; text-decoration: none;">Coding Challenges</a>
                <span class="users-sep">/</span>
                <span>Problem Editor</span>
            </div>
            <h1 class="users-title">
                <asp:Literal ID="litPageTitle" runat="server" Text="Create Coding Problem" />
            </h1>
            <p class="users-subtitle">Configure algorithmic problem statements, I/O formatting, asymptotic execution bounds, sample test suites, and starter code templates.</p>
        </div>
        <div class="users-top-actions">
            <a href="CodingQuestions.aspx" class="action-button">
                <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <line x1="19" y1="12" x2="5" y2="12"></line>
                    <polyline points="12 19 5 12 12 5"></polyline>
                </svg>
                <span>Back to Coding Bank</span>
            </a>
            <asp:LinkButton ID="btnSaveTop" runat="server" CssClass="action-button primary" OnClick="btnSave_Click">
                <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"></path>
                    <polyline points="17 21 17 13 7 13 7 21"></polyline>
                    <polyline points="7 3 7 8 15 8"></polyline>
                </svg>
                <span>Save Coding Problem</span>
            </asp:LinkButton>
        </div>
    </div>

    <!-- Alert Banner -->
    <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="users-alert" role="status">
        <asp:Literal ID="litMessage" runat="server" />
    </asp:Panel>

    <!-- Validation Summary -->
    <asp:ValidationSummary ID="valSummary" runat="server" CssClass="users-alert users-alert-error"
        HeaderText="Please address the following validation errors:" DisplayMode="BulletList" />

    <!-- Form Container -->
    <div class="users-modal-body" style="background: #ffffff; border: 1px solid #e2e8f0; border-radius: 8px; padding: 24px; margin-bottom: 24px;">

        <div style="font-size: 14px; font-weight: 700; color: #0f172a; margin-bottom: 16px; padding-bottom: 8px; border-bottom: 1px solid #f1f5f9;">
            1. Problem Identity &amp; Categorization
        </div>

        <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 16px; margin-bottom: 20px;">
            <div class="users-form-group">
                <label class="users-form-label" for="<%= txtTitle.ClientID %>">Problem Title <span style="color: #dc2626;">*</span></label>
                <asp:TextBox ID="txtTitle" runat="server" CssClass="users-form-control" placeholder="e.g. Longest Substring Without Repeating Characters" />
                <asp:RequiredFieldValidator ID="rfvTitle" runat="server" ControlToValidate="txtTitle"
                    ErrorMessage="Problem title is required." ForeColor="#dc2626" Display="Dynamic" />
            </div>

            <div class="users-form-group">
                <label class="users-form-label" for="<%= txtCode.ClientID %>">Problem Code</label>
                <asp:TextBox ID="txtCode" runat="server" CssClass="users-form-control" placeholder="e.g. COD-105 (Auto-generated if blank)" />
            </div>
        </div>

        <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px; margin-bottom: 24px;">
            <div class="users-form-group">
                <label class="users-form-label" for="<%= ddlTopic.ClientID %>">Algorithmic Topic <span style="color: #dc2626;">*</span></label>
                <asp:DropDownList ID="ddlTopic" runat="server" CssClass="users-form-control">
                    <asp:ListItem Text="Arrays &amp; Hashing" Value="Arrays &amp; Hashing" Selected="True" />
                    <asp:ListItem Text="Two Pointers" Value="Two Pointers" />
                    <asp:ListItem Text="Sliding Window" Value="Sliding Window" />
                    <asp:ListItem Text="Dynamic Programming" Value="Dynamic Programming" />
                    <asp:ListItem Text="Trees &amp; Binary Search" Value="Trees &amp; Binary Search" />
                    <asp:ListItem Text="Graphs &amp; BFS/DFS" Value="Graphs &amp; BFS/DFS" />
                    <asp:ListItem Text="Greedy Algorithms" Value="Greedy Algorithms" />
                    <asp:ListItem Text="Backtracking" Value="Backtracking" />
                </asp:DropDownList>
            </div>

            <div class="users-form-group">
                <label class="users-form-label" for="<%= ddlDifficulty.ClientID %>">Difficulty <span style="color: #dc2626;">*</span></label>
                <asp:DropDownList ID="ddlDifficulty" runat="server" CssClass="users-form-control">
                    <asp:ListItem Text="Easy" Value="Easy" />
                    <asp:ListItem Text="Medium" Value="Medium" Selected="True" />
                    <asp:ListItem Text="Hard" Value="Hard" />
                </asp:DropDownList>
            </div>

            <div class="users-form-group">
                <label class="users-form-label" for="<%= txtMarks.ClientID %>">Marks / Weightage <span style="color: #dc2626;">*</span></label>
                <asp:TextBox ID="txtMarks" runat="server" CssClass="users-form-control" Text="50" TextMode="Number" />
                <asp:RequiredFieldValidator ID="rfvMarks" runat="server" ControlToValidate="txtMarks"
                    ErrorMessage="Marks are required." ForeColor="#dc2626" Display="Dynamic" />
                <asp:RangeValidator ID="rvMarks" runat="server" ControlToValidate="txtMarks"
                    Type="Integer" MinimumValue="5" MaximumValue="500"
                    ErrorMessage="Marks must be between 5 and 500." ForeColor="#dc2626" Display="Dynamic" />
            </div>

            <div class="users-form-group">
                <label class="users-form-label" for="<%= txtTestCaseCount.ClientID %>">Test Cases Count <span style="color: #dc2626;">*</span></label>
                <asp:TextBox ID="txtTestCaseCount" runat="server" CssClass="users-form-control" Text="15" TextMode="Number" />
                <asp:RequiredFieldValidator ID="rfvTestCaseCount" runat="server" ControlToValidate="txtTestCaseCount"
                    ErrorMessage="Test case count is required." ForeColor="#dc2626" Display="Dynamic" />
                <asp:RangeValidator ID="rvTestCaseCount" runat="server" ControlToValidate="txtTestCaseCount"
                    Type="Integer" MinimumValue="1" MaximumValue="100"
                    ErrorMessage="Test case count must be between 1 and 100." ForeColor="#dc2626" Display="Dynamic" />
            </div>
        </div>

        <div class="users-form-group" style="max-width: 300px; margin-bottom: 24px;">
            <label class="users-form-label" for="<%= ddlStatus.ClientID %>">Publication Status <span style="color: #dc2626;">*</span></label>
            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="users-form-control">
                <asp:ListItem Text="Published" Value="Published" Selected="True" />
                <asp:ListItem Text="Draft" Value="Draft" />
                <asp:ListItem Text="In Review" Value="In Review" />
            </asp:DropDownList>
        </div>

        <div style="font-size: 14px; font-weight: 700; color: #0f172a; margin-bottom: 16px; padding-bottom: 8px; border-bottom: 1px solid #f1f5f9;">
            2. Problem Statement &amp; Execution Specification
        </div>

        <div class="users-form-group" style="margin-bottom: 20px;">
            <label class="users-form-label" for="<%= txtStatement.ClientID %>">Problem Statement <span style="color: #dc2626;">*</span></label>
            <asp:TextBox ID="txtStatement" runat="server" TextMode="MultiLine" Rows="6" CssClass="users-form-control"
                placeholder="Describe the computational problem, inputs, edge conditions, and expected return value..." />
            <asp:RequiredFieldValidator ID="rfvStatement" runat="server" ControlToValidate="txtStatement"
                ErrorMessage="Problem statement is required." ForeColor="#dc2626" Display="Dynamic" />
        </div>

        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 20px;">
            <div class="users-form-group">
                <label class="users-form-label" for="<%= txtInputFormat.ClientID %>">Input Format</label>
                <asp:TextBox ID="txtInputFormat" runat="server" TextMode="MultiLine" Rows="3" CssClass="users-form-control"
                    placeholder="e.g. First line contains integer N. Second line contains N integers." />
            </div>

            <div class="users-form-group">
                <label class="users-form-label" for="<%= txtOutputFormat.ClientID %>">Output Format</label>
                <asp:TextBox ID="txtOutputFormat" runat="server" TextMode="MultiLine" Rows="3" CssClass="users-form-control"
                    placeholder="e.g. Return an integer representing the maximum subarray sum." />
            </div>
        </div>

        <div class="users-form-group" style="margin-bottom: 24px;">
            <label class="users-form-label" for="<%= txtConstraints.ClientID %>">Constraints &amp; System Bounds <span style="color: #dc2626;">*</span></label>
            <asp:TextBox ID="txtConstraints" runat="server" TextMode="MultiLine" Rows="3" CssClass="users-form-control"
                placeholder="e.g. 1 <= N <= 10^5&#10;-10^9 <= nums[i] <= 10^9&#10;Time Limit: 1.0s&#10;Memory Limit: 256MB" />
            <asp:RequiredFieldValidator ID="rfvConstraints" runat="server" ControlToValidate="txtConstraints"
                ErrorMessage="Constraints and bounds are required." ForeColor="#dc2626" Display="Dynamic" />
        </div>

        <div style="font-size: 14px; font-weight: 700; color: #0f172a; margin-bottom: 16px; padding-bottom: 8px; border-bottom: 1px solid #f1f5f9;">
            3. Sample Test Cases &amp; Explanation
        </div>

        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 20px;">
            <div class="users-form-group">
                <label class="users-form-label" for="<%= txtSampleInput.ClientID %>">Sample Input 1 <span style="color: #dc2626;">*</span></label>
                <asp:TextBox ID="txtSampleInput" runat="server" TextMode="MultiLine" Rows="4" CssClass="users-form-control"
                    style="font-family: monospace; background: #f8fafc;" placeholder="e.g. 4 9&#10;2 7 11 15" />
                <asp:RequiredFieldValidator ID="rfvSampleInput" runat="server" ControlToValidate="txtSampleInput"
                    ErrorMessage="Sample input is required." ForeColor="#dc2626" Display="Dynamic" />
            </div>

            <div class="users-form-group">
                <label class="users-form-label" for="<%= txtSampleOutput.ClientID %>">Sample Output 1 <span style="color: #dc2626;">*</span></label>
                <asp:TextBox ID="txtSampleOutput" runat="server" TextMode="MultiLine" Rows="4" CssClass="users-form-control"
                    style="font-family: monospace; background: #f8fafc;" placeholder="e.g. 0 1" />
                <asp:RequiredFieldValidator ID="rfvSampleOutput" runat="server" ControlToValidate="txtSampleOutput"
                    ErrorMessage="Sample output is required." ForeColor="#dc2626" Display="Dynamic" />
            </div>
        </div>

        <div class="users-form-group" style="margin-bottom: 24px;">
            <label class="users-form-label" for="<%= txtExplanation.ClientID %>">Sample Case Explanation</label>
            <asp:TextBox ID="txtExplanation" runat="server" TextMode="MultiLine" Rows="3" CssClass="users-form-control"
                placeholder="Walk through why the sample input yields this specific output..." />
        </div>

        <div style="font-size: 14px; font-weight: 700; color: #0f172a; margin-bottom: 16px; padding-bottom: 8px; border-bottom: 1px solid #f1f5f9;">
            4. Starter Code &amp; Function Skeleton
        </div>

        <div class="users-form-group" style="margin-bottom: 24px;">
            <label class="users-form-label" for="<%= txtStarterCode.ClientID %>">Method Template / Boilerplate Code</label>
            <asp:TextBox ID="txtStarterCode" runat="server" TextMode="MultiLine" Rows="6" CssClass="users-form-control"
                style="font-family: Consolas, monospace; background: #1e293b; color: #f1f5f9; line-height: 1.4;"
                placeholder="def solve(nums: list[int], target: int) -> list[int]:&#10;    # Write your solution here&#10;    pass" />
        </div>

        <div style="display: flex; justify-content: flex-end; gap: 12px; padding-top: 16px; border-top: 1px solid #f1f5f9;">
            <a href="CodingQuestions.aspx" class="action-button">Cancel</a>
            <asp:LinkButton ID="btnSaveBottom" runat="server" CssClass="action-button primary" OnClick="btnSave_Click">
                Save &amp; Return to Bank
            </asp:LinkButton>
        </div>

    </div>
</div>
</asp:Content>

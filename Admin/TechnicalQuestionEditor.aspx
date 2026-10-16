<%@ Page Title="Technical Question Editor" Language="C#" MasterPageFile="~/Admin.Master"
    AutoEventWireup="true" CodeBehind="TechnicalQuestionEditor.aspx.cs"
    Inherits="PlacementPrep.Admin.TechnicalQuestionEditor" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="users-page-container">
    <asp:HiddenField ID="hfQuestionId" runat="server" Value="0" />

    <!-- Breadcrumb & Header -->
    <div class="users-header">
        <div>
            <div class="users-breadcrumb">
                <span>ACADEMIC &amp; ASSESSMENT OPERATIONS</span>
                <span class="users-sep">/</span>
                <a href="QuestionBank.aspx" style="color: #64748b; text-decoration: none;">Question Bank</a>
                <span class="users-sep">/</span>
                <a href="TechnicalQuestions.aspx" style="color: #64748b; text-decoration: none;">Technical Domain</a>
                <span class="users-sep">/</span>
                <span>Question Editor</span>
            </div>
            <h1 class="users-title">
                <asp:Literal ID="litPageTitle" runat="server" Text="Create Technical Question" />
            </h1>
            <p class="users-subtitle">Configure core Computer Science domain MCQs, code analysis problems, time complexity assertions, and verified solution keys.</p>
        </div>
        <div class="users-top-actions">
            <a href="TechnicalQuestions.aspx" class="action-button">
                <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <line x1="19" y1="12" x2="5" y2="12"></line>
                    <polyline points="12 19 5 12 12 5"></polyline>
                </svg>
                <span>Back to Technical Bank</span>
            </a>
            <asp:LinkButton ID="btnSaveTop" runat="server" CssClass="action-button primary" OnClick="btnSave_Click">
                <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"></path>
                    <polyline points="17 21 17 13 7 13 7 21"></polyline>
                    <polyline points="7 3 7 8 15 8"></polyline>
                </svg>
                <span>Save Question</span>
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
            1. Domain &amp; Weightage Configuration
        </div>

        <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px; margin-bottom: 20px;">
            <div class="users-form-group">
                <label class="users-form-label" for="<%= ddlTopic.ClientID %>">Technical Domain <span style="color: #dc2626;">*</span></label>
                <asp:DropDownList ID="ddlTopic" runat="server" CssClass="users-form-control">
                    <asp:ListItem Text="Data Structures" Value="Data Structures" Selected="True" />
                    <asp:ListItem Text="Algorithms" Value="Algorithms" />
                    <asp:ListItem Text="DBMS &amp; SQL" Value="DBMS &amp; SQL" />
                    <asp:ListItem Text="Operating Systems" Value="Operating Systems" />
                    <asp:ListItem Text="Computer Networks" Value="Computer Networks" />
                    <asp:ListItem Text="OOP &amp; Design" Value="OOP &amp; Design" />
                </asp:DropDownList>
            </div>

            <div class="users-form-group">
                <label class="users-form-label" for="<%= ddlDifficulty.ClientID %>">Difficulty Level <span style="color: #dc2626;">*</span></label>
                <asp:DropDownList ID="ddlDifficulty" runat="server" CssClass="users-form-control">
                    <asp:ListItem Text="Easy" Value="Easy" />
                    <asp:ListItem Text="Medium" Value="Medium" Selected="True" />
                    <asp:ListItem Text="Hard" Value="Hard" />
                </asp:DropDownList>
            </div>

            <div class="users-form-group">
                <label class="users-form-label" for="<%= txtMarks.ClientID %>">Marks (+ Score) <span style="color: #dc2626;">*</span></label>
                <asp:TextBox ID="txtMarks" runat="server" CssClass="users-form-control" Text="3" TextMode="Number" />
                <asp:RequiredFieldValidator ID="rfvMarks" runat="server" ControlToValidate="txtMarks"
                    ErrorMessage="Marks value is required." ForeColor="#dc2626" Display="Dynamic" />
                <asp:RangeValidator ID="rvMarks" runat="server" ControlToValidate="txtMarks"
                    Type="Integer" MinimumValue="1" MaximumValue="100"
                    ErrorMessage="Marks must be between 1 and 100." ForeColor="#dc2626" Display="Dynamic" />
            </div>

            <div class="users-form-group">
                <label class="users-form-label" for="<%= txtNegativeMarks.ClientID %>">Negative Penalty (- Score) <span style="color: #dc2626;">*</span></label>
                <asp:TextBox ID="txtNegativeMarks" runat="server" CssClass="users-form-control" Text="1.00" />
                <asp:RequiredFieldValidator ID="rfvNegMarks" runat="server" ControlToValidate="txtNegativeMarks"
                    ErrorMessage="Negative marks penalty is required." ForeColor="#dc2626" Display="Dynamic" />
                <asp:RangeValidator ID="rvNegMarks" runat="server" ControlToValidate="txtNegativeMarks"
                    Type="Double" MinimumValue="0.0" MaximumValue="20.0"
                    ErrorMessage="Negative marks must be between 0.0 and 20.0." ForeColor="#dc2626" Display="Dynamic" />
            </div>
        </div>

        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 24px;">
            <div class="users-form-group">
                <label class="users-form-label" for="<%= ddlValidationStatus.ClientID %>">Solution Key Audit Status <span style="color: #dc2626;">*</span></label>
                <asp:DropDownList ID="ddlValidationStatus" runat="server" CssClass="users-form-control">
                    <asp:ListItem Text="Verified" Value="Verified" Selected="True" />
                    <asp:ListItem Text="Draft" Value="Draft" />
                    <asp:ListItem Text="Review Needed" Value="Review Needed" />
                </asp:DropDownList>
            </div>
            <div class="users-form-group">
                <label class="users-form-label" for="<%= txtCode.ClientID %>">Item System Code</label>
                <asp:TextBox ID="txtCode" runat="server" CssClass="users-form-control" placeholder="Auto-generated if left blank (e.g. QB-TECH-2005)" />
            </div>
        </div>

        <div style="font-size: 14px; font-weight: 700; color: #0f172a; margin-bottom: 16px; padding-bottom: 8px; border-bottom: 1px solid #f1f5f9;">
            2. Technical Question Prompt Statement
        </div>

        <div class="users-form-group" style="margin-bottom: 24px;">
            <label class="users-form-label" for="<%= txtPrompt.ClientID %>">Question Prompt (Code Snippet or Concept) <span style="color: #dc2626;">*</span></label>
            <asp:TextBox ID="txtPrompt" runat="server" TextMode="MultiLine" Rows="5" CssClass="users-form-control"
                placeholder="State the technical question or code analysis prompt. Code blocks and algorithmic specifications are supported..." />
            <asp:RequiredFieldValidator ID="rfvPrompt" runat="server" ControlToValidate="txtPrompt"
                ErrorMessage="Technical question prompt text is required." ForeColor="#dc2626" Display="Dynamic" />
        </div>

        <div style="font-size: 14px; font-weight: 700; color: #0f172a; margin-bottom: 16px; padding-bottom: 8px; border-bottom: 1px solid #f1f5f9;">
            3. Multiple Choice Options &amp; Correct Answer Key
        </div>

        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 20px;">
            <div class="users-form-group">
                <label class="users-form-label" for="<%= txtOptionA.ClientID %>">Option A <span style="color: #dc2626;">*</span></label>
                <asp:TextBox ID="txtOptionA" runat="server" CssClass="users-form-control" placeholder="Enter option A..." />
                <asp:RequiredFieldValidator ID="rfvOptionA" runat="server" ControlToValidate="txtOptionA"
                    ErrorMessage="Option A is required." ForeColor="#dc2626" Display="Dynamic" />
            </div>

            <div class="users-form-group">
                <label class="users-form-label" for="<%= txtOptionB.ClientID %>">Option B <span style="color: #dc2626;">*</span></label>
                <asp:TextBox ID="txtOptionB" runat="server" CssClass="users-form-control" placeholder="Enter option B..." />
                <asp:RequiredFieldValidator ID="rfvOptionB" runat="server" ControlToValidate="txtOptionB"
                    ErrorMessage="Option B is required." ForeColor="#dc2626" Display="Dynamic" />
            </div>

            <div class="users-form-group">
                <label class="users-form-label" for="<%= txtOptionC.ClientID %>">Option C <span style="color: #dc2626;">*</span></label>
                <asp:TextBox ID="txtOptionC" runat="server" CssClass="users-form-control" placeholder="Enter option C..." />
                <asp:RequiredFieldValidator ID="rfvOptionC" runat="server" ControlToValidate="txtOptionC"
                    ErrorMessage="Option C is required." ForeColor="#dc2626" Display="Dynamic" />
            </div>

            <div class="users-form-group">
                <label class="users-form-label" for="<%= txtOptionD.ClientID %>">Option D <span style="color: #dc2626;">*</span></label>
                <asp:TextBox ID="txtOptionD" runat="server" CssClass="users-form-control" placeholder="Enter option D..." />
                <asp:RequiredFieldValidator ID="rfvOptionD" runat="server" ControlToValidate="txtOptionD"
                    ErrorMessage="Option D is required." ForeColor="#dc2626" Display="Dynamic" />
            </div>
        </div>

        <div class="users-form-group" style="max-width: 300px; margin-bottom: 24px;">
            <label class="users-form-label" for="<%= ddlCorrectOption.ClientID %>">Designated Correct Option <span style="color: #dc2626;">*</span></label>
            <asp:DropDownList ID="ddlCorrectOption" runat="server" CssClass="users-form-control">
                <asp:ListItem Text="Option A" Value="A" />
                <asp:ListItem Text="Option B" Value="B" />
                <asp:ListItem Text="Option C" Value="C" />
                <asp:ListItem Text="Option D" Value="D" />
            </asp:DropDownList>
        </div>

        <div style="font-size: 14px; font-weight: 700; color: #0f172a; margin-bottom: 16px; padding-bottom: 8px; border-bottom: 1px solid #f1f5f9;">
            4. Technical Solution &amp; Engineering Rationale
        </div>

        <div class="users-form-group" style="margin-bottom: 24px;">
            <label class="users-form-label" for="<%= txtExplanation.ClientID %>">Complexity Analysis &amp; Technical Explanation</label>
            <asp:TextBox ID="txtExplanation" runat="server" TextMode="MultiLine" Rows="3" CssClass="users-form-control"
                placeholder="Explain the time/space complexity analysis, underlying computer architecture or operating system theory that proves this answer..." />
        </div>

        <div style="display: flex; justify-content: flex-end; gap: 12px; padding-top: 16px; border-top: 1px solid #f1f5f9;">
            <a href="TechnicalQuestions.aspx" class="action-button">Cancel</a>
            <asp:LinkButton ID="btnSaveBottom" runat="server" CssClass="action-button primary" OnClick="btnSave_Click">
                Save &amp; Return to Bank
            </asp:LinkButton>
        </div>

    </div>
</div>
</asp:Content>

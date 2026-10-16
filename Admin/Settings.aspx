<%@ Page Title="Admin Settings" Language="C#" MasterPageFile="~/Admin.Master"
    AutoEventWireup="true" CodeBehind="Settings.aspx.cs"
    Inherits="PlacementPrep.Settings" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Platform Settings &amp; Governance | Placement Prep Admin</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="admin-shell-page">

    <!-- Page Header -->
    <div class="users-header">
        <div>
            <div class="users-breadcrumb">
                <a href="<%= ResolveUrl("~/Admin/AdminDashboard.aspx") %>">Dashboard</a>
                <span>/</span>
                <span>Governance &amp; Setup</span>
                <span>/</span>
                <span>Settings</span>
            </div>
            <h1 class="users-title">Platform Configuration &amp; Season Governance</h1>
            <p class="users-subtitle">
                Configure active academic cycles, baseline test proctoring parameters, institutional profile metadata, and automated notification alerts.
            </p>
        </div>
        <div class="users-header-actions">
            <asp:LinkButton ID="btnResetDefaults" runat="server" CssClass="action-button"
                OnClick="btnResetDefaults_Click" CausesValidation="false"
                OnClientClick="return confirm('Reset all configuration parameters to baseline institutional defaults?');">
                Reset Defaults
            </asp:LinkButton>
            <asp:LinkButton ID="btnSaveSettings" runat="server" CssClass="action-button primary"
                OnClick="btnSaveSettings_Click" ValidationGroup="SettingsForm">
                <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                    <path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"/>
                    <polyline points="17 21 17 13 7 13 7 21"/>
                    <polyline points="7 3 7 8 15 8"/>
                </svg>
                Save Settings
            </asp:LinkButton>
        </div>
    </div>

    <!-- Alert Message Banner -->
    <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="users-alert users-alert-success">
        <asp:Literal ID="litMessage" runat="server" />
    </asp:Panel>

    <asp:ValidationSummary ID="valSummarySettings" runat="server" CssClass="users-validation"
        ValidationGroup="SettingsForm" HeaderText="Please address the following configuration errors:" />

    <div class="details-grid-layout">
        
        <!-- Left Main Column: Institutional Profile & Academic Season -->
        <div class="details-grid-main">
            
            <!-- Section 1: Institutional Profile -->
            <div class="details-section-card">
                <div class="details-section-header">
                    <h2>Institutional Profile &amp; Placement Cell Contact</h2>
                    <span class="text-muted" style="font-size:11px;">Official Campus Identity</span>
                </div>

                <div class="users-form-grid">
                    <div class="users-field users-field-span">
                        <label for="<%= txtUniversityName.ClientID %>">University / Institute Legal Name *</label>
                        <asp:TextBox ID="txtUniversityName" runat="server" MaxLength="150" />
                        <asp:RequiredFieldValidator ID="rfvUniversityName" runat="server"
                            ControlToValidate="txtUniversityName" ValidationGroup="SettingsForm"
                            ErrorMessage="University name is required." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field">
                        <label for="<%= txtPlacementEmail.ClientID %>">Central Placement Cell Email *</label>
                        <asp:TextBox ID="txtPlacementEmail" runat="server" MaxLength="100" TextMode="Email" />
                        <asp:RequiredFieldValidator ID="rfvPlacementEmail" runat="server"
                            ControlToValidate="txtPlacementEmail" ValidationGroup="SettingsForm"
                            ErrorMessage="Placement cell email is required." Display="Dynamic" CssClass="field-error" />
                        <asp:RegularExpressionValidator ID="revPlacementEmail" runat="server"
                            ControlToValidate="txtPlacementEmail" ValidationGroup="SettingsForm"
                            ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                            ErrorMessage="Enter a valid email address." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field">
                        <label for="<%= txtDirectorName.ClientID %>">Dean / Director of Placements *</label>
                        <asp:TextBox ID="txtDirectorName" runat="server" MaxLength="100" />
                        <asp:RequiredFieldValidator ID="rfvDirectorName" runat="server"
                            ControlToValidate="txtDirectorName" ValidationGroup="SettingsForm"
                            ErrorMessage="Director/Dean name is required." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field users-field-span">
                        <label for="<%= txtCampusAddress.ClientID %>">Campus Physical Address &amp; Sector</label>
                        <asp:TextBox ID="txtCampusAddress" runat="server" MaxLength="250" />
                    </div>

                    <div class="users-field users-field-span">
                        <label for="<%= txtAccreditationStatus.ClientID %>">Accreditation &amp; Ranking Badges</label>
                        <asp:TextBox ID="txtAccreditationStatus" runat="server" MaxLength="150" />
                    </div>
                </div>
            </div>

            <!-- Section 2: Assessment Engine & Proctoring Defaults -->
            <div class="details-section-card">
                <div class="details-section-header">
                    <h2>Assessment Engine &amp; Proctoring Defaults</h2>
                    <span class="text-muted" style="font-size:11px;">Examination Rules</span>
                </div>

                <div class="users-form-grid">
                    <div class="users-field">
                        <label for="<%= txtTestDuration.ClientID %>">Default Assessment Duration (Minutes) *</label>
                        <asp:TextBox ID="txtTestDuration" runat="server" Text="60" MaxLength="3" />
                        <asp:RequiredFieldValidator ID="rfvTestDuration" runat="server"
                            ControlToValidate="txtTestDuration" ValidationGroup="SettingsForm"
                            ErrorMessage="Test duration is required." Display="Dynamic" CssClass="field-error" />
                        <asp:RangeValidator ID="rvTestDuration" runat="server"
                            ControlToValidate="txtTestDuration" ValidationGroup="SettingsForm"
                            Type="Integer" MinimumValue="10" MaximumValue="360"
                            ErrorMessage="Test duration must be between 10 and 360 minutes." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field">
                        <label for="<%= txtNegativeMarking.ClientID %>">Negative Marking Penalty Factor (0.00 - 1.00) *</label>
                        <asp:TextBox ID="txtNegativeMarking" runat="server" Text="0.25" MaxLength="4" />
                        <asp:RequiredFieldValidator ID="rfvNegativeMarking" runat="server"
                            ControlToValidate="txtNegativeMarking" ValidationGroup="SettingsForm"
                            ErrorMessage="Negative marking factor is required." Display="Dynamic" CssClass="field-error" />
                        <asp:RangeValidator ID="rvNegativeMarking" runat="server"
                            ControlToValidate="txtNegativeMarking" ValidationGroup="SettingsForm"
                            Type="Double" MinimumValue="0.00" MaximumValue="1.00"
                            ErrorMessage="Penalty factor must be between 0.00 and 1.00." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field">
                        <label for="<%= txtTabSwitchLimit.ClientID %>">Allowed Tab Switch Limit (Before Auto-Flag) *</label>
                        <asp:TextBox ID="txtTabSwitchLimit" runat="server" Text="3" MaxLength="2" />
                        <asp:RequiredFieldValidator ID="rfvTabSwitchLimit" runat="server"
                            ControlToValidate="txtTabSwitchLimit" ValidationGroup="SettingsForm"
                            ErrorMessage="Tab switch limit is required." Display="Dynamic" CssClass="field-error" />
                        <asp:RangeValidator ID="rvTabSwitchLimit" runat="server"
                            ControlToValidate="txtTabSwitchLimit" ValidationGroup="SettingsForm"
                            Type="Integer" MinimumValue="0" MaximumValue="20"
                            ErrorMessage="Tab switch limit must be between 0 and 20." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field">
                        <label for="<%= ddlWebcamProctoring.ClientID %>">AI Webcam Proctoring Baseline</label>
                        <asp:DropDownList ID="ddlWebcamProctoring" runat="server">
                            <asp:ListItem Text="AI Face &amp; Audio Sentinel Verification" Value="AI Face &amp; Audio Sentinel Verification" Selected="True" />
                            <asp:ListItem Text="Periodic Snapshot Verification (Every 30s)" Value="Periodic Snapshot Verification (Every 30s)" />
                            <asp:ListItem Text="Human Faculty Invigilator Feed" Value="Human Faculty Invigilator Feed" />
                            <asp:ListItem Text="Disabled (Practice Exams Only)" Value="Disabled" />
                        </asp:DropDownList>
                    </div>

                    <div class="users-field users-field-span">
                        <label class="settings-checkbox-item">
                            <asp:CheckBox ID="chkFullscreenLockdown" runat="server" Checked="true" />
                            Enforce full-screen browser lockdown and disable keyboard shortcuts during active assessments
                        </label>
                    </div>
                </div>
            </div>

        </div>

        <!-- Right Side Column: Academic Season & Notifications -->
        <div class="details-grid-side">

            <!-- Section 3: Academic Season Controls -->
            <div class="details-section-card">
                <div class="details-section-header">
                    <h3>Academic Season Cycle</h3>
                </div>

                <div class="users-field" style="margin-bottom: 12px;">
                    <label for="<%= txtActiveYear.ClientID %>">Active Placement Season *</label>
                    <asp:TextBox ID="txtActiveYear" runat="server" Text="2024 - 2025" MaxLength="20" />
                    <asp:RequiredFieldValidator ID="rfvActiveYear" runat="server"
                        ControlToValidate="txtActiveYear" ValidationGroup="SettingsForm"
                        ErrorMessage="Active placement year is required." Display="Dynamic" CssClass="field-error" />
                </div>

                <div class="users-field" style="margin-bottom: 12px;">
                    <label for="<%= txtTargetBatch.ClientID %>">Target Graduating Batch *</label>
                    <asp:TextBox ID="txtTargetBatch" runat="server" Text="2025" MaxLength="4" />
                    <asp:RequiredFieldValidator ID="rfvTargetBatch" runat="server"
                        ControlToValidate="txtTargetBatch" ValidationGroup="SettingsForm"
                        ErrorMessage="Target batch is required." Display="Dynamic" CssClass="field-error" />
                    <asp:RangeValidator ID="rvTargetBatch" runat="server"
                        ControlToValidate="txtTargetBatch" ValidationGroup="SettingsForm"
                        Type="Integer" MinimumValue="2020" MaximumValue="2035"
                        ErrorMessage="Target batch must be between 2020 and 2035." Display="Dynamic" CssClass="field-error" />
                </div>

                <div class="users-field">
                    <label for="<%= txtDefaultMinCgpa.ClientID %>">Default Minimum CGPA Threshold *</label>
                    <asp:TextBox ID="txtDefaultMinCgpa" runat="server" Text="7.00" MaxLength="4" />
                    <asp:RequiredFieldValidator ID="rfvDefaultMinCgpa" runat="server"
                        ControlToValidate="txtDefaultMinCgpa" ValidationGroup="SettingsForm"
                        ErrorMessage="Default CGPA cutoff is required." Display="Dynamic" CssClass="field-error" />
                    <asp:RangeValidator ID="rvDefaultMinCgpa" runat="server"
                        ControlToValidate="txtDefaultMinCgpa" ValidationGroup="SettingsForm"
                        Type="Double" MinimumValue="0.00" MaximumValue="10.00"
                        ErrorMessage="CGPA cutoff must be between 0.00 and 10.00." Display="Dynamic" CssClass="field-error" />
                </div>
            </div>

            <!-- Section 4: Notification Preferences -->
            <div class="details-section-card">
                <div class="details-section-header">
                    <h3>Automated Notification Alerts</h3>
                </div>

                <div class="settings-checkbox-group">
                    <label class="settings-checkbox-item">
                        <asp:CheckBox ID="chkNotifyDrives" runat="server" Checked="true" />
                        Broadcast on-campus drive announcements to eligible cohorts
                    </label>
                    <label class="settings-checkbox-item">
                        <asp:CheckBox ID="chkNotifyShortlists" runat="server" Checked="true" />
                        Notify candidates immediately upon test cutoff clearance
                    </label>
                    <label class="settings-checkbox-item">
                        <asp:CheckBox ID="chkNotifyInvites" runat="server" Checked="true" />
                        Send automated calendar invitations for scheduled interview rounds
                    </label>
                    <label class="settings-checkbox-item">
                        <asp:CheckBox ID="chkNotifyDigest" runat="server" Checked="true" />
                        Generate daily coordinator summary digest at 18:00 UTC
                    </label>
                </div>
            </div>

            <!-- Demonstration Notice -->
            <div class="users-hint">
                <strong>Demonstration Settings:</strong> Changes saved on this page update the in-memory <code>SettingsRepository</code> for the active application lifecycle. Live institutional SMTP relays and database connections are excluded per architectural specifications.
            </div>

        </div>

    </div>

</div>
</asp:Content>

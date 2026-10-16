<%@ Page Title="Account Settings" Language="C#" MasterPageFile="~/Student.Master"
    AutoEventWireup="true" CodeBehind="Settings.aspx.cs"
    Inherits="PlacementPrep.Settings" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Account Settings | Placement Prep</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="student-settings-container">
        
        <!-- Header -->
        <header class="student-aptitude-header">
            <div>
                <div class="student-analyzer-tag" style="margin-bottom:4px;">
                    <span class="tag-dot"></span>
                    <span>STUDENT ACCOUNT &bull; PREFERENCES &amp; SECURITY</span>
                </div>
                <h1 style="font-size:22px; font-weight:800; margin:0 0 4px; letter-spacing:-0.5px;">Account Settings</h1>
                <p style="margin:0; font-size:11px; color:#64748b;">
                    Manage your personal profile details, contact preferences, notification alerts, and security credentials.
                </p>
            </div>
        </header>

        <!-- Feedback Banner -->
        <asp:Panel ID="pnlSettingsNotice" runat="server" Visible="false" CssClass="stu-alert success" style="margin-bottom:16px; padding:12px 16px; border-radius:8px; background:#ecfdf5; border:1px solid #a7f3d0; color:#065f46; font-size:11px;">
            <asp:Literal ID="litSettingsNotice" runat="server" />
        </asp:Panel>

        <!-- Settings Split Layout -->
        <div class="settings-split-layout">
            
            <!-- Left Side: Nav Tabs -->
            <div class="settings-nav-card">
                <a href="#personal" class="settings-nav-item active">
                    <svg viewBox="0 0 24 24" width="15" height="15" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="8" r="4"/><path d="M5 20a7 7 0 0 1 14 0"/></svg>
                    <span>Personal Profile</span>
                </a>
                <a href="#security" class="settings-nav-item">
                    <svg viewBox="0 0 24 24" width="15" height="15" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg>
                    <span>Password &amp; Security</span>
                </a>
                <a href="#notifications" class="settings-nav-item">
                    <svg viewBox="0 0 24 24" width="15" height="15" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"/><path d="M13.73 21a2 2 0 0 1-3.46 0"/></svg>
                    <span>Notification Alerts</span>
                </a>
            </div>

            <!-- Right Side: Forms -->
            <div class="settings-content-card">
                
                <!-- Section 1: Personal Information -->
                <div id="personal">
                    <h3 style="font-size:15px; font-weight:800; margin:0 0 4px; color:var(--stu-text);">Personal Information</h3>
                    <p style="font-size:11px; color:#64748b; margin:0 0 16px;">This information is displayed on your placement profile and resume export.</p>

                    <!-- Avatar Row -->
                    <div class="settings-avatar-row">
                        <div class="settings-avatar-circle">
                            <asp:Literal ID="litAvatarInitials" runat="server" Text="VP" />
                            <asp:Image ID="imgAvatar" runat="server" Visible="false" CssClass="settings-avatar-img" AlternateText="Avatar" />
                        </div>
                        <div style="display:flex; flex-direction:column; gap:6px;">
                            <strong style="font-size:12px; color:var(--stu-text);">Profile Photo</strong>
                            <small style="color:#64748b; font-size:10px;">Recommended size: Square PNG or JPG, max 2MB.</small>
                            <asp:FileUpload ID="fuProfilePhoto" runat="server" CssClass="stu-btn-outline" style="font-size:10px; padding:4px 8px;" />
                        </div>
                    </div>

                    <!-- Personal Inputs Grid -->
                    <div class="form-grid-2col" style="margin-top:16px;">
                        
                        <div class="form-field-group">
                            <label>Full Name <span style="color:#dc2626;">*</span></label>
                            <asp:TextBox ID="txtFullName" runat="server" CssClass="stu-input" Text="Vishal Patil" />
                            <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ControlToValidate="txtFullName" ErrorMessage="Full name is required." CssClass="validator-error" Display="Dynamic" ValidationGroup="vgProfile" />
                        </div>

                        <div class="form-field-group">
                            <label>Roll / Enrollment Number</label>
                            <asp:TextBox ID="txtRollNumber" runat="server" CssClass="stu-input" Text="CS2026-084" Enabled="false" style="background:#f8fafc;" />
                        </div>

                        <div class="form-field-group">
                            <label>Email Address <span style="color:#dc2626;">*</span></label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="stu-input" Text="vishal.patil@campus.edu" />
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required." CssClass="validator-error" Display="Dynamic" ValidationGroup="vgProfile" />
                            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" ErrorMessage="Invalid email address format." CssClass="validator-error" Display="Dynamic" ValidationGroup="vgProfile" />
                        </div>

                        <div class="form-field-group">
                            <label>Phone Number <span style="color:#dc2626;">*</span></label>
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="stu-input" Text="+91 9876543210" />
                            <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="Phone number is required." CssClass="validator-error" Display="Dynamic" ValidationGroup="vgProfile" />
                        </div>

                        <div class="form-field-group">
                            <label>College / University</label>
                            <asp:TextBox ID="txtCollege" runat="server" CssClass="stu-input" Text="Institute of Engineering &amp; Technology" />
                        </div>

                        <div class="form-field-group">
                            <label>Degree &amp; Graduation Year</label>
                            <asp:TextBox ID="txtGraduation" runat="server" CssClass="stu-input" Text="B.Tech Computer Science &bull; 2026" />
                        </div>

                    </div>

                    <div style="margin-top:16px; display:flex; gap:10px;">
                        <asp:Button ID="btnSaveProfile" runat="server" Text="Save Profile Changes" CssClass="stu-btn-primary" OnClick="btnSaveProfile_Click" ValidationGroup="vgProfile" />
                        <asp:Button ID="btnCancelProfile" runat="server" Text="Cancel" CssClass="stu-btn-outline" CausesValidation="false" OnClick="btnCancelProfile_Click" />
                    </div>
                </div>

                <!-- Divider -->
                <div style="border-top:1px solid #eeedf5; margin:10px 0;"></div>

                <!-- Section 2: Security & Password -->
                <div id="security">
                    <h3 style="font-size:15px; font-weight:800; margin:0 0 4px; color:var(--stu-text);">Change Password</h3>
                    <p style="font-size:11px; color:#64748b; margin:0 0 16px;">Ensure your account is protected with a secure password containing letters, numbers, and symbols.</p>

                    <div class="form-grid-2col">
                        
                        <div class="form-field-group">
                            <label>Current Password <span style="color:#dc2626;">*</span></label>
                            <asp:TextBox ID="txtCurrentPassword" runat="server" TextMode="Password" CssClass="stu-input" placeholder="Enter current password" />
                            <asp:RequiredFieldValidator ID="rfvCurrentPwd" runat="server" ControlToValidate="txtCurrentPassword" ErrorMessage="Current password is required." CssClass="validator-error" Display="Dynamic" ValidationGroup="vgSecurity" />
                        </div>

                        <div style="display:none;"></div>

                        <div class="form-field-group">
                            <label>New Password <span style="color:#dc2626;">*</span></label>
                            <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="stu-input" placeholder="At least 6 characters" />
                            <asp:RequiredFieldValidator ID="rfvNewPwd" runat="server" ControlToValidate="txtNewPassword" ErrorMessage="New password is required." CssClass="validator-error" Display="Dynamic" ValidationGroup="vgSecurity" />
                        </div>

                        <div class="form-field-group">
                            <label>Confirm New Password <span style="color:#dc2626;">*</span></label>
                            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="stu-input" placeholder="Repeat new password" />
                            <asp:RequiredFieldValidator ID="rfvConfirmPwd" runat="server" ControlToValidate="txtConfirmPassword" ErrorMessage="Confirm password is required." CssClass="validator-error" Display="Dynamic" ValidationGroup="vgSecurity" />
                            <asp:CompareValidator ID="cvPasswords" runat="server" ControlToValidate="txtConfirmPassword" ControlToCompare="txtNewPassword" ErrorMessage="Passwords do not match." CssClass="validator-error" Display="Dynamic" ValidationGroup="vgSecurity" />
                        </div>

                    </div>

                    <div style="margin-top:16px; display:flex; gap:10px;">
                        <asp:Button ID="btnChangePassword" runat="server" Text="Update Password" CssClass="stu-btn-primary" OnClick="btnChangePassword_Click" ValidationGroup="vgSecurity" />
                        <asp:Button ID="btnCancelPassword" runat="server" Text="Cancel" CssClass="stu-btn-outline" CausesValidation="false" OnClick="btnCancelPassword_Click" />
                    </div>
                </div>

                <!-- Divider -->
                <div style="border-top:1px solid #eeedf5; margin:10px 0;"></div>

                <!-- Section 3: Notification Preferences -->
                <div id="notifications">
                    <h3 style="font-size:15px; font-weight:800; margin:0 0 4px; color:var(--stu-text);">Notification Preferences</h3>
                    <p style="font-size:11px; color:#64748b; margin:0 0 16px;">Configure how and when you receive recruitment drive alerts and mentor notes.</p>

                    <div style="display:flex; flex-direction:column; gap:10px; font-size:11.5px;">
                        <label style="display:flex; align-items:center; gap:8px; cursor:pointer;">
                            <asp:CheckBox ID="chkPlacementAlerts" runat="server" Checked="true" />
                            <span><strong>Campus Recruitment Drive Alerts:</strong> Receive instant notices for eligible hiring drives</span>
                        </label>

                        <label style="display:flex; align-items:center; gap:8px; cursor:pointer;">
                            <asp:CheckBox ID="chkWeeklyDigest" runat="server" Checked="true" />
                            <span><strong>Weekly Diagnostic Digest:</strong> Summary of aptitude accuracy, solved problems, and peer rankings</span>
                        </label>

                        <label style="display:flex; align-items:center; gap:8px; cursor:pointer;">
                            <asp:CheckBox ID="chkInterviewReminders" runat="server" Checked="true" />
                            <span><strong>Mock Interview Reminders:</strong> Calendar reminders 1 hour before scheduled sessions</span>
                        </label>
                    </div>

                    <div style="margin-top:16px; display:flex; gap:10px;">
                        <asp:Button ID="btnSavePreferences" runat="server" Text="Save Notification Settings" CssClass="stu-btn-primary" OnClick="btnSavePreferences_Click" />
                        <asp:Button ID="btnCancelPreferences" runat="server" Text="Cancel" CssClass="stu-btn-outline" CausesValidation="false" OnClick="btnCancelPreferences_Click" />
                    </div>
                </div>

            </div>

        </div>

    </div>
</asp:Content>

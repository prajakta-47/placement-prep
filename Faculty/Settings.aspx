<%@ Page Title="Settings" Language="C#" MasterPageFile="~/Faculty.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="PlacementPrep.Faculty.Settings" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <style>
        .settings-container {
            max-width: 1080px;
            margin: 0 auto;
            padding: 8px 0 32px;
        }

        .settings-header {
            margin-bottom: 24px;
        }

        .settings-header h1 {
            font-size: 24px;
            font-weight: 800;
            color: #0f172a;
            margin: 0 0 6px;
            letter-spacing: -0.02em;
        }

        .settings-header p {
            font-size: 13px;
            color: #64748b;
            margin: 0;
        }

        .settings-layout {
            display: grid;
            grid-template-columns: 220px 1fr;
            gap: 28px;
            align-items: start;
        }

        @media (max-width: 768px) {
            .settings-layout {
                grid-template-columns: 1fr;
            }
        }

        /* Vertical Tabs */
        .settings-nav {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .settings-nav-btn {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 10px 14px;
            border-radius: 8px;
            border: none;
            background: transparent;
            color: #475569;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.15s ease;
            text-align: left;
            width: 100%;
        }

        .settings-nav-btn svg {
            width: 18px;
            height: 18px;
            stroke-width: 1.8;
            stroke: currentColor;
            fill: none;
            flex-shrink: 0;
        }

        .settings-nav-btn:hover {
            background: #f1f5f9;
            color: #0f172a;
        }

        .settings-nav-btn.active {
            background: #c9f7ef;
            color: #00685e;
        }

        /* Settings Card */
        .settings-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 24px 28px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.04);
        }

        .settings-card-title {
            font-size: 16px;
            font-weight: 700;
            color: #0f172a;
            margin: 0 0 18px;
            padding-bottom: 14px;
            border-bottom: 1px solid #f1f5f9;
        }

        /* Avatar Row */
        .avatar-row {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 24px;
        }

        .avatar-circle {
            width: 64px;
            height: 64px;
            border-radius: 50%;
            background: linear-gradient(135deg, #00685e 0%, #004d46 100%);
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            font-weight: 700;
            box-shadow: 0 4px 10px rgba(0, 104, 94, 0.2);
            flex-shrink: 0;
        }

        .avatar-info h4 {
            margin: 0 0 4px;
            font-size: 13px;
            font-weight: 700;
            color: #1e293b;
        }

        .avatar-info p {
            margin: 0 0 10px;
            font-size: 11px;
            color: #64748b;
        }

        .avatar-actions {
            display: flex;
            gap: 8px;
        }

        .btn-upload {
            padding: 6px 14px;
            border-radius: 6px;
            background: #00685e;
            color: #ffffff;
            border: none;
            font-size: 11px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.15s;
        }

        .btn-upload:hover {
            background: #00524a;
        }

        .btn-remove {
            padding: 6px 14px;
            border-radius: 6px;
            background: #ffffff;
            color: #475569;
            border: 1px solid #cbd5e1;
            font-size: 11px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.15s;
        }

        .btn-remove:hover {
            background: #f8fafc;
            color: #0f172a;
        }

        /* Form Grid */
        .form-grid-2 {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
            margin-bottom: 16px;
        }

        @media (max-width: 600px) {
            .form-grid-2 {
                grid-template-columns: 1fr;
            }
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 6px;
            margin-bottom: 16px;
        }

        .form-group label {
            font-size: 12px;
            font-weight: 600;
            color: #334155;
        }

        .form-input {
            width: 100%;
            padding: 9px 13px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            background: #f8fafc;
            color: #0f172a;
            font-size: 12px;
            font-family: inherit;
            transition: all 0.15s ease;
            box-sizing: border-box;
        }

        .form-input:focus {
            background: #ffffff;
            border-color: #00685e;
            outline: none;
            box-shadow: 0 0 0 3px rgba(0, 104, 94, 0.12);
        }

        .btn-save {
            background: #00685e;
            color: #ffffff;
            border: none;
            padding: 10px 22px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.15s;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-save:hover {
            background: #00524a;
        }

        /* Alert Notification */
        .alert-toast {
            display: flex;
            align-items: center;
            gap: 10px;
            background: #ecfdf5;
            border: 1px solid #a7f3d0;
            color: #065f46;
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        /* Toggle items */
        .toggle-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 14px 0;
            border-bottom: 1px solid #f1f5f9;
        }

        .toggle-item:last-child {
            border-bottom: none;
        }

        .toggle-title {
            font-size: 13px;
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 2px;
        }

        .toggle-desc {
            font-size: 11px;
            color: #64748b;
        }
    </style>
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="settings-container">

    <div class="settings-header">
        <h1>Settings</h1>
        <p>Manage your account preferences, notifications, security credentials, and portal defaults.</p>
    </div>

    <!-- Feedback Message -->
    <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="alert-toast">
        <svg viewBox="0 0 24 24" style="width:18px;height:18px;fill:none;stroke:#059669;stroke-width:2;">
            <path d="M20 6 9 17l-5-5" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
        <asp:Literal ID="litSuccessMessage" runat="server" />
    </asp:Panel>

    <div class="settings-layout">

        <!-- Navigation Tabs -->
        <div class="settings-nav">
            <button type="button" class="settings-nav-btn active" onclick="switchSettingsTab('account', this)">
                <svg viewBox="0 0 24 24">
                    <circle cx="12" cy="8" r="4"/>
                    <path d="M6 20v-2a6 6 0 0 1 12 0v2"/>
                </svg>
                <span>Account</span>
            </button>
            <button type="button" class="settings-nav-btn" onclick="switchSettingsTab('notifications', this)">
                <svg viewBox="0 0 24 24">
                    <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"/>
                    <path d="M13.73 21a2 2 0 0 1-3.46 0"/>
                </svg>
                <span>Notifications</span>
            </button>
            <button type="button" class="settings-nav-btn" onclick="switchSettingsTab('security', this)">
                <svg viewBox="0 0 24 24">
                    <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/>
                </svg>
                <span>Security</span>
            </button>
            <button type="button" class="settings-nav-btn" onclick="switchSettingsTab('preferences', this)">
                <svg viewBox="0 0 24 24">
                    <line x1="4" y1="21" x2="4" y2="14"/>
                    <line x1="4" y1="10" x2="4" y2="3"/>
                    <line x1="12" y1="21" x2="12" y2="12"/>
                    <line x1="12" y1="8" x2="12" y2="3"/>
                    <line x1="20" y1="21" x2="20" y2="16"/>
                    <line x1="20" y1="12" x2="20" y2="3"/>
                    <line x1="1" y1="14" x2="7" y2="14"/>
                    <line x1="9" y1="8" x2="15" y2="8"/>
                    <line x1="17" y1="16" x2="23" y2="16"/>
                </svg>
                <span>Portal Defaults</span>
            </button>
        </div>

        <!-- Tab Contents -->
        <div class="settings-content-wrapper">

            <!-- TAB 1: ACCOUNT PREFERENCES -->
            <div id="tab-account" class="settings-card">
                <div class="settings-card-title">Account Preferences</div>

                <div class="avatar-row">
                    <div class="avatar-circle">
                        <span>RS</span>
                    </div>
                    <div class="avatar-info">
                        <h4>Profile Photo</h4>
                        <p>Recommended size: 256x256px. Max 2MB.</p>
                        <div class="avatar-actions">
                            <button type="button" class="btn-upload" onclick="alert('Photo upload dialog: Selected photo updated.');">Upload New</button>
                            <button type="button" class="btn-remove" onclick="alert('Photo removed. Default initials avatar applied.');">Remove</button>
                        </div>
                    </div>
                </div>

                <div class="form-grid-2">
                    <div class="form-group">
                        <label>Full Name</label>
                        <asp:TextBox ID="txtFullName" runat="server" CssClass="form-input" />
                    </div>
                    <div class="form-group">
                        <label>Email Address</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input" TextMode="Email" />
                    </div>
                </div>

                <div class="form-grid-2">
                    <div class="form-group">
                        <label>Designation</label>
                        <asp:TextBox ID="txtDesignation" runat="server" CssClass="form-input" />
                    </div>
                    <div class="form-group">
                        <label>Department</label>
                        <asp:TextBox ID="txtDepartment" runat="server" CssClass="form-input" />
                    </div>
                </div>

                <div class="form-grid-2">
                    <div class="form-group">
                        <label>Contact Phone</label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-input" />
                    </div>
                    <div class="form-group">
                        <label>Office / Cabin Location</label>
                        <asp:TextBox ID="txtOfficeLocation" runat="server" CssClass="form-input" />
                    </div>
                </div>

                <div style="text-align:right; margin-top:16px;">
                    <asp:Button ID="btnSaveAccount" runat="server" Text="Save Changes" CssClass="btn-save" OnClick="btnSaveAccount_Click" />
                </div>
            </div>

            <!-- TAB 2: NOTIFICATIONS -->
            <div id="tab-notifications" class="settings-card" style="display:none;">
                <div class="settings-card-title">Notification Channels &amp; Alerts</div>

                <div class="toggle-item">
                    <div>
                        <div class="toggle-title">Daily Test Summary Email</div>
                        <div class="toggle-desc">Receive an aggregated evening report of all mock test results and student completions.</div>
                    </div>
                    <div>
                        <asp:CheckBox ID="chkDailyEmail" runat="server" />
                    </div>
                </div>

                <div class="toggle-item">
                    <div>
                        <div class="toggle-title">Instant Proctor Flag SMS &amp; Email</div>
                        <div class="toggle-desc">Trigger high-priority alerts when full-screen lockdown violations or focus shifts occur.</div>
                    </div>
                    <div>
                        <asp:CheckBox ID="chkProctorSms" runat="server" />
                    </div>
                </div>

                <div class="toggle-item">
                    <div>
                        <div class="toggle-title">Weekly Placement Velocity Digest</div>
                        <div class="toggle-desc">Cohort-wide analytics comparison against institutional target benchmarks.</div>
                    </div>
                    <div>
                        <asp:CheckBox ID="chkWeeklyDigest" runat="server" />
                    </div>
                </div>

                <div class="toggle-item">
                    <div>
                        <div class="toggle-title">New Student Registration Alerts</div>
                        <div class="toggle-desc">Notify whenever a candidate is newly verified by university SIS synchronization.</div>
                    </div>
                    <div>
                        <asp:CheckBox ID="chkRegistrationAlert" runat="server" />
                    </div>
                </div>

                <div style="text-align:right; margin-top:20px;">
                    <asp:Button ID="btnSaveNotifications" runat="server" Text="Save Notification Settings" CssClass="btn-save" OnClick="btnSaveNotifications_Click" />
                </div>
            </div>

            <!-- TAB 3: SECURITY -->
            <div id="tab-security" class="settings-card" style="display:none;">
                <div class="settings-card-title">Security &amp; Credentials</div>

                <div class="form-group">
                    <label>Current Password</label>
                    <asp:TextBox ID="txtCurrentPassword" runat="server" CssClass="form-input" TextMode="Password" />
                </div>

                <div class="form-grid-2">
                    <div class="form-group">
                        <label>New Password</label>
                        <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-input" TextMode="Password" />
                    </div>
                    <div class="form-group">
                        <label>Confirm New Password</label>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-input" TextMode="Password" />
                    </div>
                </div>

                <div class="toggle-item" style="margin-top:10px;">
                    <div>
                        <div class="toggle-title">Two-Factor Authentication (2FA)</div>
                        <div class="toggle-desc">Require one-time email OTP verification on login from unrecognized devices.</div>
                    </div>
                    <div>
                        <asp:CheckBox ID="chkTwoFactor" runat="server" />
                    </div>
                </div>

                <div style="text-align:right; margin-top:20px;">
                    <asp:Button ID="btnSaveSecurity" runat="server" Text="Update Security Credentials" CssClass="btn-save" OnClick="btnSaveSecurity_Click" />
                </div>

                <div style="margin-top:28px; padding-top:20px; border-top:1px solid #f1f5f9; display:flex; justify-content:space-between; align-items:center;">
                    <div>
                        <div style="font-size:13px; font-weight:700; color:#b91c1c;">Active Session</div>
                        <div style="font-size:11px; color:#64748b;">Sign out of this session and redirect to the login portal.</div>
                    </div>
                    <a href="<%= ResolveUrl("~/Login.aspx?logout=true") %>" class="btn-secondary" style="color:#b91c1c; border-color:#fecaca; background:#fef2f2; text-decoration:none; display:inline-flex; align-items:center; gap:6px; padding:8px 14px; border-radius:6px; font-size:12px; font-weight:600;">
                        <svg viewBox="0 0 24 24" style="width:14px;height:14px;stroke:currentColor;fill:none;stroke-width:2;"><path d="M10 4H5v16h5m4-4 4-4-4-4m4 4H9"/></svg>
                        Logout from Portal
                    </a>
                </div>
            </div>

            <!-- TAB 4: PORTAL DEFAULTS -->
            <div id="tab-preferences" class="settings-card" style="display:none;">
                <div class="settings-card-title">Assessment Engine &amp; Evaluation Defaults</div>

                <div class="form-grid-2">
                    <div class="form-group">
                        <label>Default AI Evaluation Inference Model</label>
                        <asp:DropDownList ID="ddlInferenceModel" runat="server" CssClass="form-input">
                            <asp:ListItem Value="GPT-4 Turbo" Text="GPT-4 Turbo (Recommended)" />
                            <asp:ListItem Value="Claude 3.5 Sonnet" Text="Claude 3.5 Sonnet" />
                            <asp:ListItem Value="Gemini 1.5 Pro" Text="Gemini 1.5 Pro" />
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <label>Benchmark Passing Cutoff (%)</label>
                        <asp:TextBox ID="txtCutoff" runat="server" CssClass="form-input" TextMode="Number" />
                    </div>
                </div>

                <div class="toggle-item">
                    <div>
                        <div class="toggle-title">Negative Marking by Default (-0.25)</div>
                        <div class="toggle-desc">Automatically apply negative scoring for incorrect MCQ aptitude answers.</div>
                    </div>
                    <div>
                        <asp:CheckBox ID="chkNegativeMarking" runat="server" />
                    </div>
                </div>

                <div class="toggle-item">
                    <div>
                        <div class="toggle-title">Randomize Question Sequence</div>
                        <div class="toggle-desc">Shuffle test questions per candidate to prevent screen copying during lab tests.</div>
                    </div>
                    <div>
                        <asp:CheckBox ID="chkShuffle" runat="server" />
                    </div>
                </div>

                <div style="text-align:right; margin-top:20px;">
                    <asp:Button ID="btnSavePreferences" runat="server" Text="Save Portal Defaults" CssClass="btn-save" OnClick="btnSavePreferences_Click" />
                </div>
            </div>

        </div>

    </div>

</div>

<script>
    function switchSettingsTab(tabName, btn) {
        var tabs = ['account', 'notifications', 'security', 'preferences'];
        tabs.forEach(function (t) {
            var el = document.getElementById('tab-' + t);
            if (el) el.style.display = (t === tabName) ? 'block' : 'none';
        });
        var btns = document.querySelectorAll('.settings-nav-btn');
        btns.forEach(function (b) {
            b.classList.remove('active');
        });
        if (btn) btn.classList.add('active');
    }
</script>
</asp:Content>

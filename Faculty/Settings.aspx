<%@ Page Title="Settings" Language="C#" MasterPageFile="~/Faculty.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="PlacementPrep.Faculty.Settings" %>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="faculty-dashboard" style="display:flex; flex-direction:column; gap:16px;">

    <div class="faculty-dashboard-heading" style="margin-bottom:0;">
        <div>
            <h1>Faculty Profile &amp; Portal Settings</h1>
            <p>Coordinator credentials, department preferences, and notification channels</p>
        </div>
        <span class="spec-badge spec-badge-teal">Active Session</span>
    </div>

    <div class="faculty-dashboard-grid">
        <div class="faculty-left-column">
            <section class="faculty-panel">
                <div class="faculty-panel-heading">
                    <h2>Coordinator Profile Information</h2>
                </div>
                <div style="display:flex; flex-direction:column; gap:12px; margin-top:14px; font-size:12px;">
                    <div>
                        <label style="font-size:11px; font-weight:600; color:var(--fac-muted); display:block; margin-bottom:4px;">Full Name</label>
                        <input type="text" value="Prof. R. Sharma" readonly class="fac-control" style="background:#f8fafc;" />
                    </div>
                    <div>
                        <label style="font-size:11px; font-weight:600; color:var(--fac-muted); display:block; margin-bottom:4px;">Designation</label>
                        <input type="text" value="Placement Coordinator &amp; Associate Professor" readonly class="fac-control" style="background:#f8fafc;" />
                    </div>
                    <div>
                        <label style="font-size:11px; font-weight:600; color:var(--fac-muted); display:block; margin-bottom:4px;">Department</label>
                        <input type="text" value="Computer Science &amp; Engineering" readonly class="fac-control" style="background:#f8fafc;" />
                    </div>
                    <div>
                        <label style="font-size:11px; font-weight:600; color:var(--fac-muted); display:block; margin-bottom:4px;">Email</label>
                        <input type="email" value="r.sharma@campus.edu" readonly class="fac-control" style="background:#f8fafc;" />
                    </div>
                </div>
            </section>
        </div>

        <aside class="faculty-right-column">
            <section class="faculty-panel">
                <div class="faculty-panel-heading">
                    <h2>Preferences</h2>
                </div>
                <div style="display:flex; flex-direction:column; gap:10px; margin-top:12px; font-size:11px;">
                    <div>&bull; Daily test summary email: <strong>Enabled</strong></div>
                    <div>&bull; Instant proctor flag notification: <strong>SMS &amp; Email</strong></div>
                    <div>&bull; Default inference model: <strong>GPT-4 Turbo</strong></div>
                </div>
            </section>
        </aside>
    </div>

</div>
</asp:Content>

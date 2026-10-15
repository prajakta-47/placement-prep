<%@ Page Title="Placement Drives" Language="C#" MasterPageFile="~/Faculty.Master" AutoEventWireup="true" CodeBehind="PlacementDrives.aspx.cs" Inherits="PlacementPrep.Faculty.PlacementDrives" %>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="faculty-dashboard" style="display:flex; flex-direction:column; gap:16px;">

    <div class="faculty-dashboard-heading" style="margin-bottom:0;">
        <div>
            <h1>Placement Drives &amp; Assessment Schedule</h1>
            <p>Coordinate student attendance, assessment slot assignments, and company interview rosters</p>
        </div>
        <span class="faculty-sync-label">Active Drives: 3</span>
    </div>

    <div style="display:grid; grid-template-columns:repeat(auto-fill, minmax(290px, 1fr)); gap:16px;">
        <asp:Repeater ID="rptDrives" runat="server">
            <ItemTemplate>
                <div class="faculty-panel" style="display:flex; flex-direction:column; gap:8px;">
                    <div style="display:flex; justify-content:space-between; align-items:center;">
                        <span class="faculty-tag" style="background:#e4edff; color:#2c4b82;"><%# Eval("DriveId") %></span>
                        <span class="spec-badge spec-badge-teal"><%# Eval("Status") %></span>
                    </div>
                    <div>
                        <h3 style="margin:4px 0 2px; font-size:14px; font-weight:700;"><%# Eval("CompanyName") %></h3>
                        <p style="margin:0; font-size:11px; color:var(--fac-muted);"><%# Eval("JobTitle") %></p>
                    </div>
                    <div style="font-size:11px; color:var(--fac-text); margin-top:4px;">
                        <div><strong>Date:</strong> <%# Eval("EventDate") %></div>
                        <div><strong>Timing:</strong> <%# Eval("TimeWindow") %></div>
                        <div><strong>Location:</strong> <%# Eval("Location") %></div>
                    </div>
                    <div style="padding-top:8px; border-top:1px solid #f0f3f8; font-size:11px; color:var(--fac-teal); font-weight:600;">
                        <span>Registered Students: <%# Eval("RegisteredStudents") %></span>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

</div>
</asp:Content>

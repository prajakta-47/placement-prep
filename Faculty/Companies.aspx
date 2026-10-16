<%@ Page Title="Companies" Language="C#" MasterPageFile="~/Faculty.Master" AutoEventWireup="true" CodeBehind="Companies.aspx.cs" Inherits="PlacementPrep.Faculty.Companies" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <style>
        .fac-company-card {
            background: #ffffff;
            border: 1px solid var(--fac-border);
            border-radius: 8px;
            padding: 16px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
    </style>
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="faculty-dashboard" style="display:flex; flex-direction:column; gap:16px;">

    <div class="faculty-dashboard-heading" style="margin-bottom:0;">
        <div>
            <h1>Corporate Partner Directory &amp; Campus Drives</h1>
            <p>Hiring criteria, eligibility cutoffs, and scheduled recruitment drives</p>
        </div>
        <a href="PlacementDrives.aspx" class="faculty-new-drive" style="margin-top:0; height:34px; padding:0 14px; display:inline-flex; align-items:center;">
            <span>＋</span> New Drive Registration
        </a>
    </div>

    <div style="display:grid; grid-template-columns:repeat(auto-fill, minmax(290px, 1fr)); gap:16px;">
        <asp:Repeater ID="rptCompanies" runat="server">
            <ItemTemplate>
                <div class="fac-company-card">
                    <div style="display:flex; justify-content:space-between; align-items:center;">
                        <h3 style="margin:0; font-size:14px; font-weight:700; color:var(--fac-text);"><%# Eval("CompanyName") %></h3>
                        <span class="faculty-tag" style="background:#e6f9f5; color:#00685e;"><%# Eval("Status") %></span>
                    </div>
                    <div style="font-size:11px; color:var(--fac-muted);">
                        <div><strong>Role:</strong> <%# Eval("Role") %></div>
                        <div><strong>Industry:</strong> <%# Eval("Industry") %></div>
                        <div><strong>Drive Date:</strong> <%# Eval("DriveDate") %></div>
                    </div>
                    <div style="display:flex; justify-content:space-between; align-items:center; font-size:11px; padding-top:8px; border-top:1px solid #f0f3f8;">
                        <span>CTC: <strong style="color:var(--fac-teal);"><%# Eval("PackageLPA", "{0:F1}") %> LPA</strong></span>
                        <span>Eligible: <strong><%# Eval("EligibleCount") %> Students</strong></span>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

</div>
</asp:Content>

<%@ Page Title="Batch Reports" Language="C#" MasterPageFile="~/Faculty.Master" AutoEventWireup="true" CodeBehind="BatchReports.aspx.cs" Inherits="PlacementPrep.Faculty.BatchReports" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <style>
        .fac-report-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 11px;
            margin-top: 12px;
        }
        .fac-report-table th, .fac-report-table td {
            padding: 8px 12px;
            text-align: left;
            border-bottom: 1px solid var(--fac-border);
        }
        .fac-report-table th {
            background: #f7f9fc;
            color: var(--fac-muted);
        }
    </style>
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="faculty-dashboard" style="display:flex; flex-direction:column; gap:16px;">

    <div class="faculty-dashboard-heading" style="margin-bottom:0;">
        <div>
            <h1>Batch Evaluation &amp; Mock Test Reports</h1>
            <p>Aggregated cohort readiness matrices for placement cell submission</p>
        </div>
        <button type="button" class="faculty-export" onclick="window.print()">
            <svg viewBox="0 0 24 24" style="width:14px; height:14px; stroke:currentColor; fill:none; stroke-width:2;"><path d="M6 9V2h12v7M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"/><rect x="6" y="14" width="12" height="8"/></svg>
            <span>Export Official PDF</span>
        </button>
    </div>

    <section class="faculty-panel">
        <div class="faculty-panel-heading">
            <h2>Cohort Readiness Matrix (CSE 2024-25)</h2>
            <span class="faculty-sync-label">Certified by Coordinator</span>
        </div>

        <table class="fac-report-table">
            <thead>
                <tr>
                    <th>Rank</th>
                    <th>Roll No</th>
                    <th>Candidate</th>
                    <th>CGPA</th>
                    <th>Mock Avg</th>
                    <th>Solved</th>
                    <th>Readiness Status</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptBatchSummary" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td>#<%# Eval("BatchRank") %></td>
                            <td><strong><%# Eval("RollNo") %></strong></td>
                            <td><%# Eval("Name") %></td>
                            <td><%# Eval("CGPA", "{0:F2}") %></td>
                            <td><%# Eval("AvgScore", "{0:F1}") %>%</td>
                            <td><%# Eval("TotalSolved") %> probs</td>
                            <td><span class="faculty-tag" style="background:#e6f9f5; color:#00685e;"><%# Eval("Status") %></span></td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </section>

</div>
</asp:Content>

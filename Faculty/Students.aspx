<%@ Page Title="Students" Language="C#" MasterPageFile="~/Faculty.Master" AutoEventWireup="true" CodeBehind="Students.aspx.cs" Inherits="PlacementPrep.Faculty.Students" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <style>
        .fac-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 11px;
            margin-top: 12px;
        }
        .fac-table th {
            background: #f7f9fc;
            padding: 8px 12px;
            text-align: left;
            color: var(--fac-muted);
            font-weight: 600;
            border-bottom: 1px solid var(--fac-border);
        }
        .fac-table td {
            padding: 10px 12px;
            border-bottom: 1px solid #f0f3f8;
            color: var(--fac-text);
        }
        .fac-table tr:hover td {
            background: #fafbfe;
        }
        .badge-fit {
            background: #e6f9f5;
            color: #00685e;
            padding: 2px 8px;
            border-radius: 4px;
            font-weight: 600;
            font-size: 10px;
        }
        .badge-track {
            background: #e4edff;
            color: #2b4c7e;
            padding: 2px 8px;
            border-radius: 4px;
            font-weight: 600;
            font-size: 10px;
        }
        .badge-review {
            background: #fef2f2;
            color: #b91c1c;
            padding: 2px 8px;
            border-radius: 4px;
            font-weight: 600;
            font-size: 10px;
        }
        .filter-strip {
            display: flex;
            align-items: center;
            gap: 10px;
            background: #ffffff;
            padding: 10px 14px;
            border-radius: 8px;
            border: 1px solid var(--fac-border);
        }
    </style>
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="faculty-dashboard" style="display:flex; flex-direction:column; gap:16px;">

    <!-- Heading -->
    <div class="faculty-dashboard-heading" style="margin-bottom:0;">
        <div>
            <h1>Student Cohort &amp; Placement Readiness</h1>
            <p>Monitor individual preparation metrics, mock test performance, and placement fit scores</p>
        </div>
        <div>
            <a href="PlacementDrives.aspx" class="faculty-new-drive" style="margin-top:0; height:34px; padding:0 14px; display:inline-flex; align-items:center;">
                <span>＋</span> Schedule Assessment
            </a>
        </div>
    </div>

    <!-- Filters Strip -->
    <div class="filter-strip">
        <asp:TextBox ID="txtSearch" runat="server" placeholder="Search by name or roll number..." 
            style="flex:1; padding:7px 10px; font-size:11px; border:1px solid #dde3ea; border-radius:6px;" />
        <asp:DropDownList ID="ddlStatus" runat="server" style="padding:7px 10px; font-size:11px; border:1px solid #dde3ea; border-radius:6px;">
            <asp:ListItem Value="ALL" Text="All Readiness Statuses" Selected="True" />
            <asp:ListItem Value="Strong Fit" Text="Strong Fit" />
            <asp:ListItem Value="On Track" Text="On Track" />
            <asp:ListItem Value="Needs Review" Text="Needs Review" />
        </asp:DropDownList>
        <asp:Button ID="btnFilter" runat="server" Text="Filter Students" OnClick="btnFilter_Click" 
            style="background:var(--fac-teal); color:#fff; border:none; padding:7px 14px; border-radius:6px; font-size:11px; font-weight:600; cursor:pointer;" />
    </div>

    <!-- Students Table Panel -->
    <section class="faculty-panel">
        <div class="faculty-panel-heading">
            <div>
                <h2>Registered Student Cohort</h2>
                <p>Academic Year 2024-25 &bull; B.Tech Final Year</p>
            </div>
            <span class="faculty-sync-label">Synced with University SIS</span>
        </div>

        <table class="fac-table">
            <thead>
                <tr>
                    <th>Roll Number</th>
                    <th>Student Name</th>
                    <th>Department</th>
                    <th>CGPA</th>
                    <th>Tests Taken</th>
                    <th>Avg Score</th>
                    <th>Readiness Index</th>
                    <th>Placement Fit</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptStudents" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td><strong><%# Eval("RollNo") %></strong></td>
                            <td><%# Eval("Name") %></td>
                            <td><%# Eval("Department") %></td>
                            <td><%# Eval("CGPA", "{0:F2}") %></td>
                            <td><%# Eval("TestsCompleted") %></td>
                            <td><%# Eval("AvgScore", "{0:F1}") %>%</td>
                            <td><strong><%# Eval("ReadinessIndex", "{0:F0}") %>%</strong></td>
                            <td>
                                <span class='<%# Eval("Status").ToString() == "Strong Fit" ? "badge-fit" : (Eval("Status").ToString() == "On Track" ? "badge-track" : "badge-review") %>'>
                                    <%# Eval("Status") %>
                                </span>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </section>

</div>
</asp:Content>

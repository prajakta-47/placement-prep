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
    <div class="faculty-dashboard-heading" style="margin-bottom:0; flex-wrap:wrap; gap:12px;">
        <div>
            <h1>Student Cohort &amp; Placement Readiness</h1>
            <p>Monitor individual preparation metrics, mock test performance, and placement fit scores</p>
        </div>
        <div style="display:flex; gap:8px; align-items:center;">
            <asp:Button ID="btnExportCsv" runat="server" Text="⇩ Export CSV" OnClick="btnExportCsv_Click" 
                style="height:34px; padding:0 14px; background:#ffffff; color:#334155; border:1px solid #cbd5e1; border-radius:6px; font-size:11px; font-weight:600; cursor:pointer;" />
            <button type="button" onclick="document.getElementById('addStudentModal').style.display='grid'"
                style="height:34px; padding:0 14px; background:var(--fac-teal); color:#ffffff; border:none; border-radius:6px; font-size:11px; font-weight:600; cursor:pointer;">
                ＋ Add Student
            </button>
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
                    <th style="text-align:right;">Action</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptStudents" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td><strong><%# Eval("RollNo") %></strong></td>
                            <td>
                                <div><strong><%# Eval("Name") %></strong></div>
                                <div style="font-size:10px; color:#64748b;"><%# Eval("Email") %></div>
                            </td>
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
                            <td style="text-align:right;">
                                <button type="button" style="padding:4px 10px; border-radius:4px; font-size:10px; font-weight:600; background:#f1f5f9; border:1px solid #cbd5e1; cursor:pointer;"
                                    onclick='alert("Student Dossier:\n\nName: <%# Eval("Name") %>\nRoll No: <%# Eval("RollNo") %>\nCGPA: <%# Eval("CGPA", "{0:F2}") %>\nAvg Mock Score: <%# Eval("AvgScore", "{0:F1}") %>%\nReadiness: <%# Eval("ReadinessIndex", "{0:F0}") %>%\nStatus: <%# Eval("Status") %>");'>
                                    View Profile
                                </button>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </section>

</div>

<!-- Add Student Modal -->
<div id="addStudentModal" style="display:none; position:fixed; top:0; left:0; right:0; bottom:0; background:rgba(15,23,42,0.6); backdrop-filter:blur(4px); z-index:9999; place-items:center; padding:16px;">
    <div style="background:#fff; border-radius:12px; max-width:440px; width:100%; padding:20px; box-shadow:0 10px 25px rgba(0,0,0,0.15);">
        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:14px; border-bottom:1px solid #e2e8f0; padding-bottom:10px;">
            <h3 style="margin:0; font-size:15px; font-weight:700;">Add Student to Cohort</h3>
            <button type="button" onclick="document.getElementById('addStudentModal').style.display='none'" style="border:none; background:none; font-size:20px; cursor:pointer;">&times;</button>
        </div>
        <div style="display:flex; flex-direction:column; gap:10px; font-size:11px;">
            <div>
                <label style="font-weight:600; color:#334155;">Full Name *</label>
                <asp:TextBox ID="txtNewName" runat="server" placeholder="e.g. Diya Sengupta" style="width:100%; padding:8px; border:1px solid #cbd5e1; border-radius:6px; box-sizing:border-box; margin-top:3px;" />
            </div>
            <div>
                <label style="font-weight:600; color:#334155;">Roll Number *</label>
                <asp:TextBox ID="txtNewRoll" runat="server" placeholder="e.g. 24SOECE1120" style="width:100%; padding:8px; border:1px solid #cbd5e1; border-radius:6px; box-sizing:border-box; margin-top:3px;" />
            </div>
            <div>
                <label style="font-weight:600; color:#334155;">Department</label>
                <asp:TextBox ID="txtNewDept" runat="server" Text="Computer Science & Engineering" style="width:100%; padding:8px; border:1px solid #cbd5e1; border-radius:6px; box-sizing:border-box; margin-top:3px;" />
            </div>
            <div style="display:grid; grid-template-columns:1fr 1fr; gap:10px;">
                <div>
                    <label style="font-weight:600; color:#334155;">CGPA</label>
                    <asp:TextBox ID="txtNewCgpa" runat="server" Text="8.5" style="width:100%; padding:8px; border:1px solid #cbd5e1; border-radius:6px; box-sizing:border-box; margin-top:3px;" />
                </div>
                <div>
                    <label style="font-weight:600; color:#334155;">Placement Fit</label>
                    <asp:DropDownList ID="ddlNewStatus" runat="server" style="width:100%; padding:8px; border:1px solid #cbd5e1; border-radius:6px; box-sizing:border-box; margin-top:3px;">
                        <asp:ListItem Value="Strong Fit" Text="Strong Fit" Selected="True" />
                        <asp:ListItem Value="On Track" Text="On Track" />
                        <asp:ListItem Value="Needs Review" Text="Needs Review" />
                    </asp:DropDownList>
                </div>
            </div>
        </div>
        <div style="display:flex; justify-content:flex-end; gap:8px; margin-top:16px; border-top:1px solid #e2e8f0; padding-top:12px;">
            <button type="button" onclick="document.getElementById('addStudentModal').style.display='none'" style="padding:7px 14px; background:#fff; border:1px solid #cbd5e1; border-radius:6px; font-size:11px; cursor:pointer;">Cancel</button>
            <asp:Button ID="btnSaveStudent" runat="server" Text="Save Student" OnClick="btnSaveStudent_Click" style="padding:7px 14px; background:var(--fac-teal); color:#fff; border:none; border-radius:6px; font-size:11px; font-weight:600; cursor:pointer;" />
        </div>
    </div>
</div>
</asp:Content>

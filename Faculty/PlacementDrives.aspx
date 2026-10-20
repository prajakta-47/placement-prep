<%@ Page Title="Placement Drives" Language="C#" MasterPageFile="~/Faculty.Master" AutoEventWireup="true" CodeBehind="PlacementDrives.aspx.cs" Inherits="PlacementPrep.Faculty.PlacementDrives" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <style>
        .drives-header-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 16px;
            margin-bottom: 20px;
        }

        .drives-header-row h1 {
            font-size: 22px;
            font-weight: 800;
            color: #0f172a;
            margin: 0 0 4px;
            letter-spacing: -0.02em;
        }

        .drives-header-row p {
            font-size: 12px;
            color: #64748b;
            margin: 0;
        }

        .filter-toolbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            padding: 12px 16px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        .filter-inputs {
            display: flex;
            align-items: center;
            gap: 10px;
            flex: 1;
            min-width: 280px;
        }

        .toolbar-input {
            padding: 8px 12px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            font-size: 12px;
            font-family: inherit;
            color: #1e293b;
            background: #f8fafc;
        }

        .toolbar-input:focus {
            outline: none;
            border-color: #00685e;
            background: #ffffff;
        }

        .btn-teal {
            background: #00685e;
            color: #ffffff;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: background 0.15s;
        }

        .btn-teal:hover {
            background: #00534b;
        }

        /* Drive Card Grid */
        .drives-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 20px;
        }

        .drive-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 18px 20px;
            display: flex;
            flex-direction: column;
            gap: 12px;
            transition: all 0.2s ease;
            box-shadow: 0 1px 3px rgba(0,0,0,0.03);
            position: relative;
        }

        .drive-card:hover {
            border-color: #cbd5e1;
            box-shadow: 0 4px 12px rgba(0,0,0,0.06);
            transform: translateY(-2px);
        }

        .drive-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .drive-id-tag {
            font-size: 10px;
            font-weight: 700;
            padding: 3px 8px;
            border-radius: 4px;
            background: #f1f5f9;
            color: #475569;
            letter-spacing: 0.03em;
        }

        .drive-badge {
            font-size: 10px;
            font-weight: 700;
            padding: 3px 8px;
            border-radius: 4px;
        }

        .badge-scheduled { background: #e6f9f5; color: #00685e; }
        .badge-progress { background: #e0f2fe; color: #0369a1; }
        .badge-completed { background: #f1f5f9; color: #64748b; }

        .drive-title-area h3 {
            margin: 0 0 4px;
            font-size: 16px;
            font-weight: 700;
            color: #0f172a;
        }

        .drive-title-area p {
            margin: 0;
            font-size: 12px;
            color: #64748b;
        }

        .drive-details-list {
            display: flex;
            flex-direction: column;
            gap: 6px;
            font-size: 11px;
            color: #334155;
            background: #f8fafc;
            padding: 10px 12px;
            border-radius: 8px;
            border: 1px solid #f1f5f9;
        }

        .drive-detail-row {
            display: flex;
            justify-content: space-between;
        }

        .drive-detail-label {
            color: #64748b;
        }

        .drive-detail-val {
            font-weight: 600;
        }

        .drive-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 10px;
            border-top: 1px solid #f1f5f9;
            margin-top: auto;
        }

        .drive-actions {
            display: flex;
            gap: 6px;
        }

        .btn-action {
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 11px;
            font-weight: 600;
            cursor: pointer;
            border: 1px solid transparent;
            transition: all 0.15s;
        }

        .btn-edit {
            background: #f1f5f9;
            color: #1e293b;
            border-color: #e2e8f0;
        }

        .btn-edit:hover {
            background: #e2e8f0;
        }

        .btn-delete {
            background: #fff;
            color: #ef4444;
            border-color: #fecaca;
        }

        .btn-delete:hover {
            background: #fef2f2;
        }

        /* Modal Styles */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(15, 23, 42, 0.6);
            backdrop-filter: blur(4px);
            z-index: 9999;
            display: none;
            place-items: center;
            padding: 16px;
        }

        .modal-overlay.show {
            display: grid;
        }

        .modal-card {
            background: #ffffff;
            border-radius: 14px;
            width: 100%;
            max-width: 520px;
            box-shadow: 0 20px 25px -5px rgba(0,0,0,0.1), 0 10px 10px -5px rgba(0,0,0,0.04);
            overflow: hidden;
            animation: modalPop 0.15s ease-out;
        }

        @keyframes modalPop {
            from { transform: scale(0.96); opacity: 0; }
            to { transform: scale(1); opacity: 1; }
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px 20px;
            border-bottom: 1px solid #e2e8f0;
            background: #f8fafc;
        }

        .modal-header h3 {
            margin: 0;
            font-size: 15px;
            font-weight: 700;
            color: #0f172a;
        }

        .modal-close {
            background: none;
            border: none;
            font-size: 20px;
            line-height: 1;
            color: #64748b;
            cursor: pointer;
        }

        .modal-body {
            padding: 20px;
            display: flex;
            flex-direction: column;
            gap: 14px;
            max-height: 75vh;
            overflow-y: auto;
        }

        .modal-footer {
            padding: 14px 20px;
            border-top: 1px solid #e2e8f0;
            background: #f8fafc;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        .btn-cancel {
            padding: 8px 16px;
            border-radius: 6px;
            background: #ffffff;
            color: #475569;
            border: 1px solid #cbd5e1;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
        }

        /* Success Alert */
        .alert-banner {
            background: #ecfdf5;
            border: 1px solid #a7f3d0;
            color: #065f46;
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 18px;
            font-size: 12px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
        }
    </style>
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="faculty-dashboard" style="display:flex; flex-direction:column; gap:0;">

    <!-- Page Header -->
    <div class="drives-header-row">
        <div>
            <h1>Placement Drives &amp; Assessment Schedule</h1>
            <p>Create and manage campus recruitment drives, test timings, venue coordination, and batch eligibility rosters</p>
        </div>
        <div>
            <button type="button" class="btn-teal" onclick="openCreateModal()">
                <span>＋</span> New Placement Drive
            </button>
        </div>
    </div>

    <!-- Alert Message -->
    <asp:Panel ID="pnlDriveAlert" runat="server" Visible="false" CssClass="alert-banner">
        <svg viewBox="0 0 24 24" style="width:16px;height:16px;fill:none;stroke:#059669;stroke-width:2;">
            <path d="M20 6 9 17l-5-5" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
        <asp:Literal ID="litDriveAlert" runat="server" />
    </asp:Panel>

    <!-- Toolbar / Search / Filter -->
    <div class="filter-toolbar">
        <div class="filter-inputs">
            <asp:TextBox ID="txtSearchDrives" runat="server" placeholder="Search by company or job role..." CssClass="toolbar-input" style="flex:1;" />
            <asp:DropDownList ID="ddlStatusFilter" runat="server" CssClass="toolbar-input">
                <asp:ListItem Value="ALL" Text="All Statuses" Selected="True" />
                <asp:ListItem Value="Scheduled" Text="Scheduled" />
                <asp:ListItem Value="In Progress" Text="In Progress" />
                <asp:ListItem Value="Completed" Text="Completed" />
            </asp:DropDownList>
            <asp:Button ID="btnFilterDrives" runat="server" Text="Filter" CssClass="btn-teal" OnClick="btnFilterDrives_Click" />
        </div>
        <div>
            <span style="font-size:11px; font-weight:700; color:#00685e; background:#e6f9f5; padding:5px 12px; border-radius:20px;">
                Active Drives: <asp:Literal ID="litDriveCount" runat="server" />
            </span>
        </div>
    </div>

    <!-- Drives Grid (Cards) -->
    <div class="drives-grid">
        <asp:Repeater ID="rptDrives" runat="server" OnItemCommand="rptDrives_ItemCommand">
            <ItemTemplate>
                <div class="drive-card">
                    <div class="drive-top">
                        <span class="drive-id-tag"><%# Eval("DriveId") %></span>
                        <span class='drive-badge <%# Eval("Status").ToString() == "Scheduled" ? "badge-scheduled" : (Eval("Status").ToString() == "In Progress" ? "badge-progress" : "badge-completed") %>'>
                            <%# Eval("Status") %>
                        </span>
                    </div>

                    <div class="drive-title-area">
                        <div style="display:flex; justify-content:space-between; align-items:flex-start; gap:8px;">
                            <h3 style="margin:0;"><%# Eval("CompanyName") %></h3>
                            <span class="faculty-tag" style="background:#eef2ff; color:#4338ca; font-size:10px;"><%# Eval("Industry") ?? "IT Services" %></span>
                        </div>
                        <p style="margin-top:4px;"><%# Eval("JobTitle") %></p>
                    </div>

                    <div class="drive-details-list">
                        <div class="drive-detail-row">
                            <span class="drive-detail-label">💰 CTC Package:</span>
                            <span class="drive-detail-val" style="color:var(--fac-teal); font-weight:700;"><%# Eval("PackageLPA", "{0:F1}") %> LPA</span>
                        </div>
                        <div class="drive-detail-row">
                            <span class="drive-detail-label">📅 Date:</span>
                            <span class="drive-detail-val"><%# Eval("EventDate") %></span>
                        </div>
                        <div class="drive-detail-row">
                            <span class="drive-detail-label">⏰ Window:</span>
                            <span class="drive-detail-val"><%# Eval("TimeWindow") %></span>
                        </div>
                        <div class="drive-detail-row">
                            <span class="drive-detail-label">📍 Venue:</span>
                            <span class="drive-detail-val"><%# Eval("Location") %></span>
                        </div>
                        <div class="drive-detail-row">
                            <span class="drive-detail-label">🎓 Eligible Dept:</span>
                            <span class="drive-detail-val"><%# Eval("EligibleDept") ?? "CSE, IT, ECE" %></span>
                        </div>
                        <div class="drive-detail-row">
                            <span class="drive-detail-label">📊 Min CGPA:</span>
                            <span class="drive-detail-val"><%# Eval("MinCgpa", "{0:F1}") ?? "6.5" %></span>
                        </div>
                    </div>

                    <div class="drive-footer">
                        <div style="font-size:11px; font-weight:600; color:var(--fac-teal);">
                            <span>👥 <%# Eval("RegisteredStudents") %> Candidates</span>
                        </div>
                        <div class="drive-actions">
                            <a href='Companies.aspx?q=<%# Server.UrlEncode((string)Eval("CompanyName")) %>' class="btn-action" style="text-decoration:none; display:inline-flex; align-items:center;" title="View in Corporate Partner Directory">
                                🏢 Partner
                            </a>
                            <button type="button" class="btn-action btn-edit" 
                                onclick='openEditModal("<%# Eval("DriveId") %>", "<%# Eval("CompanyName") %>", "<%# Eval("JobTitle") %>", "<%# Eval("EventDate") %>", "<%# Eval("TimeWindow") %>", "<%# Eval("Location") %>", "<%# Eval("Status") %>", "<%# Eval("RegisteredStudents") %>", "<%# Eval("EligibleDept") %>", "<%# Eval("MinCgpa") %>", "<%# Eval("PackageLPA") %>", "<%# Eval("Industry") %>")'>
                                ✎ Edit
                            </button>
                            <asp:Button ID="btnDelete" runat="server" Text="✕ Delete" 
                                CssClass="btn-action btn-delete" 
                                CommandName="DeleteDrive" 
                                CommandArgument='<%# Eval("DriveId") %>' 
                                OnClientClick="return confirm('Are you sure you want to delete this placement drive?');" />
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

</div>

<!-- CREATE / EDIT MODAL -->
<div class="modal-overlay" id="driveModal">
    <div class="modal-card">
        <div class="modal-header">
            <h3 id="modalTitle">Create New Placement Drive</h3>
            <button type="button" class="modal-close" onclick="closeDriveModal()">&times;</button>
        </div>
        <div class="modal-body">
            <asp:HiddenField ID="hfDriveId" runat="server" />

            <div style="display:flex; flex-direction:column; gap:4px;">
                <label style="font-size:11px; font-weight:600; color:#334155;">Company Name *</label>
                <asp:TextBox ID="txtModalCompany" runat="server" CssClass="toolbar-input" placeholder="e.g. Google, Microsoft, TCS..." />
            </div>

            <div style="display:flex; flex-direction:column; gap:4px;">
                <label style="font-size:11px; font-weight:600; color:#334155;">Job Role / Title *</label>
                <asp:TextBox ID="txtModalRole" runat="server" CssClass="toolbar-input" placeholder="e.g. SDE-1, Graduate Engineer Trainee..." />
            </div>

            <div style="display:grid; grid-template-columns:1fr 1fr; gap:12px;">
                <div style="display:flex; flex-direction:column; gap:4px;">
                    <label style="font-size:11px; font-weight:600; color:#334155;">Package Offered (LPA) *</label>
                    <asp:TextBox ID="txtModalPackage" runat="server" CssClass="toolbar-input" placeholder="e.g. 7.5" Text="6.5" />
                </div>
                <div style="display:flex; flex-direction:column; gap:4px;">
                    <label style="font-size:11px; font-weight:600; color:#334155;">Industry / Sector</label>
                    <asp:TextBox ID="txtModalIndustry" runat="server" CssClass="toolbar-input" placeholder="e.g. IT Services, Cloud, FinTech" Text="IT Services" />
                </div>
            </div>

            <div style="display:grid; grid-template-columns:1fr 1fr; gap:12px;">
                <div style="display:flex; flex-direction:column; gap:4px;">
                    <label style="font-size:11px; font-weight:600; color:#334155;">Event Date *</label>
                    <asp:TextBox ID="txtModalDate" runat="server" CssClass="toolbar-input" placeholder="e.g. Oct 24, 2026" />
                </div>
                <div style="display:flex; flex-direction:column; gap:4px;">
                    <label style="font-size:11px; font-weight:600; color:#334155;">Time Window *</label>
                    <asp:TextBox ID="txtModalTime" runat="server" CssClass="toolbar-input" placeholder="e.g. 10:00 AM - 01:00 PM" />
                </div>
            </div>

            <div style="display:flex; flex-direction:column; gap:4px;">
                <label style="font-size:11px; font-weight:600; color:#334155;">Venue / Location *</label>
                <asp:TextBox ID="txtModalLocation" runat="server" CssClass="toolbar-input" placeholder="e.g. Lab 3 & 4, Main CS Block" />
            </div>

            <div style="display:grid; grid-template-columns:1fr 1fr; gap:12px;">
                <div style="display:flex; flex-direction:column; gap:4px;">
                    <label style="font-size:11px; font-weight:600; color:#334155;">Drive Status</label>
                    <asp:DropDownList ID="ddlModalStatus" runat="server" CssClass="toolbar-input">
                        <asp:ListItem Value="Scheduled" Text="Scheduled" Selected="True" />
                        <asp:ListItem Value="In Progress" Text="In Progress" />
                        <asp:ListItem Value="Completed" Text="Completed" />
                    </asp:DropDownList>
                </div>
                <div style="display:flex; flex-direction:column; gap:4px;">
                    <label style="font-size:11px; font-weight:600; color:#334155;">Registered Students</label>
                    <asp:TextBox ID="txtModalStudents" runat="server" CssClass="toolbar-input" Text="50" TextMode="Number" />
                </div>
            </div>

            <div style="display:grid; grid-template-columns:1fr 1fr; gap:12px;">
                <div style="display:flex; flex-direction:column; gap:4px;">
                    <label style="font-size:11px; font-weight:600; color:#334155;">Eligible Departments</label>
                    <asp:TextBox ID="txtModalDept" runat="server" CssClass="toolbar-input" placeholder="e.g. CSE, IT, ECE" Text="CSE, IT" />
                </div>
                <div style="display:flex; flex-direction:column; gap:4px;">
                    <label style="font-size:11px; font-weight:600; color:#334155;">Minimum CGPA</label>
                    <asp:TextBox ID="txtModalCgpa" runat="server" CssClass="toolbar-input" placeholder="7.0" Text="7.0" />
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn-cancel" onclick="closeDriveModal()">Cancel</button>
            <asp:Button ID="btnSaveDrive" runat="server" Text="Save Placement Drive" CssClass="btn-teal" OnClick="btnSaveDrive_Click" />
        </div>
    </div>
</div>

<script>
    function openCreateModal() {
        document.getElementById('<%= hfDriveId.ClientID %>').value = '';
        document.getElementById('modalTitle').innerText = 'Create New Placement Drive';
        document.getElementById('<%= txtModalCompany.ClientID %>').value = '';
        document.getElementById('<%= txtModalRole.ClientID %>').value = '';
        document.getElementById('<%= txtModalPackage.ClientID %>').value = '6.5';
        document.getElementById('<%= txtModalIndustry.ClientID %>').value = 'IT Services';
        document.getElementById('<%= txtModalDate.ClientID %>').value = '';
        document.getElementById('<%= txtModalTime.ClientID %>').value = '10:00 AM - 01:00 PM';
        document.getElementById('<%= txtModalLocation.ClientID %>').value = 'Campus Lab 3';
        document.getElementById('<%= ddlModalStatus.ClientID %>').value = 'Scheduled';
        document.getElementById('<%= txtModalStudents.ClientID %>').value = '50';
        document.getElementById('<%= txtModalDept.ClientID %>').value = 'CSE, IT';
        document.getElementById('<%= txtModalCgpa.ClientID %>').value = '7.0';
        document.getElementById('driveModal').classList.add('show');
    }

    function openEditModal(id, company, role, date, time, location, status, students, dept, cgpa, packageLpa, industry) {
        document.getElementById('<%= hfDriveId.ClientID %>').value = id;
        document.getElementById('modalTitle').innerText = 'Edit Placement Drive (' + id + ')';
        document.getElementById('<%= txtModalCompany.ClientID %>').value = company || '';
        document.getElementById('<%= txtModalRole.ClientID %>').value = role || '';
        document.getElementById('<%= txtModalPackage.ClientID %>').value = packageLpa || '6.5';
        document.getElementById('<%= txtModalIndustry.ClientID %>').value = industry || 'IT Services';
        document.getElementById('<%= txtModalDate.ClientID %>').value = date || '';
        document.getElementById('<%= txtModalTime.ClientID %>').value = time || '';
        document.getElementById('<%= txtModalLocation.ClientID %>').value = location || '';
        document.getElementById('<%= ddlModalStatus.ClientID %>').value = status || 'Scheduled';
        document.getElementById('<%= txtModalStudents.ClientID %>').value = students || '0';
        document.getElementById('<%= txtModalDept.ClientID %>').value = dept || 'CSE, IT';
        document.getElementById('<%= txtModalCgpa.ClientID %>').value = cgpa || '7.0';
        document.getElementById('driveModal').classList.add('show');
    }

    function closeDriveModal() {
        document.getElementById('driveModal').classList.remove('show');
    }

    window.addEventListener('load', function() {
        var params = new URLSearchParams(window.location.search);
        if (params.get('action') === 'new') {
            openCreateModal();
        }
    });
</script>
</asp:Content>

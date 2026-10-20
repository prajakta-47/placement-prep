<%@ Page Title="Companies" Language="C#" MasterPageFile="~/Faculty.Master" AutoEventWireup="true" CodeBehind="Companies.aspx.cs" Inherits="PlacementPrep.Faculty.Companies" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <style>
        .companies-header-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 16px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        .companies-header-row h1 {
            font-size: 22px;
            font-weight: 800;
            color: #0f172a;
            margin: 0 0 4px;
            letter-spacing: -0.02em;
        }

        .companies-header-row p {
            font-size: 12px;
            color: #64748b;
            margin: 0;
        }

        .kpi-metric-strip {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(210px, 1fr));
            gap: 14px;
            margin-bottom: 20px;
        }

        .kpi-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            padding: 14px 18px;
            display: flex;
            align-items: center;
            gap: 14px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.03);
        }

        .kpi-icon {
            width: 40px;
            height: 40px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            flex-shrink: 0;
        }

        .kpi-val {
            font-size: 20px;
            font-weight: 800;
            color: #0f172a;
            line-height: 1.1;
        }

        .kpi-lbl {
            font-size: 11px;
            font-weight: 600;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.04em;
            margin-top: 2px;
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
            box-shadow: 0 0 0 3px rgba(0, 104, 94, 0.1);
        }

        .btn-teal {
            background: #00685e;
            color: #ffffff;
            border: none;
            border-radius: 6px;
            padding: 8px 16px;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: all 0.15s ease;
            text-decoration: none;
        }

        .btn-teal:hover {
            background: #005048;
        }

        .btn-outline {
            background: #ffffff;
            color: #00685e;
            border: 1px solid #00685e;
            border-radius: 6px;
            padding: 8px 14px;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-outline:hover {
            background: #f0fdfa;
        }

        .fac-company-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            padding: 18px;
            display: flex;
            flex-direction: column;
            gap: 12px;
            transition: all 0.2s ease;
            box-shadow: 0 1px 3px rgba(0,0,0,0.03);
        }

        .fac-company-card:hover {
            box-shadow: 0 8px 16px rgba(0,0,0,0.06);
            border-color: #cbd5e1;
            transform: translateY(-2px);
        }

        .badge-active {
            background: #e6f9f5;
            color: #00685e;
            border: 1px solid rgba(0, 104, 94, 0.2);
        }

        .badge-upcoming {
            background: #eff6ff;
            color: #1d4ed8;
            border: 1px solid rgba(29, 78, 216, 0.2);
        }

        .badge-completed {
            background: #f1f5f9;
            color: #475569;
            border: 1px solid #cbd5e1;
        }

        .company-actions {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 8px;
            padding-top: 10px;
            border-top: 1px solid #f1f5f9;
        }

        .btn-action-link {
            font-size: 11px;
            font-weight: 600;
            padding: 5px 10px;
            border-radius: 4px;
            text-decoration: none;
            cursor: pointer;
            border: 1px solid #cbd5e1;
            background: #f8fafc;
            color: #334155;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }

        .btn-action-link:hover {
            background: #e2e8f0;
        }

        .btn-action-delete {
            font-size: 11px;
            font-weight: 600;
            padding: 5px 10px;
            border-radius: 4px;
            cursor: pointer;
            border: 1px solid #fecaca;
            background: #fff5f5;
            color: #dc2626;
        }

        .btn-action-delete:hover {
            background: #fee2e2;
        }

        .alert-banner {
            padding: 12px 16px;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 500;
            margin-bottom: 16px;
        }

        .alert-success {
            background: #f0fdf4;
            border: 1px solid #bbf7d0;
            color: #15803d;
        }

        .alert-error {
            background: #fef2f2;
            border: 1px solid #fecaca;
            color: #b91c1c;
        }

        /* Modal */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            background: rgba(15, 23, 42, 0.45);
            backdrop-filter: blur(2px);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 9999;
        }

        .modal-overlay.show {
            display: flex;
        }

        .modal-card {
            background: #ffffff;
            border-radius: 12px;
            width: 90%;
            max-width: 520px;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            display: flex;
            flex-direction: column;
            animation: modalPop 0.18s ease-out;
        }

        @keyframes modalPop {
            from { transform: scale(0.96); opacity: 0; }
            to { transform: scale(1); opacity: 1; }
        }

        .modal-header {
            padding: 16px 20px;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-header h3 {
            font-size: 15px;
            font-weight: 700;
            color: #0f172a;
            margin: 0;
        }

        .modal-close {
            background: transparent;
            border: none;
            font-size: 20px;
            color: #64748b;
            cursor: pointer;
            line-height: 1;
        }

        .modal-body {
            padding: 20px;
            display: flex;
            flex-direction: column;
            gap: 12px;
            max-height: 75vh;
            overflow-y: auto;
        }

        .modal-footer {
            padding: 12px 20px;
            background: #f8fafc;
            border-top: 1px solid #e2e8f0;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        .btn-cancel {
            background: #ffffff;
            border: 1px solid #cbd5e1;
            color: #475569;
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
        }
    </style>
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="faculty-dashboard" style="display:flex; flex-direction:column; gap:0;">

    <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert-banner">
        <asp:Literal ID="litAlert" runat="server" />
    </asp:Panel>

    <!-- Header Row -->
    <div class="companies-header-row">
        <div>
            <h1>Corporate Partner Directory &amp; Campus Drives</h1>
            <p>Hiring criteria, compensation tiers, and scheduled recruitment drives synchronized in real time</p>
        </div>
        <div style="display:flex; gap:10px;">
            <a href="PlacementDrives.aspx" class="btn-outline">
                📅 Placement Drives Schedule
            </a>
            <button type="button" class="btn-teal" onclick="openCompanyModal()">
                <span>＋</span> Add Corporate Partner &amp; Drive
            </button>
        </div>
    </div>

    <!-- KPI Metric Strip -->
    <div class="kpi-metric-strip">
        <div class="kpi-card">
            <div class="kpi-icon" style="background:#e6f9f5; color:#00685e;">🏢</div>
            <div>
                <div class="kpi-val"><asp:Literal ID="litKpiTotalPartners" runat="server" Text="0" /></div>
                <div class="kpi-lbl">Corporate Partners</div>
            </div>
        </div>
        <div class="kpi-card">
            <div class="kpi-icon" style="background:#eff6ff; color:#2563eb;">🚀</div>
            <div>
                <div class="kpi-val"><asp:Literal ID="litKpiActiveDrives" runat="server" Text="0" /></div>
                <div class="kpi-lbl">Active Drives</div>
            </div>
        </div>
        <div class="kpi-card">
            <div class="kpi-icon" style="background:#fef3c7; color:#d97706;">💰</div>
            <div>
                <div class="kpi-val"><asp:Literal ID="litKpiMaxPackage" runat="server" Text="0 LPA" /></div>
                <div class="kpi-lbl">Highest Package</div>
            </div>
        </div>
        <div class="kpi-card">
            <div class="kpi-icon" style="background:#f3e8ff; color:#7e22ce;">🎓</div>
            <div>
                <div class="kpi-val"><asp:Literal ID="litKpiAvgCgpa" runat="server" Text="0.0" /></div>
                <div class="kpi-lbl">Average Min CGPA</div>
            </div>
        </div>
    </div>

    <!-- Filter & Search Toolbar -->
    <div class="filter-toolbar">
        <div class="filter-inputs">
            <asp:TextBox ID="txtSearchCompany" runat="server" CssClass="toolbar-input" placeholder="Search partner by company, role, or sector..." style="flex:1;" />
            <asp:DropDownList ID="ddlStatusFilter" runat="server" CssClass="toolbar-input">
                <asp:ListItem Value="ALL" Text="All Drive Statuses" Selected="True" />
                <asp:ListItem Value="Active" Text="Active Drives" />
                <asp:ListItem Value="Upcoming" Text="Upcoming Drives" />
                <asp:ListItem Value="Completed" Text="Completed" />
            </asp:DropDownList>
            <asp:Button ID="btnFilter" runat="server" Text="Filter" CssClass="btn-teal" OnClick="btnFilter_Click" />
        </div>
        <div style="font-size:12px; font-weight:600; color:#64748b;">
            Showing <span style="color:#00685e;"><asp:Literal ID="litTotalCount" runat="server" Text="0" /></span> Registered Partners
        </div>
    </div>

    <!-- Companies & Drives Cards Grid -->
    <div style="display:grid; grid-template-columns:repeat(auto-fill, minmax(310px, 1fr)); gap:16px;">
        <asp:Repeater ID="rptCompanies" runat="server" OnItemCommand="rptCompanies_ItemCommand">
            <ItemTemplate>
                <div class="fac-company-card">
                    <div style="display:flex; justify-content:space-between; align-items:flex-start; gap:8px;">
                        <div>
                            <h3 style="margin:0; font-size:15px; font-weight:800; color:#0f172a;"><%# Eval("CompanyName") %></h3>
                            <span style="font-size:11px; color:#475569;"><%# Eval("Industry") %></span>
                        </div>
                        <span class='faculty-tag <%# Eval("Status").ToString() == "Active" ? "badge-active" : (Eval("Status").ToString() == "Upcoming" ? "badge-upcoming" : "badge-completed") %>'>
                            <%# Eval("Status") %>
                        </span>
                    </div>

                    <div style="background:#f8fafc; border:1px solid #f1f5f9; border-radius:6px; padding:10px; font-size:11px; display:flex; flex-direction:column; gap:5px;">
                        <div><strong>Target Role:</strong> <span style="color:#0f172a;"><%# Eval("Role") %></span></div>
                        <div><strong>Drive Execution Date:</strong> <span style="color:#0f172a;"><%# Eval("DriveDate") %></span></div>
                        <div><strong>Cutoff Benchmark:</strong> <span style="color:#0f172a;"><%# Eval("MinCgpa", "{0:F2}") %> CGPA</span></div>
                    </div>

                    <div style="display:flex; justify-content:space-between; align-items:center; font-size:11px;">
                        <span>CTC: <strong style="color:#00685e; font-size:13px;"><%# Eval("PackageLPA", "{0:F1}") %> LPA</strong></span>
                        <span>Eligible: <strong><%# Eval("EligibleCount") %> Candidates</strong></span>
                    </div>

                    <div class="company-actions">
                        <a href='PlacementDrives.aspx?q=<%# Server.UrlEncode((string)Eval("CompanyName")) %>' class="btn-action-link" title="Open Placement Drive & Assessment Schedule">
                            📅 Drive Schedule
                        </a>
                        <asp:Button ID="btnDeleteCompany" runat="server" Text="✕ Remove" 
                            CssClass="btn-action-delete"
                            CommandName="DeleteCompany"
                            CommandArgument='<%# Eval("CompanyName") %>'
                            OnClientClick="return confirm('Are you sure you want to remove this corporate partner and its placement schedule?');" />
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

</div>

<!-- ADD CORPORATE PARTNER MODAL -->
<div class="modal-overlay" id="companyModal">
    <div class="modal-card">
        <div class="modal-header">
            <h3>Add Corporate Partner &amp; Campus Drive</h3>
            <button type="button" class="modal-close" onclick="closeCompanyModal()">&times;</button>
        </div>
        <div class="modal-body">
            <div style="display:flex; flex-direction:column; gap:4px;">
                <label style="font-size:11px; font-weight:600; color:#334155;">Corporate Partner Name *</label>
                <asp:TextBox ID="txtModalName" runat="server" CssClass="toolbar-input" placeholder="e.g. Google India, Microsoft, TCS..." />
            </div>

            <div style="display:grid; grid-template-columns:1fr 1fr; gap:12px;">
                <div style="display:flex; flex-direction:column; gap:4px;">
                    <label style="font-size:11px; font-weight:600; color:#334155;">Industry / Sector *</label>
                    <asp:TextBox ID="txtModalIndustry" runat="server" CssClass="toolbar-input" placeholder="e.g. IT Services, Cloud, FinTech" Text="IT Services" />
                </div>
                <div style="display:flex; flex-direction:column; gap:4px;">
                    <label style="font-size:11px; font-weight:600; color:#334155;">Job Role / Title *</label>
                    <asp:TextBox ID="txtModalRole" runat="server" CssClass="toolbar-input" placeholder="e.g. SDE-1, Software Engineer" Text="Software Engineer" />
                </div>
            </div>

            <div style="display:grid; grid-template-columns:1fr 1fr; gap:12px;">
                <div style="display:flex; flex-direction:column; gap:4px;">
                    <label style="font-size:11px; font-weight:600; color:#334155;">CTC Package (LPA) *</label>
                    <asp:TextBox ID="txtModalPackage" runat="server" CssClass="toolbar-input" placeholder="e.g. 8.5" Text="7.5" />
                </div>
                <div style="display:flex; flex-direction:column; gap:4px;">
                    <label style="font-size:11px; font-weight:600; color:#334155;">Min CGPA Cutoff</label>
                    <asp:TextBox ID="txtModalCgpa" runat="server" CssClass="toolbar-input" placeholder="e.g. 7.0" Text="7.0" />
                </div>
            </div>

            <div style="display:grid; grid-template-columns:1fr 1fr; gap:12px;">
                <div style="display:flex; flex-direction:column; gap:4px;">
                    <label style="font-size:11px; font-weight:600; color:#334155;">Scheduled Drive Date *</label>
                    <asp:TextBox ID="txtModalDate" runat="server" CssClass="toolbar-input" placeholder="e.g. Nov 24, 2026" />
                </div>
                <div style="display:flex; flex-direction:column; gap:4px;">
                    <label style="font-size:11px; font-weight:600; color:#334155;">Recruitment Status</label>
                    <asp:DropDownList ID="ddlModalStatus" runat="server" CssClass="toolbar-input">
                        <asp:ListItem Value="Upcoming" Text="Upcoming Drive" Selected="True" />
                        <asp:ListItem Value="Active" Text="Active Drive" />
                        <asp:ListItem Value="Completed" Text="Completed" />
                    </asp:DropDownList>
                </div>
            </div>

            <div style="display:flex; flex-direction:column; gap:4px;">
                <label style="font-size:11px; font-weight:600; color:#334155;">Estimated Eligible Students</label>
                <asp:TextBox ID="txtModalEligible" runat="server" CssClass="toolbar-input" placeholder="e.g. 60" Text="50" TextMode="Number" />
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn-cancel" onclick="closeCompanyModal()">Cancel</button>
            <asp:Button ID="btnSaveCompany" runat="server" Text="Save Corporate Partner & Drive" CssClass="btn-teal" OnClick="btnSaveCompany_Click" />
        </div>
    </div>
</div>

<script>
    function openCompanyModal() {
        document.getElementById('<%= txtModalName.ClientID %>').value = '';
        document.getElementById('<%= txtModalIndustry.ClientID %>').value = 'IT Services';
        document.getElementById('<%= txtModalRole.ClientID %>').value = 'Software Engineer';
        document.getElementById('<%= txtModalPackage.ClientID %>').value = '7.5';
        document.getElementById('<%= txtModalCgpa.ClientID %>').value = '7.0';
        document.getElementById('<%= txtModalDate.ClientID %>').value = '';
        document.getElementById('<%= ddlModalStatus.ClientID %>').value = 'Upcoming';
        document.getElementById('<%= txtModalEligible.ClientID %>').value = '50';
        document.getElementById('companyModal').classList.add('show');
    }

    function closeCompanyModal() {
        document.getElementById('companyModal').classList.remove('show');
    }
</script>
</asp:Content>

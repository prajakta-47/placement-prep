<%@ Page Title="Announcements" Language="C#" MasterPageFile="~/Faculty.Master" AutoEventWireup="true" CodeBehind="Announcements.aspx.cs" Inherits="PlacementPrep.Faculty.Announcements" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <style>
        .ann-header-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 16px;
            margin-bottom: 20px;
        }

        .ann-header-row h1 {
            font-size: 22px;
            font-weight: 800;
            color: #0f172a;
            margin: 0 0 4px;
            letter-spacing: -0.02em;
        }

        .ann-header-row p {
            font-size: 12px;
            color: #64748b;
            margin: 0;
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

        .ann-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 16px;
            display: flex;
            flex-direction: column;
            gap: 10px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.03);
        }

        .ann-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .ann-badge-urgent {
            background: #fee2e2;
            color: #991b1b;
            font-size: 10px;
            font-weight: 700;
            padding: 3px 8px;
            border-radius: 4px;
        }

        .ann-badge-normal {
            background: #e0f2fe;
            color: #0369a1;
            font-size: 10px;
            font-weight: 700;
            padding: 3px 8px;
            border-radius: 4px;
        }

        .ann-title {
            margin: 0;
            font-size: 15px;
            font-weight: 700;
            color: #0f172a;
        }

        .ann-content {
            font-size: 12px;
            color: #334155;
            line-height: 1.5;
            margin: 0;
        }

        .ann-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 11px;
            color: #64748b;
            padding-top: 10px;
            border-top: 1px solid #f1f5f9;
        }

        /* Modal */
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
            max-width: 500px;
            box-shadow: 0 20px 25px -5px rgba(0,0,0,0.1);
            overflow: hidden;
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
            color: #64748b;
            cursor: pointer;
        }

        .modal-body {
            padding: 20px;
            display: flex;
            flex-direction: column;
            gap: 14px;
        }

        .modal-footer {
            padding: 14px 20px;
            border-top: 1px solid #e2e8f0;
            background: #f8fafc;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        .form-input {
            width: 100%;
            padding: 9px 12px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            font-size: 12px;
            box-sizing: border-box;
            background: #f8fafc;
        }

        .form-input:focus {
            outline: none;
            border-color: #00685e;
            background: #fff;
        }

        .alert-box {
            background: #ecfdf5;
            border: 1px solid #a7f3d0;
            color: #065f46;
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 16px;
            font-size: 12px;
            font-weight: 600;
        }
    </style>
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="faculty-dashboard" style="display:flex; flex-direction:column; gap:0;">

    <div class="ann-header-row">
        <div>
            <h1>Cohort Announcements &amp; Broadcasts</h1>
            <p>Publish test notices, resume compliance reminders, and company drive updates directly to student dashboards</p>
        </div>
        <div>
            <button type="button" class="btn-teal" onclick="document.getElementById('annModal').classList.add('show')">
                <span>＋</span> Post Announcement
            </button>
        </div>
    </div>

    <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert-box">
        <asp:Literal ID="litAlert" runat="server" />
    </asp:Panel>

    <div style="display:flex; flex-direction:column; gap:16px;">
        <asp:Repeater ID="rptAnnouncements" runat="server">
            <ItemTemplate>
                <div class="ann-card">
                    <div class="ann-top">
                        <span class='<%# Eval("Priority").ToString() == "High" ? "ann-badge-urgent" : "ann-badge-normal" %>'>
                            <%# Eval("Priority") %> Priority
                        </span>
                        <span style="font-size:11px; color:#64748b;"><%# Eval("PostedDate", "{0:MMM dd, yyyy • hh:mm tt}") %></span>
                    </div>
                    <h3 class="ann-title"><%# Eval("Title") %></h3>
                    <p class="ann-content"><%# Eval("Content") %></p>
                    <div class="ann-meta">
                        <span>Audience: <strong><%# Eval("TargetCohort") %></strong></span>
                        <span>Author: <strong><%# Eval("Author") %></strong></span>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

</div>

<!-- Modal -->
<div class="modal-overlay" id="annModal">
    <div class="modal-card">
        <div class="modal-header">
            <h3>Publish Cohort Announcement</h3>
            <button type="button" class="modal-close" onclick="document.getElementById('annModal').classList.remove('show')">&times;</button>
        </div>
        <div class="modal-body">
            <div style="display:flex; flex-direction:column; gap:4px;">
                <label style="font-size:11px; font-weight:600; color:#334155;">Announcement Title *</label>
                <asp:TextBox ID="txtTitle" runat="server" CssClass="form-input" placeholder="e.g. Accenture Technical Screening Mandatory Instructions" />
            </div>

            <div style="display:grid; grid-template-columns:1fr 1fr; gap:12px;">
                <div style="display:flex; flex-direction:column; gap:4px;">
                    <label style="font-size:11px; font-weight:600; color:#334155;">Priority</label>
                    <asp:DropDownList ID="ddlPriority" runat="server" CssClass="form-input">
                        <asp:ListItem Value="Normal" Text="Normal Priority" Selected="True" />
                        <asp:ListItem Value="High" Text="High / Urgent" />
                    </asp:DropDownList>
                </div>
                <div style="display:flex; flex-direction:column; gap:4px;">
                    <label style="font-size:11px; font-weight:600; color:#334155;">Target Cohort</label>
                    <asp:TextBox ID="txtCohort" runat="server" CssClass="form-input" Text="B.Tech Final Year (Batch 2025)" />
                </div>
            </div>

            <div style="display:flex; flex-direction:column; gap:4px;">
                <label style="font-size:11px; font-weight:600; color:#334155;">Message Content *</label>
                <asp:TextBox ID="txtContent" runat="server" CssClass="form-input" TextMode="MultiLine" Rows="4" placeholder="Type notice details here..." />
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn-cancel" style="padding:8px 16px; border-radius:6px; background:#fff; border:1px solid #cbd5e1; cursor:pointer;" onclick="document.getElementById('annModal').classList.remove('show')">Cancel</button>
            <asp:Button ID="btnPostAnnouncement" runat="server" Text="Publish Announcement" CssClass="btn-teal" OnClick="btnPostAnnouncement_Click" />
        </div>
    </div>
</div>
</asp:Content>

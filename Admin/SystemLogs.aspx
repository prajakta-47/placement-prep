<%@ Page Title="System Logs" Language="C#" MasterPageFile="~/Admin.Master"
    AutoEventWireup="true" CodeBehind="SystemLogs.aspx.cs"
    Inherits="PlacementPrep.SystemLogs" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>System Logs &amp; Security Audit | Placement Prep Admin</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="admin-shell-page">

    <!-- Page Header -->
    <div class="users-header">
        <div>
            <div class="users-breadcrumb">
                <a href="<%= ResolveUrl("~/Admin/AdminDashboard.aspx") %>">Dashboard</a>
                <span>/</span>
                <span>Intelligence &amp; Audit</span>
                <span>/</span>
                <span>System Logs</span>
            </div>
            <h1 class="users-title">Security Telemetry &amp; System Audit Trail</h1>
            <p class="users-subtitle">
                Inspect administrative transactions, authentication security events, proctoring lockdown anomalies, and examination lifecycle operations.
            </p>
        </div>
        <div class="users-header-actions">
            <asp:LinkButton ID="btnClearLogs" runat="server" CssClass="action-button text-danger"
                OnClick="btnClearLogs_Click" CausesValidation="false"
                OnClientClick="return confirm('Clear demonstration audit trail logs?');">
                <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                    <polyline points="3 6 5 6 21 6"/>
                    <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/>
                </svg>
                Clear Audit Trail
            </asp:LinkButton>
            <asp:LinkButton ID="btnExportCsv" runat="server" CssClass="action-button primary"
                OnClick="btnExportCsv_Click" CausesValidation="false">
                <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                    <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/>
                    <polyline points="7 10 12 15 17 10"/>
                    <line x1="12" y1="15" x2="12" y2="3"/>
                </svg>
                Export CSV Audit
            </asp:LinkButton>
        </div>
    </div>

    <!-- Alert Message Banner -->
    <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="users-alert users-alert-success">
        <asp:Literal ID="litMessage" runat="server" />
    </asp:Panel>

    <!-- Filter & Search Toolbar -->
    <div class="users-filter-bar">
        <asp:HiddenField ID="hfPageIndex" runat="server" Value="1" />

        <div class="users-filter-group users-filter-search">
            <label for="<%= txtSearch.ClientID %>">Search Audit Trail</label>
            <asp:TextBox ID="txtSearch" runat="server" placeholder="Search by message, actor, target entity, IP address..." />
        </div>

        <div class="users-filter-group">
            <label for="<%= ddlModuleFilter.ClientID %>">Module</label>
            <asp:DropDownList ID="ddlModuleFilter" runat="server" AutoPostBack="true"
                OnSelectedIndexChanged="btnApplyFilters_Click" CssClass="users-filter-select">
                <asp:ListItem Text="All Modules" Value="All" Selected="True" />
                <asp:ListItem Text="User Management" Value="User Management" />
                <asp:ListItem Text="Test Engine" Value="Test Engine" />
                <asp:ListItem Text="Proctoring" Value="Proctoring" />
                <asp:ListItem Text="Company Management" Value="Company Management" />
                <asp:ListItem Text="Student Operations" Value="Student Operations" />
            </asp:DropDownList>
        </div>

        <div class="users-filter-group">
            <label for="<%= ddlSeverityFilter.ClientID %>">Severity Level</label>
            <asp:DropDownList ID="ddlSeverityFilter" runat="server" AutoPostBack="true"
                OnSelectedIndexChanged="btnApplyFilters_Click" CssClass="users-filter-select">
                <asp:ListItem Text="All Severities" Value="All" Selected="True" />
                <asp:ListItem Text="Info" Value="Info" />
                <asp:ListItem Text="Warning" Value="Warning" />
                <asp:ListItem Text="Security Alert" Value="Security Alert" />
                <asp:ListItem Text="Error" Value="Error" />
            </asp:DropDownList>
        </div>

        <asp:LinkButton ID="btnApplyFilters" runat="server" CssClass="action-button primary users-filter-btn"
            OnClick="btnApplyFilters_Click" CausesValidation="false">
            Filter
        </asp:LinkButton>
        <asp:LinkButton ID="btnResetFilters" runat="server" CssClass="action-button users-filter-btn"
            OnClick="btnResetFilters_Click" CausesValidation="false">
            Reset
        </asp:LinkButton>
    </div>

    <!-- System Logs Table Panel -->
    <div class="users-table-panel">
        <asp:Repeater ID="rptLogs" runat="server" OnItemCommand="rptLogs_ItemCommand">
            <HeaderTemplate>
                <div class="table-scroll">
                <table class="users-table">
                    <thead>
                        <tr>
                            <th style="width: 75px;">Event ID</th>
                            <th style="width: 140px;">Timestamp</th>
                            <th>Actor &amp; Origin IP</th>
                            <th>Subsystem Module</th>
                            <th>Operation Action</th>
                            <th>Target Scope</th>
                            <th style="width: 110px;">Severity</th>
                            <th style="width: 90px;">Action</th>
                        </tr>
                    </thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr class='<%# Convert.ToString(Eval("Severity")).IndexOf("Error") >= 0 ? "log-row-error" : Convert.ToString(Eval("Severity")).IndexOf("Warning") >= 0 ? "log-row-warning" : "" %>'>
                    <td>
                        <strong class="qb-code">#<%# Eval("EventId") %></strong>
                    </td>
                    <td>
                        <div><strong><%# string.Format("{0:HH:mm:ss}", Eval("Timestamp")) %></strong></div>
                        <small class="text-muted"><%# string.Format("{0:MMM dd, yyyy}", Eval("Timestamp")) %></small>
                    </td>
                    <td>
                        <strong><%# Server.HtmlEncode(Convert.ToString(Eval("ActorName"))) %></strong>
                        <small style="display:block; color:var(--admin-muted);"><%# Server.HtmlEncode(Convert.ToString(Eval("ActorRole"))) %> &middot; <%# Server.HtmlEncode(Convert.ToString(Eval("IpAddress"))) %></small>
                    </td>
                    <td>
                        <span><%# Server.HtmlEncode(Convert.ToString(Eval("Module"))) %></span>
                    </td>
                    <td>
                        <span class="log-code"><%# Server.HtmlEncode(Convert.ToString(Eval("Action"))) %></span>
                    </td>
                    <td>
                        <div style="font-size:11px; max-width: 220px; word-break: break-word;">
                            <%# Server.HtmlEncode(Convert.ToString(Eval("TargetEntity"))) %>
                        </div>
                    </td>
                    <td>
                        <span class='<%# Eval("SeverityBadgeClass") %>'>
                            <i></i><%# Server.HtmlEncode(Convert.ToString(Eval("Severity"))) %>
                        </span>
                    </td>
                    <td class="users-actions">
                        <asp:LinkButton ID="lnkViewDetails" runat="server" CssClass="table-link"
                            CommandName="ViewDetails" CommandArgument='<%# Eval("EventId") %>'
                            CausesValidation="false">Inspect</asp:LinkButton>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                    </tbody>
                </table>
                </div>
            </FooterTemplate>
        </asp:Repeater>

        <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="users-empty">
            <p><strong>No audit trail events match the selected criteria.</strong></p>
            <p class="text-muted">Adjust your severity or module filters to view matching entries.</p>
        </asp:Panel>

        <!-- Pagination Bar -->
        <div class="users-pagination">
            <span class="users-page-info">
                <asp:Literal ID="litPageInfo" runat="server" />
            </span>
            <div class="users-page-size">
                <span>Rows per page</span>
                <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true"
                    OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged" CssClass="users-filter-select compact">
                    <asp:ListItem Text="10" Value="10" Selected="True" />
                    <asp:ListItem Text="25" Value="25" />
                    <asp:ListItem Text="50" Value="50" />
                </asp:DropDownList>
            </div>
            <div class="users-page-nav">
                <asp:LinkButton ID="btnPrevPage" runat="server" CssClass="users-page-btn"
                    OnClick="btnPrevPage_Click" CausesValidation="false">&lsaquo;</asp:LinkButton>
                <asp:Repeater ID="rptPages" runat="server" OnItemCommand="rptPages_ItemCommand">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkPage" runat="server"
                            CssClass='<%# (bool)Eval("IsCurrent") ? "users-page-btn active" : "users-page-btn" %>'
                            CommandName="GoPage" CommandArgument='<%# Eval("PageNumber") %>'
                            CausesValidation="false"
                            Text='<%# Eval("PageNumber") %>' />
                    </ItemTemplate>
                </asp:Repeater>
                <asp:LinkButton ID="btnNextPage" runat="server" CssClass="users-page-btn"
                    OnClick="btnNextPage_Click" CausesValidation="false">&rsaquo;</asp:LinkButton>
            </div>
        </div>
    </div>

    <!-- Event Inspection Modal -->
    <asp:Panel ID="pnlEventModal" runat="server" Visible="false" CssClass="users-modal-backdrop">
        <div class="users-modal users-modal-large" role="dialog" aria-modal="true" aria-labelledby="eventModalTitle">
            <div class="users-modal-header">
                <h2 id="eventModalTitle">Audit Event Inspection #<asp:Literal ID="litModalEventId" runat="server" /></h2>
                <asp:LinkButton ID="btnCloseEventModal" runat="server" CssClass="users-modal-close"
                    OnClick="btnCloseEventModal_Click" CausesValidation="false" aria-label="Close">&times;</asp:LinkButton>
            </div>
            <div class="users-modal-body qb-preview-body">
                <div class="dossier-hero">
                    <div class="dossier-avatar" style="background:#0f172a;">LOG</div>
                    <div class="dossier-hero-info">
                        <h3><asp:Literal ID="litModalAction" runat="server" /></h3>
                        <p>
                            <span><strong>Module:</strong> <asp:Literal ID="litModalModule" runat="server" /></span> &middot;
                            <span><strong>Timestamp:</strong> <asp:Literal ID="litModalTimestamp" runat="server" /></span> &middot;
                            <span><strong>Origin IP:</strong> <asp:Literal ID="litModalIp" runat="server" /></span>
                        </p>
                    </div>
                    <div class="dossier-hero-badges">
                        <span id="badgeModalSeverity" runat="server" class="status-pill status-active"><asp:Literal ID="litModalSeverity" runat="server" /></span>
                    </div>
                </div>

                <!-- Structured Event Metadata -->
                <div class="qb-preview-section">
                    <h3 class="qb-section-heading">Transaction Actors &amp; Target Scope</h3>
                    <table class="kv-table">
                        <tr>
                            <td class="kv-label">Initiating Actor</td>
                            <td class="kv-value"><strong><asp:Literal ID="litModalActor" runat="server" /></strong></td>
                        </tr>
                        <tr>
                            <td class="kv-label">Target Entity</td>
                            <td class="kv-value"><strong><asp:Literal ID="litModalTarget" runat="server" /></strong></td>
                        </tr>
                        <tr>
                            <td class="kv-label">System Message</td>
                            <td class="kv-value"><asp:Literal ID="litModalMessage" runat="server" /></td>
                        </tr>
                    </table>
                </div>

                <!-- Payload JSON Data -->
                <div class="qb-preview-section">
                    <h3 class="qb-section-heading">Structured Audit Payload (JSON Metadata)</h3>
                    <pre class="log-code" style="padding: 12px; font-size: 11px; white-space: pre-wrap; line-height: 1.5;"><asp:Literal ID="litModalPayload" runat="server" /></pre>
                </div>

                <div class="users-hint">
                    <strong>Demonstration Audit Record:</strong> This log entry is retained in the in-memory <code>AuditLogRepository</code> for security policy inspection. No actual external syslog services or production secrets are connected.
                </div>
            </div>
            <div class="users-modal-footer">
                <asp:LinkButton ID="btnDismissEventModal" runat="server" CssClass="action-button primary"
                    OnClick="btnCloseEventModal_Click" CausesValidation="false">Close Inspection</asp:LinkButton>
            </div>
        </div>
    </asp:Panel>

</div>
</asp:Content>

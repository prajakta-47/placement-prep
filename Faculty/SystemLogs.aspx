<%@ Page Title="System Logs" Language="C#" MasterPageFile="~/Faculty.Master" AutoEventWireup="true" CodeBehind="SystemLogs.aspx.cs" Inherits="PlacementPrep.Faculty.SystemLogs" %>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="faculty-dashboard" style="display:flex; flex-direction:column; gap:16px;">

    <div class="faculty-dashboard-heading" style="margin-bottom:0;">
        <div>
            <h1>Security &amp; Evaluation Audit Telemetry</h1>
            <p>Cryptographically signed audit logs of all prompt adjustments, test submissions, and proctor flags</p>
        </div>
        <span class="faculty-sync-label">Immutable Ledger Active</span>
    </div>

    <section class="faculty-panel">
        <div class="faculty-panel-heading">
            <h2>Recent Security &amp; Assessment Events</h2>
        </div>

        <div class="faculty-timeline" style="margin-top:14px;">
            <asp:Repeater ID="rptLogs" runat="server">
                <ItemTemplate>
                    <article class="faculty-timeline-item">
                        <span class="faculty-timeline-marker">&bull;</span>
                        <div class="faculty-activity-content">
                            <div class="faculty-activity-title">
                                <strong><%# Eval("EventName") %> &bull; <span style="font-weight:400; color:var(--fac-muted);"><%# Eval("Module") %></span></strong>
                                <small><%# Eval("Timestamp", "{0:HH:mm:ss}") %></small>
                            </div>
                            <p><%# Eval("ActionSynopsis") %> <span style="font-size:10px; color:var(--fac-muted);">[Actor: <%# Eval("Actor") %>]</span></p>
                        </div>
                    </article>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </section>

</div>
</asp:Content>

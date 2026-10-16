<%@ Page Title="Notification Center" Language="C#" MasterPageFile="~/Student.Master"
    AutoEventWireup="true" CodeBehind="Notifications.aspx.cs"
    Inherits="PlacementPrep.Notifications" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Notification Center | Placement Prep</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="student-notifications-container">
        
        <!-- Header Section -->
        <header class="notifications-header">
            <div>
                <div class="student-analyzer-tag" style="margin-bottom:4px;">
                    <span class="tag-dot"></span>
                    <span>STUDENT ALERTS &bull; REAL-TIME FEED</span>
                </div>
                <h1 style="font-size:22px; font-weight:800; margin:0 0 4px; letter-spacing:-0.5px; color:var(--stu-text);">Notification Center</h1>
                <p style="margin:0; font-size:11px; color:#64748b;">
                    Stay updated with campus recruitment announcements, upcoming diagnostic tests, AI interview feedback, and system alerts.
                </p>
            </div>
            <div style="display:flex; align-items:center; gap:8px;">
                <asp:Button ID="btnMarkAllRead" runat="server" Text="Mark All as Read" CssClass="stu-btn-outline" OnClick="btnMarkAllRead_Click" style="padding:6px 14px; font-size:10.5px;" />
                <a href="<%= ResolveUrl("~/Student/Settings.aspx#notifications") %>" class="stu-btn-primary" style="padding:6px 14px; font-size:10.5px; text-decoration:none; display:inline-flex; align-items:center; gap:4px;">
                    <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z"/></svg>
                    <span>Preferences</span>
                </a>
            </div>
        </header>

        <!-- Status Notice / Feedback Banner -->
        <asp:Panel ID="pnlNotice" runat="server" Visible="false" CssClass="stu-alert success" style="margin-bottom:16px; padding:10px 14px; border-radius:8px; background:#ecfdf5; border:1px solid #a7f3d0; color:#065f46; font-size:11px;">
            <asp:Literal ID="litNotice" runat="server" />
        </asp:Panel>

        <!-- Notification Filter Chips -->
        <div class="student-chips-cloud" style="margin-bottom:16px;">
            <asp:LinkButton ID="chipAll" runat="server" CssClass="student-chip-btn active" CommandArgument="All" OnClick="Filter_Click">All Notifications (<asp:Literal ID="litCountAll" runat="server">6</asp:Literal>)</asp:LinkButton>
            <asp:LinkButton ID="chipUnread" runat="server" CssClass="student-chip-btn" CommandArgument="Unread" OnClick="Filter_Click">Unread (<asp:Literal ID="litCountUnread" runat="server">3</asp:Literal>)</asp:LinkButton>
            <asp:LinkButton ID="chipDrives" runat="server" CssClass="student-chip-btn" CommandArgument="Drive" OnClick="Filter_Click">Placement Drives</asp:LinkButton>
            <asp:LinkButton ID="chipTests" runat="server" CssClass="student-chip-btn" CommandArgument="Test" OnClick="Filter_Click">Diagnostic Tests</asp:LinkButton>
            <asp:LinkButton ID="chipInterviews" runat="server" CssClass="student-chip-btn" CommandArgument="Interview" OnClick="Filter_Click">AI Interviews</asp:LinkButton>
            <asp:LinkButton ID="chipAcademic" runat="server" CssClass="student-chip-btn" CommandArgument="Academic" OnClick="Filter_Click">Academic Updates</asp:LinkButton>
        </div>

        <!-- Notifications List -->
        <div class="notifications-list">
            <asp:Repeater ID="rptNotifications" runat="server" OnItemCommand="rptNotifications_ItemCommand">
                <ItemTemplate>
                    <div class='<%# "notification-card " + (Convert.ToBoolean(Eval("IsRead")) ? "is-read" : "is-unread") %>'>
                        <div class='<%# "notif-badge-icon notif-icon-" + Eval("CategoryType") %>'>
                            <%# Eval("IconHtml") %>
                        </div>
                        
                        <div class="notif-body">
                            <div class="notif-title-row">
                                <div style="display:flex; align-items:center; gap:8px;">
                                    <strong class="notif-title"><%# Eval("Title") %></strong>
                                    <%# Convert.ToBoolean(Eval("IsRead")) ? "" : "<span class='notif-dot-pill'>NEW</span>" %>
                                </div>
                                <span class="notif-time"><%# Eval("TimeAgo") %></span>
                            </div>
                            
                            <p class="notif-message"><%# Eval("Message") %></p>
                            
                            <div class="notif-actions-row">
                                <span class='<%# "notif-category-tag notif-tag-" + Eval("CategoryType") %>'>
                                    <%# Eval("Category") %>
                                </span>
                                
                                <div style="display:flex; align-items:center; gap:8px;">
                                    <a href='<%# ResolveUrl(Eval("ActionUrl").ToString()) %>' class="stu-btn-outline" style="font-size:10px; padding:3px 10px; text-decoration:none;">
                                        <%# Eval("ActionText") %> &rarr;
                                    </a>
                                    <asp:LinkButton ID="btnToggleRead" runat="server" CommandName="ToggleRead" CommandArgument='<%# Eval("Id") %>' CssClass="notif-dismiss-btn" ToolTip="Toggle read status">
                                        <%# Convert.ToBoolean(Eval("IsRead")) ? "Mark Unread" : "Mark Read" %>
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- Empty State Panel -->
        <asp:Panel ID="pnlEmptyState" runat="server" Visible="false" CssClass="empty-resource-state" style="margin-top:20px;">
            <svg viewBox="0 0 24 24" width="40" height="40" fill="none" stroke="#94a3b8" stroke-width="1.8" style="margin:0 auto 10px; display:block;"><path d="M18 9a6 6 0 0 0-12 0c0 7-3 7-3 9h18c0-2-3-2-3-9"/><path d="M10 21h4"/></svg>
            <strong style="font-size:14px; color:var(--stu-text); display:block; margin-bottom:4px;">No notifications in this category</strong>
            <p style="font-size:11px; color:#64748b; margin:0 0 14px;">You are all caught up with your campus placement preparation alerts.</p>
            <asp:Button ID="btnResetFilter" runat="server" Text="View All Notifications" CssClass="stu-btn-outline" OnClick="btnResetFilter_Click" />
        </asp:Panel>

    </div>
</asp:Content>

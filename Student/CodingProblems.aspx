<%@ Page Title="Coding Problems" Language="C#" MasterPageFile="~/Student.Master"
    AutoEventWireup="true" CodeBehind="CodingProblems.aspx.cs"
    Inherits="PlacementPrep.CodingProblems" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Coding Problems | Placement Prep</title>
    <style>
        .problem-status-icon {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 22px;
            height: 22px;
            border-radius: 50%;
            font-size: 11px;
            font-weight: 800;
        }
        .problem-status-icon.solved {
            background: #dcfce7;
            color: #15803d;
        }
        .problem-status-icon.attempted {
            background: #fef3c7;
            color: #b45309;
        }
        .problem-status-icon.todo {
            background: #f1f5f9;
            color: #94a3b8;
        }
        .student-pagination {
            display: flex;
            align-items: center;
            justify-content: flex-end;
            gap: 6px;
            padding: 12px 16px;
            background: #fff;
            border-top: 1px solid #eeedf5;
        }
        .page-link-btn {
            padding: 4px 10px;
            border-radius: 5px;
            border: 1px solid #d4d6e4;
            background: #fff;
            font-size: 10px;
            font-weight: 700;
            color: #475569;
            cursor: pointer;
            text-decoration: none;
        }
        .page-link-btn.active {
            background: var(--stu-teal);
            color: #fff;
            border-color: var(--stu-teal);
        }
    </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="student-problems-container">
        
        <!-- Header -->
        <header class="student-aptitude-header">
            <div>
                <div class="student-analyzer-tag" style="margin-bottom:4px;">
                    <span class="tag-dot"></span>
                    <span>TECHNICAL PREPARATION &bull; 150 CURATED PROBLEMS</span>
                </div>
                <h1 style="font-size:22px; font-weight:800; margin:0 0 4px; letter-spacing:-0.5px;">Coding Problems Directory</h1>
                <p style="margin:0; font-size:11px; color:#64748b;">
                    Master core algorithmic patterns and data structures frequently tested in campus recruitment rounds.
                </p>
            </div>
        </header>

        <!-- Metric Triplet Summary -->
        <div class="student-metric-triplet" style="margin-bottom:16px;">
            <div class="student-metric-card">
                <div class="student-metric-icon">
                    <svg viewBox="0 0 24 24"><polyline points="20 6 9 17 4 12"/></svg>
                </div>
                <div class="student-metric-data">
                    <small>Solved Problems</small>
                    <strong>28 <span style="font-size:10px; color:#64748b; font-weight:normal;">/ 150</span></strong>
                </div>
            </div>

            <div class="student-metric-card">
                <div class="student-metric-icon">
                    <svg viewBox="0 0 24 24"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/></svg>
                </div>
                <div class="student-metric-data">
                    <small>Difficulty Breakdown</small>
                    <strong style="font-size:12px;">
                        <span style="color:#059669;">18 Easy</span> &bull; 
                        <span style="color:#d97706;">8 Med</span> &bull; 
                        <span style="color:#dc2626;">2 Hard</span>
                    </strong>
                </div>
            </div>

            <div class="student-metric-card">
                <div class="student-metric-icon">
                    <svg viewBox="0 0 24 24"><line x1="18" y1="20" x2="18" y2="10"/><line x1="12" y1="20" x2="12" y2="4"/><line x1="6" y1="20" x2="6" y2="14"/></svg>
                </div>
                <div class="student-metric-data">
                    <small>Acceptance Benchmark</small>
                    <strong>76.4% <span style="font-size:10px; color:#10b981; font-weight:700;">First-Pass</span></strong>
                </div>
            </div>
        </div>

        <!-- Controls: Search & Difficulty Filter -->
        <div class="student-problems-controls">
            <div class="student-search-box">
                <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="#64748b" stroke-width="1.8"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
                <asp:TextBox ID="txtSearchProblem" runat="server" placeholder="Search problems by title, keywords or companies..." AutoPostBack="true" OnTextChanged="FilterChanged" />
            </div>

            <div style="display:flex; align-items:center; gap:8px;">
                <label style="font-size:10.5px; font-weight:700; color:#475569;">Difficulty:</label>
                <asp:DropDownList ID="ddlDifficulty" runat="server" CssClass="stu-btn-outline" AutoPostBack="true" OnSelectedIndexChanged="FilterChanged" style="padding:4px 8px;">
                    <asp:ListItem Value="All" Selected="True">All Difficulties</asp:ListItem>
                    <asp:ListItem Value="Easy">Easy</asp:ListItem>
                    <asp:ListItem Value="Medium">Medium</asp:ListItem>
                    <asp:ListItem Value="Hard">Hard</asp:ListItem>
                </asp:DropDownList>
                
                <label style="font-size:10.5px; font-weight:700; color:#475569; margin-left:6px;">Status:</label>
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="stu-btn-outline" AutoPostBack="true" OnSelectedIndexChanged="FilterChanged" style="padding:4px 8px;">
                    <asp:ListItem Value="All" Selected="True">All Status</asp:ListItem>
                    <asp:ListItem Value="Solved">Solved</asp:ListItem>
                    <asp:ListItem Value="Attempted">Attempted</asp:ListItem>
                    <asp:ListItem Value="Todo">Todo</asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>

        <!-- Topic Filter Chips -->
        <div class="student-chips-cloud">
            <asp:LinkButton ID="chipAll" runat="server" CssClass="student-chip-btn active" CommandArgument="All" OnClick="TopicChip_Click">All Topics</asp:LinkButton>
            <asp:LinkButton ID="chipArrays" runat="server" CssClass="student-chip-btn" CommandArgument="Arrays" OnClick="TopicChip_Click">Arrays</asp:LinkButton>
            <asp:LinkButton ID="chipStrings" runat="server" CssClass="student-chip-btn" CommandArgument="Strings" OnClick="TopicChip_Click">Strings</asp:LinkButton>
            <asp:LinkButton ID="chipTwoPointers" runat="server" CssClass="student-chip-btn" CommandArgument="Two Pointers" OnClick="TopicChip_Click">Two Pointers</asp:LinkButton>
            <asp:LinkButton ID="chipLinkedList" runat="server" CssClass="student-chip-btn" CommandArgument="Linked List" OnClick="TopicChip_Click">Linked List</asp:LinkButton>
            <asp:LinkButton ID="chipStack" runat="server" CssClass="student-chip-btn" CommandArgument="Stack" OnClick="TopicChip_Click">Stack</asp:LinkButton>
            <asp:LinkButton ID="chipBinarySearch" runat="server" CssClass="student-chip-btn" CommandArgument="Binary Search" OnClick="TopicChip_Click">Binary Search</asp:LinkButton>
            <asp:LinkButton ID="chipDP" runat="server" CssClass="student-chip-btn" CommandArgument="Dynamic Programming" OnClick="TopicChip_Click">Dynamic Programming</asp:LinkButton>
            <asp:LinkButton ID="chipTrees" runat="server" CssClass="student-chip-btn" CommandArgument="Trees" OnClick="TopicChip_Click">Trees &amp; Graphs</asp:LinkButton>
        </div>

        <!-- Problem List Table -->
        <div class="student-table-card">
            <table class="student-data-table">
                <thead>
                    <tr>
                        <th style="width:40px; text-align:center;">Status</th>
                        <th>Title &amp; Topic</th>
                        <th style="width:90px;">Difficulty</th>
                        <th style="width:90px;">Acceptance</th>
                        <th>Target Companies</th>
                        <th style="width:110px; text-align:right;">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptProblems" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td style="text-align:center;">
                                    <span class='<%# "problem-status-icon " + Eval("StatusClass") %>' title='<%# Eval("Status") %>'>
                                        <%# Eval("StatusIcon") %>
                                    </span>
                                </td>
                                <td>
                                    <a href='<%# ResolveUrl("~/Student/ProblemDetails.aspx?id=" + Eval("Id")) %>' style="font-weight:700; color:var(--stu-text); text-decoration:none;">
                                        <%# Eval("Id") %>. <%# Eval("Title") %>
                                    </a>
                                    <div style="font-size:9.5px; color:#64748b; margin-top:2px;">
                                        <%# Eval("Topic") %>
                                    </div>
                                </td>
                                <td>
                                    <span class='<%# "difficulty-badge " + Eval("DifficultyClass") %>'>
                                        <%# Eval("Difficulty") %>
                                    </span>
                                </td>
                                <td>
                                    <strong style="color:#475569;"><%# Eval("AcceptanceRate") %>%</strong>
                                </td>
                                <td>
                                    <%# Eval("CompanyBadgesHtml") %>
                                </td>
                                <td style="text-align:right;">
                                    <a href='<%# ResolveUrl("~/Student/ProblemDetails.aspx?id=" + Eval("Id")) %>' class="stu-btn-primary" style="padding:4px 10px; font-size:9.5px; text-decoration:none;">
                                        <%# Eval("ActionText") %> &rarr;
                                    </a>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>

            <!-- Pagination Bar -->
            <div class="student-pagination">
                <span style="font-size:10px; color:#64748b; margin-right:auto;">
                    Showing <asp:Label ID="lblProblemCount" runat="server" Text="1 - 8 of 150" /> problems
                </span>
                <asp:LinkButton ID="btnPagePrev" runat="server" CssClass="page-link-btn" OnClick="PageChange_Click" CommandArgument="Prev">&larr; Prev</asp:LinkButton>
                <asp:LinkButton ID="btnPage1" runat="server" CssClass="page-link-btn active" OnClick="PageChange_Click" CommandArgument="1">1</asp:LinkButton>
                <asp:LinkButton ID="btnPage2" runat="server" CssClass="page-link-btn" OnClick="PageChange_Click" CommandArgument="2">2</asp:LinkButton>
                <asp:LinkButton ID="btnPage3" runat="server" CssClass="page-link-btn" OnClick="PageChange_Click" CommandArgument="3">3</asp:LinkButton>
                <asp:LinkButton ID="btnPageNext" runat="server" CssClass="page-link-btn" OnClick="PageChange_Click" CommandArgument="Next">Next &rarr;</asp:LinkButton>
            </div>
        </div>

    </div>
</asp:Content>

<%@ Page Title="Coding Question Bank" Language="C#" MasterPageFile="~/Admin.Master"
    AutoEventWireup="true" CodeBehind="CodingQuestions.aspx.cs"
    Inherits="PlacementPrep.Admin.CodingQuestions" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="users-page-container">
    <asp:HiddenField ID="hfPageIndex" runat="server" Value="1" />

    <!-- Breadcrumb & Header -->
    <div class="users-header">
        <div>
            <div class="users-breadcrumb">
                <span>ACADEMIC &amp; ASSESSMENT OPERATIONS</span>
                <span class="users-sep">/</span>
                <a href="QuestionBank.aspx" style="color: #64748b; text-decoration: none;">Question Bank</a>
                <span class="users-sep">/</span>
                <span>Coding Challenges</span>
            </div>
            <h1 class="users-title">Coding Question Bank</h1>
            <p class="users-subtitle">Algorithmic coding challenges, data structures problem statements, test case suites, and code evaluation starter templates.</p>
        </div>
        <div class="users-top-actions">
            <a href="QuestionBank.aspx" class="action-button">
                <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <line x1="19" y1="12" x2="5" y2="12"></line>
                    <polyline points="12 19 5 12 12 5"></polyline>
                </svg>
                <span>Central Question Bank</span>
            </a>
            <a href="CodingProblemEditor.aspx" class="action-button primary">
                <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <line x1="12" y1="5" x2="12" y2="19"></line>
                    <line x1="5" y1="12" x2="19" y2="12"></line>
                </svg>
                <span>Add Coding Problem</span>
            </a>
        </div>
    </div>

    <!-- Alert Banner -->
    <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="users-alert" role="status">
        <asp:Literal ID="litMessage" runat="server" />
    </asp:Panel>

    <!-- KPI Cards Grid -->
    <div class="users-kpi-grid">
        <article class="users-kpi-card">
            <div class="users-kpi-top">
                <span class="users-kpi-label">TOTAL CODING PROBLEMS</span>
                <span class="users-kpi-icon users-kpi-icon-blue">
                    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <polyline points="16 18 22 12 16 6"></polyline>
                        <polyline points="8 6 2 12 8 18"></polyline>
                    </svg>
                </span>
            </div>
            <div class="users-kpi-value">
                <asp:Literal ID="litTotalProblems" runat="server" Text="390" />
            </div>
            <div class="users-kpi-meta">
                Multi-language automated grading suite
            </div>
        </article>

        <article class="users-kpi-card">
            <div class="users-kpi-top">
                <span class="users-kpi-label">EASY LEVEL</span>
                <span class="users-kpi-icon users-kpi-icon-mint">
                    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <circle cx="12" cy="12" r="10"></circle>
                        <polyline points="12 6 12 12 14 14"></polyline>
                    </svg>
                </span>
            </div>
            <div class="users-kpi-value">
                <asp:Literal ID="litEasyCount" runat="server" Text="140" />
            </div>
            <div class="users-kpi-meta">
                Foundational loops, arrays, strings
            </div>
        </article>

        <article class="users-kpi-card">
            <div class="users-kpi-top">
                <span class="users-kpi-label">MEDIUM LEVEL</span>
                <span class="users-kpi-icon users-kpi-icon-teal">
                    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <line x1="18" y1="20" x2="18" y2="10"></line>
                        <line x1="12" y1="20" x2="12" y2="4"></line>
                        <line x1="6" y1="20" x2="6" y2="14"></line>
                    </svg>
                </span>
            </div>
            <div class="users-kpi-value">
                <asp:Literal ID="litMediumCount" runat="server" Text="195" />
            </div>
            <div class="users-kpi-meta">
                Trees, DP, Greedy, Two Pointers
            </div>
        </article>

        <article class="users-kpi-card">
            <div class="users-kpi-top">
                <span class="users-kpi-label">HARD / ADVANCED</span>
                <span class="users-kpi-icon users-kpi-icon-blue">
                    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon>
                    </svg>
                </span>
            </div>
            <div class="users-kpi-value">
                <asp:Literal ID="litHardCount" runat="server" Text="55" />
            </div>
            <div class="users-kpi-meta">
                Graphs, Segment Trees, Hard DP
            </div>
        </article>
    </div>

    <!-- Search & Filter Controls -->
    <div class="users-controls">
        <div class="users-search-box">
            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                <circle cx="11" cy="11" r="8"></circle>
                <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
            </svg>
            <asp:TextBox ID="txtSearch" runat="server" CssClass="users-search-input"
                placeholder="Search coding problems by title, topic, code, or statement..." />
        </div>

        <div class="users-filter-group">
            <asp:DropDownList ID="ddlTopic" runat="server" CssClass="users-select">
                <asp:ListItem Text="All Topics" Value="All" Selected="True" />
            </asp:DropDownList>

            <asp:DropDownList ID="ddlDifficulty" runat="server" CssClass="users-select">
                <asp:ListItem Text="All Difficulties" Value="All" Selected="True" />
                <asp:ListItem Text="Easy" Value="Easy" />
                <asp:ListItem Text="Medium" Value="Medium" />
                <asp:ListItem Text="Hard" Value="Hard" />
            </asp:DropDownList>

            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="users-select">
                <asp:ListItem Text="All Status" Value="All" Selected="True" />
                <asp:ListItem Text="Published" Value="Published" />
                <asp:ListItem Text="Draft" Value="Draft" />
                <asp:ListItem Text="In Review" Value="In Review" />
            </asp:DropDownList>

            <asp:LinkButton ID="btnFilter" runat="server" CssClass="users-filter-btn" OnClick="btnFilter_Click" ToolTip="Apply Filters">
                <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3"></polygon>
                </svg>
            </asp:LinkButton>

            <asp:LinkButton ID="btnReset" runat="server" CssClass="action-button" OnClick="btnReset_Click">
                <span>Reset</span>
            </asp:LinkButton>
        </div>
    </div>

    <!-- Problems Table -->
    <div class="users-table-card">
        <asp:Repeater ID="rptProblems" runat="server" OnItemCommand="rptProblems_ItemCommand">
            <HeaderTemplate>
                <table class="users-table" role="table" aria-label="Coding Problems Directory">
                    <thead>
                        <tr>
                            <th scope="col" style="width: 120px;">CODE</th>
                            <th scope="col">PROBLEM TITLE &amp; TOPIC</th>
                            <th scope="col" style="width: 110px;">DIFFICULTY</th>
                            <th scope="col" style="width: 120px;">TEST CASES</th>
                            <th scope="col" style="width: 90px;">MARKS</th>
                            <th scope="col" style="width: 130px;">ACCEPTANCE</th>
                            <th scope="col" style="width: 110px;">STATUS</th>
                            <th scope="col" style="width: 200px; text-align: right;">ACTIONS</th>
                        </tr>
                    </thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <span class="user-id-badge" style="background: #e0e7ff; color: #4338ca;"><%# Eval("Code") %></span>
                    </td>
                    <td>
                        <div class="user-identity">
                            <div class="user-identity-meta">
                                <span class="user-name" style="font-weight: 600; color: #0f172a;"><%# Eval("Title") %></span>
                                <div style="display: flex; gap: 6px; align-items: center; margin-top: 3px;">
                                    <span class="user-dept" style="color: #6366f1; background: #e0e7ff; padding: 2px 7px; border-radius: 4px; font-size: 10px; font-weight: 600;">
                                        <%# Eval("Topic") %>
                                    </span>
                                    <span style="font-size: 11px; color: #64748b;"><%# Eval("StatementSnippet") %></span>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>
                        <span class='<%# Eval("DifficultyClass") %>'><%# Eval("Difficulty") %></span>
                    </td>
                    <td>
                        <span style="font-weight: 600; color: #334155;"><%# Eval("TestCaseCount") %> cases</span>
                    </td>
                    <td>
                        <span style="font-weight: 700; color: #0f172a;"><%# Eval("Marks") %> pts</span>
                    </td>
                    <td>
                        <span style="font-weight: 600; color: #059669;"><%# Eval("AcceptanceRate") %>%</span>
                        <div style="font-size: 10px; color: #94a3b8;"><%# string.Format("{0:N0}", Eval("SubmissionsCount")) %> runs</div>
                    </td>
                    <td>
                        <span class='<%# Eval("StatusClass") %>'><%# Eval("Status") %></span>
                    </td>
                    <td style="text-align: right;">
                        <div class="user-actions" style="justify-content: flex-end;">
                            <asp:LinkButton ID="btnPreview" runat="server" CssClass="user-row-btn"
                                CommandName="Preview" CommandArgument='<%# Eval("ProblemId") %>' CausesValidation="false">
                                Preview
                            </asp:LinkButton>
                            <a href='CodingProblemEditor.aspx?id=<%# Eval("ProblemId") %>' class="user-row-btn">
                                Edit
                            </a>
                            <asp:LinkButton ID="btnAudit" runat="server" CssClass="user-row-btn"
                                CommandName="ToggleAudit" CommandArgument='<%# Eval("ProblemId") %>' CausesValidation="false">
                                Toggle
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" runat="server" CssClass="user-row-btn user-row-btn-danger"
                                CommandName="DeleteProblem" CommandArgument='<%# Eval("ProblemId") %>' CausesValidation="false"
                                OnClientClick="return confirm('Are you sure you want to delete this coding problem?');">
                                Delete
                            </asp:LinkButton>
                        </div>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                    </tbody>
                </table>
            </FooterTemplate>
        </asp:Repeater>

        <asp:Panel ID="pnlEmptyState" runat="server" Visible="false" CssClass="users-empty">
            <svg viewBox="0 0 24 24" width="36" height="36" fill="none" stroke="#94a3b8" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                <circle cx="12" cy="12" r="10"></circle>
                <line x1="12" y1="8" x2="12" y2="12"></line>
                <line x1="12" y1="16" x2="12.01" y2="16"></line>
            </svg>
            <p>No coding problems matched your search or filter criteria.</p>
            <asp:LinkButton ID="btnEmptyReset" runat="server" CssClass="action-button" OnClick="btnReset_Click">
                Reset Filters
            </asp:LinkButton>
        </asp:Panel>

        <!-- Pagination Bar -->
        <div class="users-pagination">
            <div class="users-pagination-left">
                Showing <asp:Literal ID="litShowingStart" runat="server" Text="1" />
                to <asp:Literal ID="litShowingEnd" runat="server" Text="10" />
                of <asp:Literal ID="litTotalCount" runat="server" Text="390" /> coding problems
            </div>
            <div class="users-pagination-right">
                <div class="users-rows-per-page">
                    <label for="<%= ddlPageSize.ClientID %>">Rows per page</label>
                    <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true"
                        OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged" CssClass="users-page-select">
                        <asp:ListItem Text="10" Value="10" Selected="True" />
                        <asp:ListItem Text="25" Value="25" />
                        <asp:ListItem Text="50" Value="50" />
                    </asp:DropDownList>
                </div>
                <div class="users-page-nav">
                    <asp:LinkButton ID="btnPrevPage" runat="server" CssClass="users-nav-btn" OnClick="btnPrevPage_Click" aria-label="Previous page">&lsaquo;</asp:LinkButton>
                    <asp:Repeater ID="rptPageNumbers" runat="server" OnItemCommand="rptPageNumbers_ItemCommand">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnPage" runat="server"
                                CssClass='<%# (bool)Eval("IsCurrent") ? "users-page-btn active" : "users-page-btn" %>'
                                CommandName="GoToPage" CommandArgument='<%# Eval("PageNumber") %>'>
                                <%# Eval("PageNumber") %>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:Repeater>
                    <asp:LinkButton ID="btnNextPage" runat="server" CssClass="users-nav-btn" OnClick="btnNextPage_Click" aria-label="Next page">&rsaquo;</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>

    <!-- Coding Problem Preview Modal -->
    <asp:Panel ID="pnlPreviewModal" runat="server" Visible="false" CssClass="users-modal-backdrop">
        <div class="users-modal users-modal-large" role="dialog" aria-modal="true" aria-labelledby="codingModalTitle" style="max-width: 800px; max-height: 90vh; overflow-y: auto;">
            <div class="users-modal-header">
                <div>
                    <span class="user-id-badge" style="background: #e0e7ff; color: #4338ca;"><asp:Literal ID="litPreviewCode" runat="server" /></span>
                    <span style="margin-left: 8px; font-size: 13px; color: #64748b; font-weight: 500;">
                        <asp:Literal ID="litPreviewTopic" runat="server" /> &middot; <asp:Literal ID="litPreviewDifficulty" runat="server" />
                    </span>
                </div>
                <asp:LinkButton ID="btnClosePreview" runat="server" CssClass="users-modal-close"
                    OnClick="btnClosePreview_Click" CausesValidation="false" aria-label="Close">&times;</asp:LinkButton>
            </div>
            <div class="users-modal-body">
                <h2 id="codingModalTitle" style="font-size: 18px; font-weight: 700; color: #0f172a; margin-top: 0; margin-bottom: 12px;">
                    <asp:Literal ID="litPreviewTitle" runat="server" />
                </h2>

                <div style="margin-bottom: 16px;">
                    <h4 style="font-size: 11px; text-transform: uppercase; color: #64748b; font-weight: 700; margin-bottom: 6px;">Problem Statement</h4>
                    <div style="font-size: 13px; color: #334155; line-height: 1.6; white-space: pre-wrap; background: #f8fafc; padding: 12px; border-radius: 6px; border: 1px solid #e2e8f0;">
                        <asp:Literal ID="litPreviewStatement" runat="server" />
                    </div>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 12px; margin-bottom: 16px;">
                    <div>
                        <h4 style="font-size: 11px; text-transform: uppercase; color: #64748b; font-weight: 700; margin-bottom: 6px;">Input Format</h4>
                        <div style="font-size: 12px; color: #334155; line-height: 1.5; background: #f8fafc; padding: 10px; border-radius: 6px; border: 1px solid #e2e8f0; min-height: 60px;">
                            <asp:Literal ID="litPreviewInputFormat" runat="server" />
                        </div>
                    </div>
                    <div>
                        <h4 style="font-size: 11px; text-transform: uppercase; color: #64748b; font-weight: 700; margin-bottom: 6px;">Output Format</h4>
                        <div style="font-size: 12px; color: #334155; line-height: 1.5; background: #f8fafc; padding: 10px; border-radius: 6px; border: 1px solid #e2e8f0; min-height: 60px;">
                            <asp:Literal ID="litPreviewOutputFormat" runat="server" />
                        </div>
                    </div>
                </div>

                <div style="margin-bottom: 16px;">
                    <h4 style="font-size: 11px; text-transform: uppercase; color: #64748b; font-weight: 700; margin-bottom: 6px;">Constraints &amp; Limits</h4>
                    <div style="font-family: monospace; font-size: 12px; color: #b45309; background: #fffbeb; padding: 10px 12px; border-radius: 6px; border: 1px solid #fef3c7; white-space: pre-wrap;">
                        <asp:Literal ID="litPreviewConstraints" runat="server" />
                    </div>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 12px; margin-bottom: 16px;">
                    <div>
                        <h4 style="font-size: 11px; text-transform: uppercase; color: #64748b; font-weight: 700; margin-bottom: 6px;">Sample Input</h4>
                        <pre style="margin: 0; font-family: monospace; font-size: 12px; background: #0f172a; color: #38bdf8; padding: 10px; border-radius: 6px; overflow-x: auto;"><asp:Literal ID="litPreviewSampleInput" runat="server" /></pre>
                    </div>
                    <div>
                        <h4 style="font-size: 11px; text-transform: uppercase; color: #64748b; font-weight: 700; margin-bottom: 6px;">Sample Output</h4>
                        <pre style="margin: 0; font-family: monospace; font-size: 12px; background: #0f172a; color: #4ade80; padding: 10px; border-radius: 6px; overflow-x: auto;"><asp:Literal ID="litPreviewSampleOutput" runat="server" /></pre>
                    </div>
                </div>

                <div style="margin-bottom: 16px;">
                    <h4 style="font-size: 11px; text-transform: uppercase; color: #64748b; font-weight: 700; margin-bottom: 6px;">Explanation</h4>
                    <div style="font-size: 12px; color: #334155; line-height: 1.5; background: #f8fafc; padding: 10px; border-radius: 6px; border: 1px solid #e2e8f0;">
                        <asp:Literal ID="litPreviewExplanation" runat="server" />
                    </div>
                </div>

                <div style="margin-bottom: 16px;">
                    <h4 style="font-size: 11px; text-transform: uppercase; color: #64748b; font-weight: 700; margin-bottom: 6px;">Starter Code Skeleton</h4>
                    <pre style="margin: 0; font-family: monospace; font-size: 12px; background: #1e293b; color: #e2e8f0; padding: 12px; border-radius: 6px; overflow-x: auto; line-height: 1.5;"><asp:Literal ID="litPreviewStarterCode" runat="server" /></pre>
                </div>

                <div style="display: flex; justify-content: space-between; font-size: 12px; color: #64748b; padding-top: 12px; border-top: 1px solid #e2e8f0;">
                    <span>Weightage: <strong><asp:Literal ID="litPreviewMarks" runat="server" /> marks</strong> &middot; <asp:Literal ID="litPreviewTestCases" runat="server" /> test cases</span>
                    <span>Status: <strong><asp:Literal ID="litPreviewStatus" runat="server" /></strong></span>
                </div>
            </div>
            <div class="users-modal-footer">
                <asp:LinkButton ID="btnDismissPreview" runat="server" CssClass="action-button primary"
                    OnClick="btnClosePreview_Click" CausesValidation="false">Close Preview</asp:LinkButton>
            </div>
        </div>
    </asp:Panel>

</div>
</asp:Content>

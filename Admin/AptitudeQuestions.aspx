<%@ Page Title="Aptitude Question Bank" Language="C#" MasterPageFile="~/Admin.Master"
    AutoEventWireup="true" CodeBehind="AptitudeQuestions.aspx.cs"
    Inherits="PlacementPrep.Admin.AptitudeQuestions" %>

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
                <span>Aptitude Repository</span>
            </div>
            <h1 class="users-title">Aptitude Question Bank</h1>
            <p class="users-subtitle">Standardized quantitative aptitude, logical reasoning, verbal ability, and data interpretation multiple-choice questions repository.</p>
        </div>
        <div class="users-top-actions">
            <a href="QuestionBank.aspx" class="action-button">
                <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <line x1="19" y1="12" x2="5" y2="12"></line>
                    <polyline points="12 19 5 12 12 5"></polyline>
                </svg>
                <span>Central Question Bank</span>
            </a>
            <a href="AptitudeQuestionEditor.aspx" class="action-button primary">
                <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <line x1="12" y1="5" x2="12" y2="19"></line>
                    <line x1="5" y1="12" x2="19" y2="12"></line>
                </svg>
                <span>Add Aptitude Question</span>
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
                <span class="users-kpi-label">TOTAL APTITUDE ITEMS</span>
                <span class="users-kpi-icon users-kpi-icon-blue">
                    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <circle cx="12" cy="12" r="10"></circle>
                        <path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"></path>
                        <line x1="12" y1="17" x2="12.01" y2="17"></line>
                    </svg>
                </span>
            </div>
            <div class="users-kpi-value">
                <asp:Literal ID="litTotalAptitude" runat="server" Text="1,240" />
            </div>
            <div class="users-kpi-meta">
                Categorized across 4 core aptitude domains
            </div>
        </article>

        <article class="users-kpi-card">
            <div class="users-kpi-top">
                <span class="users-kpi-label">QUANTITATIVE APTITUDE</span>
                <span class="users-kpi-icon users-kpi-icon-mint">
                    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <line x1="18" y1="20" x2="18" y2="10"></line>
                        <line x1="12" y1="20" x2="12" y2="4"></line>
                        <line x1="6" y1="20" x2="6" y2="14"></line>
                    </svg>
                </span>
            </div>
            <div class="users-kpi-value">
                <asp:Literal ID="litQuantCount" runat="server" Text="480" />
            </div>
            <div class="users-kpi-meta">
                <strong class="users-kpi-good">38.7%</strong> &middot; Arithmetic, Algebra, Geometry
            </div>
        </article>

        <article class="users-kpi-card">
            <div class="users-kpi-top">
                <span class="users-kpi-label">LOGICAL REASONING</span>
                <span class="users-kpi-icon users-kpi-icon-teal">
                    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <polyline points="22 12 18 12 15 21 9 3 6 12 2 12"></polyline>
                    </svg>
                </span>
            </div>
            <div class="users-kpi-value">
                <asp:Literal ID="litLogicalCount" runat="server" Text="360" />
            </div>
            <div class="users-kpi-meta">
                <strong class="users-kpi-good">29.0%</strong> &middot; Syllogisms, Series, Analytical
            </div>
        </article>

        <article class="users-kpi-card">
            <div class="users-kpi-top">
                <span class="users-kpi-label">VERBAL ABILITY &amp; DI</span>
                <span class="users-kpi-icon users-kpi-icon-blue">
                    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                        <polyline points="14 2 14 8 20 8"></polyline>
                    </svg>
                </span>
            </div>
            <div class="users-kpi-value">
                <asp:Literal ID="litVerbalCount" runat="server" Text="400" />
            </div>
            <div class="users-kpi-meta">
                <strong class="users-kpi-good">32.3%</strong> &middot; Reading Comprehension &amp; Charts
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
                placeholder="Search aptitude questions by prompt, topic, or code..." />
        </div>

        <div class="users-filter-group">
            <asp:DropDownList ID="ddlTopic" runat="server" CssClass="users-select">
                <asp:ListItem Text="All Topics" Value="All" Selected="True" />
                <asp:ListItem Text="Quantitative Aptitude" Value="Quantitative Aptitude" />
                <asp:ListItem Text="Logical Reasoning" Value="Logical Reasoning" />
                <asp:ListItem Text="Verbal Ability" Value="Verbal Ability" />
                <asp:ListItem Text="Data Interpretation" Value="Data Interpretation" />
            </asp:DropDownList>

            <asp:DropDownList ID="ddlDifficulty" runat="server" CssClass="users-select">
                <asp:ListItem Text="All Difficulties" Value="All" Selected="True" />
                <asp:ListItem Text="Easy" Value="Easy" />
                <asp:ListItem Text="Medium" Value="Medium" />
                <asp:ListItem Text="Hard" Value="Hard" />
            </asp:DropDownList>

            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="users-select">
                <asp:ListItem Text="All Status" Value="All" Selected="True" />
                <asp:ListItem Text="Verified" Value="Verified" />
                <asp:ListItem Text="Draft" Value="Draft" />
                <asp:ListItem Text="Review Needed" Value="Review Needed" />
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

    <!-- Questions Table -->
    <div class="users-table-card">
        <asp:Repeater ID="rptQuestions" runat="server" OnItemCommand="rptQuestions_ItemCommand">
            <HeaderTemplate>
                <table class="users-table" role="table" aria-label="Aptitude Questions Directory">
                    <thead>
                        <tr>
                            <th scope="col" style="width: 140px;">CODE</th>
                            <th scope="col">QUESTION PROMPT &amp; TOPIC</th>
                            <th scope="col" style="width: 130px;">DIFFICULTY</th>
                            <th scope="col" style="width: 100px;">MARKS</th>
                            <th scope="col" style="width: 110px;">TEST USAGE</th>
                            <th scope="col" style="width: 130px;">STATUS</th>
                            <th scope="col" style="width: 200px; text-align: right;">ACTIONS</th>
                        </tr>
                    </thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <span class="user-id-badge"><%# Eval("Code") %></span>
                    </td>
                    <td>
                        <div class="user-identity">
                            <div class="user-identity-meta">
                                <span class="user-name" style="font-weight: 500; color: #0f172a;"><%# Eval("PromptSnippet") %></span>
                                <span class="user-dept" style="display: inline-block; margin-top: 4px; color: #0284c7; background: #e0f2fe; padding: 2px 8px; border-radius: 4px; font-size: 11px; font-weight: 600;">
                                    <%# Eval("Topic") %>
                                </span>
                            </div>
                        </div>
                    </td>
                    <td>
                        <span class='<%# Eval("DifficultyClass") %>'><%# Eval("Difficulty") %></span>
                    </td>
                    <td>
                        <span style="font-weight: 600; color: #0f172a;">+<%# Eval("Marks") %></span>
                        <span style="font-size: 11px; color: #94a3b8;">/ -<%# string.Format("{0:0.00}", Eval("NegativeMarks")) %></span>
                    </td>
                    <td>
                        <span style="font-size: 12px; font-weight: 500; color: #475569;"><%# Eval("UsageCount") %> tests</span>
                    </td>
                    <td>
                        <span class='<%# Eval("StatusClass") %>'><%# Eval("ValidationStatus") %></span>
                    </td>
                    <td style="text-align: right;">
                        <div class="user-actions" style="justify-content: flex-end;">
                            <asp:LinkButton ID="btnPreview" runat="server" CssClass="user-row-btn"
                                CommandName="Preview" CommandArgument='<%# Eval("QuestionId") %>' CausesValidation="false">
                                Preview
                            </asp:LinkButton>
                            <a href='AptitudeQuestionEditor.aspx?id=<%# Eval("QuestionId") %>' class="user-row-btn">
                                Edit
                            </a>
                            <asp:LinkButton ID="btnAudit" runat="server" CssClass="user-row-btn"
                                CommandName="ToggleAudit" CommandArgument='<%# Eval("QuestionId") %>' CausesValidation="false">
                                Audit
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" runat="server" CssClass="user-row-btn user-row-btn-danger"
                                CommandName="DeleteQuestion" CommandArgument='<%# Eval("QuestionId") %>' CausesValidation="false"
                                OnClientClick="return confirm('Are you sure you want to delete this aptitude question?');">
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
            <p>No aptitude questions matched your search or filter criteria.</p>
            <asp:LinkButton ID="btnEmptyReset" runat="server" CssClass="action-button" OnClick="btnReset_Click">
                Reset Filters
            </asp:LinkButton>
        </asp:Panel>

        <!-- Pagination Bar -->
        <div class="users-pagination">
            <div class="users-pagination-left">
                Showing <asp:Literal ID="litShowingStart" runat="server" Text="1" />
                to <asp:Literal ID="litShowingEnd" runat="server" Text="10" />
                of <asp:Literal ID="litTotalCount" runat="server" Text="1,240" /> questions
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

    <!-- Preview Modal -->
    <asp:Panel ID="pnlPreviewModal" runat="server" Visible="false" CssClass="users-modal-backdrop">
        <div class="users-modal users-modal-large" role="dialog" aria-modal="true" aria-labelledby="previewModalTitle">
            <div class="users-modal-header">
                <div>
                    <span class="user-id-badge"><asp:Literal ID="litPreviewCode" runat="server" /></span>
                    <span style="margin-left: 8px; font-size: 13px; color: #64748b; font-weight: 500;">
                        <asp:Literal ID="litPreviewTopic" runat="server" /> &middot; <asp:Literal ID="litPreviewDifficulty" runat="server" />
                    </span>
                </div>
                <asp:LinkButton ID="btnClosePreview" runat="server" CssClass="users-modal-close"
                    OnClick="btnClosePreview_Click" CausesValidation="false" aria-label="Close">&times;</asp:LinkButton>
            </div>
            <div class="users-modal-body">
                <h3 id="previewModalTitle" style="font-size: 16px; font-weight: 600; color: #0f172a; margin-bottom: 16px; line-height: 1.5;">
                    <asp:Literal ID="litPreviewPrompt" runat="server" />
                </h3>

                <div style="display: flex; flex-direction: column; gap: 10px; margin-bottom: 20px;">
                    <div id="optACard" runat="server" class="option-preview-card">
                        <span class="opt-indicator">A</span>
                        <span class="opt-text"><asp:Literal ID="litOptA" runat="server" /></span>
                    </div>
                    <div id="optBCard" runat="server" class="option-preview-card">
                        <span class="opt-indicator">B</span>
                        <span class="opt-text"><asp:Literal ID="litOptB" runat="server" /></span>
                    </div>
                    <div id="optCCard" runat="server" class="option-preview-card">
                        <span class="opt-indicator">C</span>
                        <span class="opt-text"><asp:Literal ID="litOptC" runat="server" /></span>
                    </div>
                    <div id="optDCard" runat="server" class="option-preview-card">
                        <span class="opt-indicator">D</span>
                        <span class="opt-text"><asp:Literal ID="litOptD" runat="server" /></span>
                    </div>
                </div>

                <div style="background: #f8fafc; border-left: 4px solid #0d9488; padding: 14px 16px; border-radius: 6px; margin-bottom: 16px;">
                    <div style="font-size: 12px; font-weight: 700; color: #0d9488; text-transform: uppercase; margin-bottom: 4px;">Correct Answer &amp; Detailed Explanation</div>
                    <div style="font-size: 13px; color: #334155; line-height: 1.6;">
                        <asp:Literal ID="litPreviewExplanation" runat="server" />
                    </div>
                </div>

                <div style="display: flex; justify-content: space-between; font-size: 12px; color: #64748b; padding-top: 12px; border-top: 1px solid #e2e8f0;">
                    <span>Weightage: <strong><asp:Literal ID="litPreviewMarks" runat="server" /> marks</strong> (Negative: <asp:Literal ID="litPreviewNeg" runat="server" />)</span>
                    <span>Validation Status: <strong><asp:Literal ID="litPreviewStatus" runat="server" /></strong></span>
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

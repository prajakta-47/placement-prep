<%@ Page Title="Question Bank" Language="C#" MasterPageFile="~/Admin.Master"
    AutoEventWireup="true" CodeBehind="QuestionBank.aspx.cs"
    Inherits="PlacementPrep.QuestionBank" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="users-page-container">
    <asp:HiddenField ID="hfSelectedCategory" runat="server" Value="All" />
    <asp:HiddenField ID="hfPageIndex" runat="server" Value="1" />
    <asp:HiddenField ID="hfEditQuestionId" runat="server" Value="0" />

    <!-- Breadcrumb & Page Header -->
    <div class="users-header">
        <div>
            <div class="users-breadcrumb">
                <span>ASSESSMENT ENGINE</span>
                <span class="users-sep">/</span>
                <span>Central Question Repository</span>
            </div>
            <h1 class="users-title">Question Bank</h1>
            <p class="users-subtitle">Curate, audit, and organize aptitude, technical domain, and algorithmic coding challenges across academic cohorts.</p>
        </div>
        <div class="users-top-actions">
            <a href="AptitudeQuestions.aspx" class="action-button">
                <span>Aptitude Bank</span>
            </a>
            <a href="TechnicalQuestions.aspx" class="action-button">
                <span>Technical Bank</span>
            </a>
            <a href="CodingQuestions.aspx" class="action-button">
                <span>Coding Bank</span>
            </a>
            <asp:LinkButton ID="btnOpenImport" runat="server" CssClass="action-button secondary" OnClick="btnOpenImport_Click" CausesValidation="false">
                <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                    <polyline points="17 8 12 3 7 8"></polyline>
                    <line x1="12" y1="3" x2="12" y2="15"></line>
                </svg>
                <span>Import CSV</span>
            </asp:LinkButton>
            <asp:LinkButton ID="btnOpenAdd" runat="server" CssClass="action-button primary" OnClick="btnOpenAdd_Click" CausesValidation="false">
                <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <line x1="12" y1="5" x2="12" y2="19"></line>
                    <line x1="5" y1="12" x2="19" y2="12"></line>
                </svg>
                <span>Add Question</span>
            </asp:LinkButton>
        </div>
    </div>

    <!-- Alert / Feedback Message -->
    <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="users-alert" role="status">
        <asp:Literal ID="litMessage" runat="server" />
    </asp:Panel>

    <!-- KPI Cards Grid -->
    <div class="users-kpi-grid">
        <article class="users-kpi-card">
            <div class="users-kpi-top">
                <span class="users-kpi-label">TOTAL ITEMS</span>
                <span class="users-kpi-icon users-kpi-icon-blue">
                    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path>
                        <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"></path>
                    </svg>
                </span>
            </div>
            <div class="users-kpi-value">
                <asp:Literal ID="litTotalItems" runat="server" Text="2,486" />
            </div>
            <div class="users-kpi-meta">
                <strong class="users-kpi-good">&uarr;98.4%</strong> &middot; verified solution keys
            </div>
        </article>

        <article class="users-kpi-card">
            <div class="users-kpi-top">
                <span class="users-kpi-label">APTITUDE QUESTIONS</span>
                <span class="users-kpi-icon users-kpi-icon-teal">
                    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <rect x="4" y="2" width="16" height="20" rx="2"></rect>
                        <line x1="8" y1="6" x2="16" y2="6"></line>
                        <line x1="16" y1="14" x2="16" y2="18"></line>
                        <path d="M8 10h.01"></path><path d="M12 10h.01"></path><path d="M16 10h.01"></path>
                        <path d="M8 14h.01"></path><path d="M12 14h.01"></path><path d="M8 18h.01"></path><path d="M12 18h.01"></path>
                    </svg>
                </span>
            </div>
            <div class="users-kpi-value">
                <asp:Literal ID="litAptitudeCount" runat="server" Text="1,240" />
            </div>
            <div class="users-kpi-meta">
                <a href="AptitudeQuestions.aspx" style="color: #0d9488; font-weight: 600; text-decoration: none;">Manage Aptitude Bank &rarr;</a>
            </div>
        </article>

        <article class="users-kpi-card">
            <div class="users-kpi-top">
                <span class="users-kpi-label">TECHNICAL DOMAIN</span>
                <span class="users-kpi-icon users-kpi-icon-mint">
                    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon>
                    </svg>
                </span>
            </div>
            <div class="users-kpi-value">
                <asp:Literal ID="litTechnicalCount" runat="server" Text="856" />
            </div>
            <div class="users-kpi-meta">
                <a href="TechnicalQuestions.aspx" style="color: #0d9488; font-weight: 600; text-decoration: none;">Manage Technical Bank &rarr;</a>
            </div>
        </article>

        <article class="users-kpi-card">
            <div class="users-kpi-top">
                <span class="users-kpi-label">CODING CHALLENGES</span>
                <span class="users-kpi-icon users-kpi-icon-blue">
                    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <polyline points="16 18 22 12 16 6"></polyline>
                        <polyline points="8 6 2 12 8 18"></polyline>
                    </svg>
                </span>
            </div>
            <div class="users-kpi-value">
                <asp:Literal ID="litCodingCount" runat="server" Text="390" />
            </div>
            <div class="users-kpi-meta">
                <a href="CodingQuestions.aspx" style="color: #2563eb; font-weight: 600; text-decoration: none;">Manage Coding Bank &rarr;</a>
            </div>
        </article>
    </div>

    <!-- Category Tabs -->
    <div class="qb-tabs-bar">
        <asp:LinkButton ID="btnTabAll" runat="server" CssClass="qb-tab active" OnClick="btnTab_Click" CommandArgument="All" CausesValidation="false">
            All Questions <span class="qb-tab-count">2,486</span>
        </asp:LinkButton>
        <asp:LinkButton ID="btnTabAptitude" runat="server" CssClass="qb-tab" OnClick="btnTab_Click" CommandArgument="Aptitude" CausesValidation="false">
            Aptitude Bank <span class="qb-tab-count">1,240</span>
        </asp:LinkButton>
        <asp:LinkButton ID="btnTabTechnical" runat="server" CssClass="qb-tab" OnClick="btnTab_Click" CommandArgument="Technical" CausesValidation="false">
            Technical Domain <span class="qb-tab-count">856</span>
        </asp:LinkButton>
        <asp:LinkButton ID="btnTabCoding" runat="server" CssClass="qb-tab" OnClick="btnTab_Click" CommandArgument="Coding" CausesValidation="false">
            Coding Challenges <span class="qb-tab-count">390</span>
        </asp:LinkButton>
    </div>

    <!-- Filters Toolbar -->
    <div class="users-filter-bar">
        <div class="users-search-field">
            <span class="users-search-icon" aria-hidden="true">
                <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="11" cy="11" r="8"></circle>
                    <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                </svg>
            </span>
            <asp:TextBox ID="txtSearch" runat="server" CssClass="users-search-input"
                placeholder="Search questions by prompt, topic, or question ID..." />
        </div>
        <asp:DropDownList ID="ddlCategoryFilter" runat="server" CssClass="users-filter-select">
            <asp:ListItem Text="All Categories" Value="All" />
            <asp:ListItem Text="Aptitude" Value="Aptitude" />
            <asp:ListItem Text="Technical" Value="Technical" />
            <asp:ListItem Text="Coding" Value="Coding" />
        </asp:DropDownList>
        <asp:DropDownList ID="ddlDifficultyFilter" runat="server" CssClass="users-filter-select">
            <asp:ListItem Text="All Difficulties" Value="All" />
            <asp:ListItem Text="Easy" Value="Easy" />
            <asp:ListItem Text="Medium" Value="Medium" />
            <asp:ListItem Text="Hard" Value="Hard" />
        </asp:DropDownList>
        <asp:DropDownList ID="ddlStatusFilter" runat="server" CssClass="users-filter-select">
            <asp:ListItem Text="All Status" Value="All" />
            <asp:ListItem Text="Verified" Value="Verified" />
            <asp:ListItem Text="Review Needed" Value="Review Needed" />
            <asp:ListItem Text="Draft" Value="Draft" />
        </asp:DropDownList>
        <asp:LinkButton ID="btnApplyFilters" runat="server" CssClass="users-filter-button"
            OnClick="btnApplyFilters_Click" CausesValidation="false" ToolTip="Apply filters">
            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3"></polygon>
            </svg>
        </asp:LinkButton>
        <asp:LinkButton ID="btnResetFilters" runat="server" CssClass="action-button secondary compact-btn"
            OnClick="btnResetFilters_Click" CausesValidation="false" ToolTip="Reset filters">
            Reset
        </asp:LinkButton>
    </div>

    <!-- Questions Data Table -->
    <div class="users-table-panel">
        <asp:Repeater ID="rptQuestions" runat="server" OnItemCommand="rptQuestions_ItemCommand">
            <HeaderTemplate>
                <div class="table-scroll">
                <table class="users-table">
                    <thead>
                        <tr>
                            <th style="width: 120px;">Code / ID</th>
                            <th>Question Prompt &amp; Topic</th>
                            <th style="width: 110px;">Category</th>
                            <th style="width: 90px;">Difficulty</th>
                            <th style="width: 70px;">Usage</th>
                            <th style="width: 110px;">Status</th>
                            <th style="width: 160px;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <strong class="qb-code"><%# Server.HtmlEncode(Convert.ToString(Eval("Code"))) %></strong>
                    </td>
                    <td>
                        <div class="qb-prompt-container">
                            <span class="qb-prompt-text"><%# Server.HtmlEncode(Convert.ToString(Eval("PromptSnippet"))) %></span>
                            <span class="qb-topic-chip"><%# Server.HtmlEncode(Convert.ToString(Eval("Topic"))) %></span>
                        </div>
                    </td>
                    <td>
                        <span class='<%# Eval("CategoryClass") %>'>
                            <%# Server.HtmlEncode(Convert.ToString(Eval("Category"))) %>
                        </span>
                    </td>
                    <td>
                        <span class='<%# Eval("DifficultyClass") %>'>
                            <%# Server.HtmlEncode(Convert.ToString(Eval("Difficulty"))) %>
                        </span>
                    </td>
                    <td>
                        <span class="qb-usage-count"><%# Eval("UsageCount") %> tests</span>
                    </td>
                    <td>
                        <span class='<%# Eval("StatusClass") %>'>
                            <i></i><%# Server.HtmlEncode(Convert.ToString(Eval("ValidationStatus"))) %>
                        </span>
                    </td>
                    <td class="users-actions">
                        <asp:LinkButton ID="lnkPreview" runat="server" CssClass="table-link"
                            CommandName="PreviewQuestion" CommandArgument='<%# Eval("QuestionId") %>'
                            CausesValidation="false">Preview</asp:LinkButton>
                        <asp:LinkButton ID="lnkEdit" runat="server" CssClass="table-link"
                            CommandName="EditQuestion" CommandArgument='<%# Eval("QuestionId") %>'
                            CausesValidation="false">Edit</asp:LinkButton>
                        <asp:LinkButton ID="lnkToggle" runat="server" CssClass="table-link"
                            CommandName="ToggleStatus" CommandArgument='<%# Eval("QuestionId") %>'
                            CausesValidation="false">Audit</asp:LinkButton>
                        <asp:LinkButton ID="lnkDelete" runat="server" CssClass="table-link text-danger"
                            CommandName="DeleteQuestion" CommandArgument='<%# Eval("QuestionId") %>'
                            CausesValidation="false"
                            OnClientClick="return confirm('Remove this question from the repository?');">Delete</asp:LinkButton>
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
            No questions found matching your filter criteria.
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

    <!-- Add / Edit Question Modal -->
    <asp:Panel ID="pnlQuestionModal" runat="server" Visible="false" CssClass="users-modal-backdrop">
        <div class="users-modal users-modal-large" role="dialog" aria-modal="true" aria-labelledby="questionModalTitle">
            <div class="users-modal-header">
                <h2 id="questionModalTitle"><asp:Literal ID="litModalTitle" runat="server" Text="Add Question" /></h2>
                <asp:LinkButton ID="btnCloseModal" runat="server" CssClass="users-modal-close"
                    OnClick="btnCloseModal_Click" CausesValidation="false" aria-label="Close">&times;</asp:LinkButton>
            </div>
            <div class="users-modal-body">
                <asp:ValidationSummary ID="valSummaryQuestion" runat="server" CssClass="users-validation"
                    ValidationGroup="QuestionForm" HeaderText="Please address the following requirements:" />

                <div class="users-form-grid">
                    <div class="users-field">
                        <label for="<%= txtQuestionCode.ClientID %>">Question Code / ID</label>
                        <asp:TextBox ID="txtQuestionCode" runat="server" MaxLength="50" placeholder="e.g. QB-APT-1005" />
                    </div>
                    <div class="users-field">
                        <label for="<%= ddlFormCategory.ClientID %>">Category</label>
                        <asp:DropDownList ID="ddlFormCategory" runat="server">
                            <asp:ListItem Text="Aptitude" Value="Aptitude" />
                            <asp:ListItem Text="Technical" Value="Technical" />
                            <asp:ListItem Text="Coding" Value="Coding" />
                        </asp:DropDownList>
                    </div>
                    <div class="users-field">
                        <label for="<%= txtFormTopic.ClientID %>">Topic / Domain</label>
                        <asp:TextBox ID="txtFormTopic" runat="server" MaxLength="100" placeholder="e.g. Dynamic Programming, Quantitative" />
                        <asp:RequiredFieldValidator ID="rfvTopic" runat="server"
                            ControlToValidate="txtFormTopic" ValidationGroup="QuestionForm"
                            ErrorMessage="Topic / Domain is required." Display="Dynamic" CssClass="field-error" />
                    </div>
                    <div class="users-field">
                        <label for="<%= ddlFormDifficulty.ClientID %>">Difficulty</label>
                        <asp:DropDownList ID="ddlFormDifficulty" runat="server">
                            <asp:ListItem Text="Easy" Value="Easy" />
                            <asp:ListItem Text="Medium" Value="Medium" Selected="True" />
                            <asp:ListItem Text="Hard" Value="Hard" />
                        </asp:DropDownList>
                    </div>

                    <div class="users-field users-field-span">
                        <label for="<%= txtFormPrompt.ClientID %>">Question Prompt / Statement</label>
                        <asp:TextBox ID="txtFormPrompt" runat="server" TextMode="MultiLine" Rows="3" MaxLength="2000"
                            placeholder="Enter the complete question statement, problem description, or code prompt..." />
                        <asp:RequiredFieldValidator ID="rfvPrompt" runat="server"
                            ControlToValidate="txtFormPrompt" ValidationGroup="QuestionForm"
                            ErrorMessage="Question prompt cannot be empty." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field">
                        <label for="<%= txtOptionA.ClientID %>">Option A</label>
                        <asp:TextBox ID="txtOptionA" runat="server" MaxLength="500" placeholder="Choice A" />
                        <asp:RequiredFieldValidator ID="rfvOptionA" runat="server"
                            ControlToValidate="txtOptionA" ValidationGroup="QuestionForm"
                            ErrorMessage="Option A is required." Display="Dynamic" CssClass="field-error" />
                    </div>
                    <div class="users-field">
                        <label for="<%= txtOptionB.ClientID %>">Option B</label>
                        <asp:TextBox ID="txtOptionB" runat="server" MaxLength="500" placeholder="Choice B" />
                        <asp:RequiredFieldValidator ID="rfvOptionB" runat="server"
                            ControlToValidate="txtOptionB" ValidationGroup="QuestionForm"
                            ErrorMessage="Option B is required." Display="Dynamic" CssClass="field-error" />
                    </div>
                    <div class="users-field">
                        <label for="<%= txtOptionC.ClientID %>">Option C</label>
                        <asp:TextBox ID="txtOptionC" runat="server" MaxLength="500" placeholder="Choice C" />
                    </div>
                    <div class="users-field">
                        <label for="<%= txtOptionD.ClientID %>">Option D</label>
                        <asp:TextBox ID="txtOptionD" runat="server" MaxLength="500" placeholder="Choice D" />
                    </div>

                    <div class="users-field">
                        <label for="<%= ddlCorrectOption.ClientID %>">Correct Answer Key</label>
                        <asp:DropDownList ID="ddlCorrectOption" runat="server">
                            <asp:ListItem Text="Option A" Value="A" />
                            <asp:ListItem Text="Option B" Value="B" />
                            <asp:ListItem Text="Option C" Value="C" />
                            <asp:ListItem Text="Option D" Value="D" />
                        </asp:DropDownList>
                    </div>
                    <div class="users-field">
                        <label for="<%= ddlFormStatus.ClientID %>">Validation Status</label>
                        <asp:DropDownList ID="ddlFormStatus" runat="server">
                            <asp:ListItem Text="Verified" Value="Verified" />
                            <asp:ListItem Text="Review Needed" Value="Review Needed" />
                            <asp:ListItem Text="Draft" Value="Draft" />
                        </asp:DropDownList>
                    </div>

                    <div class="users-field">
                        <label for="<%= txtMarks.ClientID %>">Marks / Weightage</label>
                        <asp:TextBox ID="txtMarks" runat="server" Text="2" MaxLength="3" />
                    </div>
                    <div class="users-field">
                        <label for="<%= txtNegativeMarks.ClientID %>">Negative Marks</label>
                        <asp:TextBox ID="txtNegativeMarks" runat="server" Text="0.5" MaxLength="4" />
                    </div>

                    <div class="users-field users-field-span">
                        <label for="<%= txtExplanation.ClientID %>">Detailed Solution / Explanation</label>
                        <asp:TextBox ID="txtExplanation" runat="server" TextMode="MultiLine" Rows="2" MaxLength="2000"
                            placeholder="Explanation of the solution steps or algorithmic rationale shown after assessment submission..." />
                    </div>
                </div>
            </div>
            <div class="users-modal-footer">
                <asp:LinkButton ID="btnCancelModal" runat="server" CssClass="action-button"
                    OnClick="btnCloseModal_Click" CausesValidation="false">Cancel</asp:LinkButton>
                <asp:LinkButton ID="btnSaveQuestion" runat="server" CssClass="action-button primary"
                    OnClick="btnSaveQuestion_Click" ValidationGroup="QuestionForm">Save Question</asp:LinkButton>
            </div>
        </div>
    </asp:Panel>

    <!-- Preview Modal -->
    <asp:Panel ID="pnlPreviewModal" runat="server" Visible="false" CssClass="users-modal-backdrop">
        <div class="users-modal users-modal-large" role="dialog" aria-modal="true" aria-labelledby="previewModalTitle">
            <div class="users-modal-header">
                <h2 id="previewModalTitle">Question Details</h2>
                <asp:LinkButton ID="btnClosePreview" runat="server" CssClass="users-modal-close"
                    OnClick="btnClosePreview_Click" CausesValidation="false" aria-label="Close">&times;</asp:LinkButton>
            </div>
            <div class="users-modal-body qb-preview-body">
                <div class="qb-preview-meta-row">
                    <span class="qb-code-pill"><asp:Literal ID="litPrevCode" runat="server" /></span>
                    <span class="cat-badge cat-tech"><asp:Literal ID="litPrevCategory" runat="server" /></span>
                    <span class="qb-topic-pill"><asp:Literal ID="litPrevTopic" runat="server" /></span>
                    <span class="diff-badge diff-medium"><asp:Literal ID="litPrevDifficulty" runat="server" /></span>
                    <span class="qb-weight-pill">Marks: <asp:Literal ID="litPrevMarks" runat="server" /> (Neg: -<asp:Literal ID="litPrevNegMarks" runat="server" />)</span>
                </div>

                <div class="qb-preview-section">
                    <h3 class="qb-section-heading">Question Prompt</h3>
                    <div class="qb-prompt-box">
                        <asp:Literal ID="litPrevPrompt" runat="server" />
                    </div>
                </div>

                <div class="qb-preview-section">
                    <h3 class="qb-section-heading">Answer Options</h3>
                    <div class="qb-options-grid">
                        <div id="prevOptA" runat="server" class="qb-option-card">
                            <span class="qb-opt-letter">A</span>
                            <span class="qb-opt-text"><asp:Literal ID="litPrevOptA" runat="server" /></span>
                        </div>
                        <div id="prevOptB" runat="server" class="qb-option-card">
                            <span class="qb-opt-letter">B</span>
                            <span class="qb-opt-text"><asp:Literal ID="litPrevOptB" runat="server" /></span>
                        </div>
                        <div id="prevOptC" runat="server" class="qb-option-card">
                            <span class="qb-opt-letter">C</span>
                            <span class="qb-opt-text"><asp:Literal ID="litPrevOptC" runat="server" /></span>
                        </div>
                        <div id="prevOptD" runat="server" class="qb-option-card">
                            <span class="qb-opt-letter">D</span>
                            <span class="qb-opt-text"><asp:Literal ID="litPrevOptD" runat="server" /></span>
                        </div>
                    </div>
                </div>

                <div class="qb-preview-section">
                    <h3 class="qb-section-heading">Verified Key &amp; Solution Rationale</h3>
                    <div class="qb-explanation-box">
                        <div class="qb-correct-badge">Correct Key: <strong>Option <asp:Literal ID="litPrevCorrect" runat="server" /></strong></div>
                        <p class="qb-explanation-text"><asp:Literal ID="litPrevExplanation" runat="server" /></p>
                    </div>
                </div>
            </div>
            <div class="users-modal-footer">
                <asp:LinkButton ID="btnDismissPreview" runat="server" CssClass="action-button primary"
                    OnClick="btnClosePreview_Click" CausesValidation="false">Close Preview</asp:LinkButton>
            </div>
        </div>
    </asp:Panel>

    <!-- Import Modal -->
    <asp:Panel ID="pnlImportModal" runat="server" Visible="false" CssClass="users-modal-backdrop">
        <div class="users-modal" role="dialog" aria-modal="true" aria-labelledby="qbImportModalTitle">
            <div class="users-modal-header">
                <h2 id="qbImportModalTitle">Import Questions (CSV)</h2>
                <asp:LinkButton ID="btnCloseImport" runat="server" CssClass="users-modal-close"
                    OnClick="btnCloseImport_Click" CausesValidation="false" aria-label="Close">&times;</asp:LinkButton>
            </div>
            <div class="users-modal-body">
                <p class="users-hint">
                    Required CSV columns: <code>Code,Category,Topic,Difficulty,Prompt,OptionA,OptionB,OptionC,OptionD,CorrectOption,Marks</code>.
                    Questions are verified automatically upon bulk import.
                </p>
                <div class="users-field">
                    <label for="<%= fuImport.ClientID %>">Select CSV Question File</label>
                    <asp:FileUpload ID="fuImport" runat="server" CssClass="users-file" accept=".csv,text/csv" />
                </div>
                <asp:Panel ID="pnlImportResult" runat="server" Visible="false" CssClass="users-import-result">
                    <asp:Literal ID="litImportResult" runat="server" />
                </asp:Panel>
            </div>
            <div class="users-modal-footer">
                <asp:LinkButton ID="btnCancelImport" runat="server" CssClass="action-button"
                    OnClick="btnCloseImport_Click" CausesValidation="false">Close</asp:LinkButton>
                <asp:LinkButton ID="btnRunImport" runat="server" CssClass="action-button primary"
                    OnClick="btnRunImport_Click" CausesValidation="false">Import CSV</asp:LinkButton>
            </div>
        </div>
    </asp:Panel>

</div>
</asp:Content>

<%@ Page Title="User Management" Language="C#" MasterPageFile="~/Admin.Master"
    AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs"
    Inherits="PlacementPrep.ManageUsers" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="users-page">

    <asp:HiddenField ID="hfEditUserId" runat="server" Value="0" />
    <asp:HiddenField ID="hfPageIndex" runat="server" Value="1" />

    <div class="command-label">
        IDENTITY &amp; ACCESS MANAGEMENT <span>/ Directory Authority</span>
    </div>

    <div class="dashboard-heading-row">
        <div class="dashboard-heading">
            <h1>User Management</h1>
            <p>Manage platform users, roles, permissions, and account status across academic departments and placement administrative cells.</p>
        </div>
        <div class="heading-actions">
            <asp:LinkButton ID="btnOpenImport" runat="server" CssClass="action-button" OnClick="btnOpenImport_Click" CausesValidation="false">
                <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                    <polyline points="17 8 12 3 7 8"></polyline>
                    <line x1="12" y1="3" x2="12" y2="15"></line>
                </svg>
                <span>Import Users</span>
            </asp:LinkButton>
            <asp:LinkButton ID="btnOpenAdd" runat="server" CssClass="action-button primary" OnClick="btnOpenAdd_Click" CausesValidation="false">
                <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <path d="M16 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                    <circle cx="8.5" cy="7" r="4"></circle>
                    <line x1="20" y1="8" x2="20" y2="14"></line>
                    <line x1="23" y1="11" x2="17" y2="11"></line>
                </svg>
                <span>Add User</span>
            </asp:LinkButton>
        </div>
    </div>

    <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="users-alert" role="status">
        <asp:Literal ID="litMessage" runat="server" />
    </asp:Panel>

    <!-- KPI cards -->
    <div class="users-kpi-grid">
        <article class="users-kpi-card">
            <div class="users-kpi-top">
                <span class="users-kpi-label">TOTAL ACCOUNTS</span>
                <span class="users-kpi-icon users-kpi-icon-blue">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                        <circle cx="9" cy="7" r="4"></circle>
                        <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                        <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                    </svg>
                </span>
            </div>
            <div class="users-kpi-value">
                <asp:Literal ID="litTotalAccounts" runat="server" Text="0" />
            </div>
            <div class="users-kpi-meta">
                <asp:Literal ID="litTotalMeta" runat="server" />
            </div>
        </article>

        <article class="users-kpi-card">
            <div class="users-kpi-top">
                <span class="users-kpi-label">FACULTY MEMBERS</span>
                <span class="users-kpi-icon users-kpi-icon-teal">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                        <circle cx="12" cy="7" r="4"></circle>
                    </svg>
                </span>
            </div>
            <div class="users-kpi-value">
                <asp:Literal ID="litFacultyCount" runat="server" Text="0" />
            </div>
            <div class="users-kpi-meta">
                <asp:Literal ID="litFacultyMeta" runat="server" />
            </div>
        </article>

        <article class="users-kpi-card">
            <div class="users-kpi-top">
                <span class="users-kpi-label">ENROLLED STUDENTS</span>
                <span class="users-kpi-icon users-kpi-icon-mint">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M22 10v6M2 10l10-5 10 5-10 5z"></path>
                        <path d="M6 12v5c3 3 9 3 12 0v-5"></path>
                    </svg>
                </span>
            </div>
            <div class="users-kpi-value">
                <asp:Literal ID="litStudentCount" runat="server" Text="0" />
            </div>
            <div class="users-kpi-meta">
                <asp:Literal ID="litStudentMeta" runat="server" />
            </div>
            <div class="users-kpi-bar" aria-hidden="true">
                <span id="studentBar" runat="server"></span>
            </div>
        </article>

        <article class="users-kpi-card">
            <div class="users-kpi-top">
                <span class="users-kpi-label">ADMINISTRATORS</span>
                <span class="users-kpi-icon users-kpi-icon-blue">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
                    </svg>
                </span>
            </div>
            <div class="users-kpi-value">
                <asp:Literal ID="litAdminCount" runat="server" Text="0" />
            </div>
            <div class="users-kpi-meta">
                <strong class="users-kpi-good">Audited</strong> - 2FA Enforced - 100% compliant
            </div>
        </article>
    </div>

    <!-- Filters -->
    <div class="users-filter-bar">
        <div class="users-search-field">
            <span class="users-search-icon" aria-hidden="true">
                <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="11" cy="11" r="8"></circle>
                    <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                </svg>
            </span>
            <asp:TextBox ID="txtSearch" runat="server" CssClass="users-search-input"
                placeholder="Search by name, email, or user ID..." />
        </div>
        <asp:DropDownList ID="ddlRole" runat="server" CssClass="users-filter-select">
            <asp:ListItem Text="All Roles" Value="All" />
            <asp:ListItem Text="Student" Value="Student" />
            <asp:ListItem Text="Faculty" Value="Faculty" />
            <asp:ListItem Text="Admin" Value="Admin" />
        </asp:DropDownList>
        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="users-filter-select">
            <asp:ListItem Text="All Status" Value="All" />
            <asp:ListItem Text="Active" Value="Active" />
            <asp:ListItem Text="Suspended" Value="Suspended" />
        </asp:DropDownList>
        <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="users-filter-select" />
        <asp:LinkButton ID="btnApplyFilters" runat="server" CssClass="users-filter-button"
            OnClick="btnApplyFilters_Click" CausesValidation="false" ToolTip="Apply filters">
            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3"></polygon>
            </svg>
        </asp:LinkButton>
    </div>

    <!-- User table -->
    <div class="users-table-panel">
        <asp:Repeater ID="rptUsers" runat="server" OnItemCommand="rptUsers_ItemCommand" OnItemDataBound="rptUsers_ItemDataBound">
            <HeaderTemplate>
                <div class="table-scroll">
                <table class="users-table">
                    <thead>
                        <tr>
                            <th>User Identity</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Department</th>
                            <th>Status</th>
                            <th>Last Active</th>
                            <th>Created</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <div class="users-identity">
                            <span class='<%# Eval("AvatarClass") %>'><%# Eval("Initials") %></span>
                            <span>
                                <strong><%# Server.HtmlEncode(Convert.ToString(Eval("FullName"))) %></strong>
                                <small><%# Server.HtmlEncode(Convert.ToString(Eval("DisplayUid"))) %></small>
                            </span>
                        </div>
                    </td>
                    <td><%# Server.HtmlEncode(Convert.ToString(Eval("Email"))) %></td>
                    <td>
                        <span class='<%# "role-badge role-" + Convert.ToString(Eval("UserRole")).ToLowerInvariant() %>'>
                            <%# Server.HtmlEncode(Convert.ToString(Eval("UserRole"))) %>
                        </span>
                    </td>
                    <td><%# Server.HtmlEncode(string.IsNullOrEmpty(Convert.ToString(Eval("Department"))) ? "-" : Convert.ToString(Eval("Department"))) %></td>
                    <td>
                        <span class='<%# "status-pill status-" + Convert.ToString(Eval("AccountStatus")).ToLowerInvariant() %>'>
                            <i></i><%# Server.HtmlEncode(Convert.ToString(Eval("AccountStatus"))) %>
                        </span>
                    </td>
                    <td><%# FormatLastActive((DateTime?)Eval("LastActiveAt")) %></td>
                    <td><%# FormatCreated((DateTime)Eval("CreatedAt")) %></td>
                    <td class="users-actions">
                        <asp:LinkButton ID="lnkEdit" runat="server" CssClass="table-link"
                            CommandName="EditUser" CommandArgument='<%# Eval("UserId") %>'
                            CausesValidation="false">Edit</asp:LinkButton>
                        <asp:LinkButton ID="lnkSuspend" runat="server" CssClass="table-link"
                            CommandName="ToggleStatus" CommandArgument='<%# Eval("UserId") %>'
                            CausesValidation="false"
                            OnClientClick="return confirm('Update account status for this user?');" />
                        <asp:LinkButton ID="lnkReset" runat="server" CssClass="table-link"
                            CommandName="ResetPassword" CommandArgument='<%# Eval("UserId") %>'
                            CausesValidation="false"
                            OnClientClick="return confirm('Generate a new temporary password for this user? The previous password will stop working.');">
                            Reset Password
                        </asp:LinkButton>
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
            No users match the current filters.
        </asp:Panel>

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

    <!-- Add / Edit modal -->
    <asp:Panel ID="pnlUserModal" runat="server" Visible="false" CssClass="users-modal-backdrop">
        <div class="users-modal" role="dialog" aria-modal="true" aria-labelledby="userModalTitle">
            <div class="users-modal-header">
                <h2 id="userModalTitle"><asp:Literal ID="litModalTitle" runat="server" Text="Add User" /></h2>
                <asp:LinkButton ID="btnCloseModal" runat="server" CssClass="users-modal-close"
                    OnClick="btnCloseModal_Click" CausesValidation="false" aria-label="Close">&times;</asp:LinkButton>
            </div>
            <div class="users-modal-body">
                <asp:ValidationSummary ID="valSummary" runat="server" CssClass="users-validation"
                    ValidationGroup="UserForm" HeaderText="Please fix the following:" />

                <div class="users-form-grid">
                    <div class="users-field">
                        <label for="<%= txtFullName.ClientID %>">Full Name</label>
                        <asp:TextBox ID="txtFullName" runat="server" MaxLength="150" />
                        <asp:RequiredFieldValidator ID="rfvFullName" runat="server"
                            ControlToValidate="txtFullName" ValidationGroup="UserForm"
                            ErrorMessage="Full name is required." Display="Dynamic" CssClass="field-error" />
                    </div>
                    <div class="users-field">
                        <label for="<%= txtEmail.ClientID %>">Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" MaxLength="256" TextMode="Email" />
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                            ControlToValidate="txtEmail" ValidationGroup="UserForm"
                            ErrorMessage="Email is required." Display="Dynamic" CssClass="field-error" />
                        <asp:RegularExpressionValidator ID="revEmail" runat="server"
                            ControlToValidate="txtEmail" ValidationGroup="UserForm"
                            ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                            ErrorMessage="Enter a valid email address." Display="Dynamic" CssClass="field-error" />
                    </div>
                    <div class="users-field">
                        <label for="<%= txtEnrollmentId.ClientID %>">Enrollment / User ID</label>
                        <asp:TextBox ID="txtEnrollmentId" runat="server" MaxLength="50" />
                    </div>
                    <div class="users-field">
                        <label for="<%= ddlFormRole.ClientID %>">Role</label>
                        <asp:DropDownList ID="ddlFormRole" runat="server">
                            <asp:ListItem Text="Student" Value="Student" />
                            <asp:ListItem Text="Faculty" Value="Faculty" />
                            <asp:ListItem Text="Admin" Value="Admin" />
                        </asp:DropDownList>
                    </div>
                    <div class="users-field">
                        <label for="<%= txtDepartment.ClientID %>">Department</label>
                        <asp:TextBox ID="txtDepartment" runat="server" MaxLength="100" />
                    </div>
                    <div class="users-field">
                        <label for="<%= ddlFormStatus.ClientID %>">Status</label>
                        <asp:DropDownList ID="ddlFormStatus" runat="server">
                            <asp:ListItem Text="Active" Value="Active" />
                            <asp:ListItem Text="Suspended" Value="Suspended" />
                        </asp:DropDownList>
                    </div>
                    <asp:Panel ID="pnlPasswordFields" runat="server" CssClass="users-field users-field-span">
                        <label for="<%= txtPassword.ClientID %>">Temporary Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" MaxLength="100" autocomplete="new-password" />
                        <small class="users-hint">Minimum 8 characters with uppercase, number, and special character. Stored as a one-way hash only.</small>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                            ControlToValidate="txtPassword" ValidationGroup="UserForm"
                            ErrorMessage="Temporary password is required for new users."
                            Display="Dynamic" CssClass="field-error" Enabled="false" />
                    </asp:Panel>
                </div>
            </div>
            <div class="users-modal-footer">
                <asp:LinkButton ID="btnCancelModal" runat="server" CssClass="action-button"
                    OnClick="btnCloseModal_Click" CausesValidation="false">Cancel</asp:LinkButton>
                <asp:LinkButton ID="btnSaveUser" runat="server" CssClass="action-button primary"
                    OnClick="btnSaveUser_Click" ValidationGroup="UserForm">Save User</asp:LinkButton>
            </div>
        </div>
    </asp:Panel>

    <!-- Import modal -->
    <asp:Panel ID="pnlImportModal" runat="server" Visible="false" CssClass="users-modal-backdrop">
        <div class="users-modal" role="dialog" aria-modal="true" aria-labelledby="importModalTitle">
            <div class="users-modal-header">
                <h2 id="importModalTitle">Import Users (CSV)</h2>
                <asp:LinkButton ID="btnCloseImport" runat="server" CssClass="users-modal-close"
                    OnClick="btnCloseImport_Click" CausesValidation="false" aria-label="Close">&times;</asp:LinkButton>
            </div>
            <div class="users-modal-body">
                <p class="users-hint">
                    Required columns: <code>FullName,Email,UserRole,Department,EnrollmentId</code>.
                    Optional: <code>AccountStatus</code>. Duplicate emails are skipped. Temporary passwords are generated and hashed - plaintext is never stored.
                </p>
                <div class="users-field">
                    <label for="<%= fuImport.ClientID %>">CSV file</label>
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

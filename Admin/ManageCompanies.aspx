<%@ Page Title="Company Management" Language="C#" MasterPageFile="~/Admin.Master"
    AutoEventWireup="true" CodeBehind="ManageCompanies.aspx.cs"
    Inherits="PlacementPrep.ManageCompanies" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Company Management | Placement Prep Admin</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="admin-shell-page">

    <!-- Page Header -->
    <div class="users-header">
        <div>
            <div class="users-breadcrumb">
                <a href="<%= ResolveUrl("~/Admin/AdminDashboard.aspx") %>">Dashboard</a>
                <span>/</span>
                <span>Placement Operations</span>
                <span>/</span>
                <span>Company Management</span>
            </div>
            <h1 class="users-title">Corporate Partners &amp; Company Directory</h1>
            <p class="users-subtitle">
                Manage recruitment relationships, tier categorizations, active placement drives, and verified recruiter contacts.
            </p>
        </div>
        <div class="users-header-actions">
            <a href="<%= ResolveUrl("~/Admin/ManageDrives.aspx") %>" class="action-button">
                <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                    <rect x="3" y="4" width="18" height="18" rx="2" ry="2"/>
                    <line x1="16" y1="2" x2="16" y2="6"/>
                    <line x1="8" y1="2" x2="8" y2="6"/>
                    <line x1="3" y1="10" x2="21" y2="10"/>
                </svg>
                View Placement Drives
            </a>
            <asp:LinkButton ID="btnOpenAddCompany" runat="server" CssClass="action-button primary"
                OnClick="btnOpenAddCompany_Click" CausesValidation="false">
                <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                    <line x1="12" y1="5" x2="12" y2="19"/>
                    <line x1="5" y1="12" x2="19" y2="12"/>
                </svg>
                Add Company Partner
            </asp:LinkButton>
        </div>
    </div>

    <!-- Alert Message Banner -->
    <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="users-alert users-alert-success">
        <asp:Literal ID="litMessage" runat="server" />
    </asp:Panel>

    <!-- 4 Corporate Partner KPI Summary Cards -->
    <div class="users-kpi-grid">
        <div class="users-kpi-card">
            <span class="users-kpi-label">Partner Companies</span>
            <div class="users-kpi-value"><asp:Literal ID="litKpiTotalCompanies" runat="server" Text="0" /></div>
            <span class="users-kpi-sub">Total verified corporate MoUs</span>
        </div>
        <div class="users-kpi-card">
            <span class="users-kpi-label">Actively Hiring</span>
            <div class="users-kpi-value"><asp:Literal ID="litKpiActiveHiring" runat="server" Text="0" /></div>
            <span class="users-kpi-sub">Current placement cycle sponsors</span>
        </div>
        <div class="users-kpi-card">
            <span class="users-kpi-label">Active Drives</span>
            <div class="users-kpi-value"><asp:Literal ID="litKpiActiveDrives" runat="server" Text="0" /></div>
            <span class="users-kpi-sub">Scheduled on-campus drives</span>
        </div>
        <div class="users-kpi-card">
            <span class="users-kpi-label">Total Offers Placed</span>
            <div class="users-kpi-value"><asp:Literal ID="litKpiOffersPlaced" runat="server" Text="0" /></div>
            <span class="users-kpi-sub">Cumulative offers across all drives</span>
        </div>
    </div>

    <!-- Filter & Search Toolbar -->
    <div class="users-filter-bar">
        <asp:HiddenField ID="hfPageIndex" runat="server" Value="1" />
        <asp:HiddenField ID="hfEditCompanyId" runat="server" Value="0" />

        <div class="users-filter-group users-filter-search">
            <label for="<%= txtSearch.ClientID %>">Search Partners</label>
            <asp:TextBox ID="txtSearch" runat="server" placeholder="Company name, industry, recruiter..." />
        </div>

        <div class="users-filter-group">
            <label for="<%= ddlIndustryFilter.ClientID %>">Industry</label>
            <asp:DropDownList ID="ddlIndustryFilter" runat="server" AutoPostBack="true"
                OnSelectedIndexChanged="btnApplyFilters_Click" CssClass="users-filter-select">
                <asp:ListItem Text="All Industries" Value="All" Selected="True" />
            </asp:DropDownList>
        </div>

        <div class="users-filter-group">
            <label for="<%= ddlStatusFilter.ClientID %>">Hiring Status</label>
            <asp:DropDownList ID="ddlStatusFilter" runat="server" AutoPostBack="true"
                OnSelectedIndexChanged="btnApplyFilters_Click" CssClass="users-filter-select">
                <asp:ListItem Text="All Statuses" Value="All" Selected="True" />
                <asp:ListItem Text="Hiring This Season" Value="Hiring This Season" />
                <asp:ListItem Text="Active Partner" Value="Active Partner" />
                <asp:ListItem Text="Upcoming" Value="Upcoming" />
                <asp:ListItem Text="Inactive" Value="Inactive" />
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

    <!-- Company Directory Table -->
    <div class="users-table-panel">
        <asp:Repeater ID="rptCompanies" runat="server" OnItemCommand="rptCompanies_ItemCommand">
            <HeaderTemplate>
                <div class="table-scroll">
                <table class="users-table">
                    <thead>
                        <tr>
                            <th>Company Profile</th>
                            <th>Industry &amp; Locations</th>
                            <th>Recruiter / Campus SPOC</th>
                            <th style="width: 140px;">Hiring Status</th>
                            <th style="width: 100px;">Active Drives</th>
                            <th style="width: 120px;">Compensation</th>
                            <th style="width: 210px;">Actions</th>
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
                                <strong><%# Server.HtmlEncode(Convert.ToString(Eval("CompanyName"))) %></strong>
                                <span class='<%# Eval("TierClass") %>'><%# Eval("Tier") %></span>
                                <%# !string.IsNullOrWhiteSpace(Convert.ToString(Eval("WebsiteUrl"))) 
                                    ? "<br/><a href='" + Server.HtmlEncode(Convert.ToString(Eval("WebsiteUrl"))) + "' target='_blank' rel='noopener' class='table-link' style='font-size:10px;'>Visit Website &nearr;</a>" 
                                    : "" %>
                            </span>
                        </div>
                    </td>
                    <td>
                        <strong><%# Server.HtmlEncode(Convert.ToString(Eval("Industry"))) %></strong>
                        <small class="text-muted" style="display:block;"><%# Server.HtmlEncode(Convert.ToString(Eval("Locations"))) %></small>
                    </td>
                    <td>
                        <strong><%# Server.HtmlEncode(Convert.ToString(Eval("RecruiterName"))) %></strong>
                        <small style="display:block; color:var(--admin-muted);"><%# Server.HtmlEncode(Convert.ToString(Eval("RecruiterEmail"))) %></small>
                        <small style="display:block; color:var(--admin-muted);"><%# Server.HtmlEncode(Convert.ToString(Eval("RecruiterPhone"))) %></small>
                    </td>
                    <td>
                        <span class='<%# Eval("StatusClass") %>'>
                            <i></i><%# Server.HtmlEncode(Convert.ToString(Eval("HiringStatus"))) %>
                        </span>
                    </td>
                    <td>
                        <strong class="qb-usage-count"><%# Eval("ActiveDrivesCount") %> Drives</strong>
                        <small style="display:block; font-size:9px; color:#0b7a58;"><%# Eval("TotalOffersMade") %> Offers Total</small>
                    </td>
                    <td>
                        <strong><%# string.Format("{0:0.0} LPA", Eval("AveragePackageLpa")) %></strong>
                        <small style="display:block; font-size:9px; color:var(--admin-muted);">Max: <%# string.Format("{0:0.0} LPA", Eval("HighestPackageLpa")) %></small>
                    </td>
                    <td class="users-actions">
                        <asp:LinkButton ID="lnkQuickView" runat="server" CssClass="table-link"
                            CommandName="QuickView" CommandArgument='<%# Eval("CompanyId") %>'
                            CausesValidation="false">Quick View</asp:LinkButton>
                        <a href='<%# ResolveUrl("~/Admin/CompanyDetails.aspx?id=" + Eval("CompanyId")) %>' class="table-link">Details &rarr;</a>
                        <asp:LinkButton ID="lnkEdit" runat="server" CssClass="table-link"
                            CommandName="EditCompany" CommandArgument='<%# Eval("CompanyId") %>'
                            CausesValidation="false">Edit</asp:LinkButton>
                        <asp:LinkButton ID="lnkToggleStatus" runat="server" CssClass="table-link"
                            CommandName="ToggleStatus" CommandArgument='<%# Eval("CompanyId") %>'
                            CausesValidation="false">Status</asp:LinkButton>
                        <asp:LinkButton ID="lnkDelete" runat="server" CssClass="table-link text-danger"
                            CommandName="DeleteCompany" CommandArgument='<%# Eval("CompanyId") %>'
                            CausesValidation="false"
                            OnClientClick="return confirm('Permanently remove this company and partner profile?');">Delete</asp:LinkButton>
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
            <p><strong>No corporate partners match the selected filter criteria.</strong></p>
            <p class="text-muted">Try adjusting your industry filter or search query.</p>
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

    <!-- Company Quick View Details Modal -->
    <asp:Panel ID="pnlDetailsModal" runat="server" Visible="false" CssClass="users-modal-backdrop">
        <div class="users-modal users-modal-large" role="dialog" aria-modal="true" aria-labelledby="detailsModalTitle">
            <div class="users-modal-header">
                <h2 id="detailsModalTitle">Corporate Partner Dossier</h2>
                <asp:LinkButton ID="btnCloseDetails" runat="server" CssClass="users-modal-close"
                    OnClick="btnCloseDetails_Click" CausesValidation="false" aria-label="Close">&times;</asp:LinkButton>
            </div>
            <div class="users-modal-body qb-preview-body">
                <div class="dossier-hero">
                    <div class="dossier-avatar"><asp:Literal ID="litDetailsInitials" runat="server" /></div>
                    <div class="dossier-hero-info">
                        <h3><asp:Literal ID="litDetailsName" runat="server" /></h3>
                        <p>
                            <strong><asp:Literal ID="litDetailsIndustry" runat="server" /></strong> &middot;
                            <span><asp:Literal ID="litDetailsLocations" runat="server" /></span> &middot;
                            <a id="lnkDetailsWebsite" runat="server" target="_blank" rel="noopener" class="table-link">Official Career Portal &nearr;</a>
                        </p>
                    </div>
                    <div class="dossier-hero-badges">
                        <span id="badgeDetailsTier" runat="server" class="tier-badge tier-dream"><asp:Literal ID="litDetailsTier" runat="server" /></span>
                        <span id="badgeDetailsStatus" runat="server" class="status-pill status-active"><asp:Literal ID="litDetailsStatus" runat="server" /></span>
                    </div>
                </div>

                <div class="dossier-metrics-grid">
                    <div class="dossier-metric-card">
                        <span class="dossier-metric-num"><asp:Literal ID="litDetailsAvgPackage" runat="server" /> LPA</span>
                        <span class="dossier-metric-lbl">Avg Compensation</span>
                    </div>
                    <div class="dossier-metric-card">
                        <span class="dossier-metric-num"><asp:Literal ID="litDetailsHighestPackage" runat="server" /> LPA</span>
                        <span class="dossier-metric-lbl">Max Compensation</span>
                    </div>
                    <div class="dossier-metric-card">
                        <span class="dossier-metric-num"><asp:Literal ID="litDetailsActiveDrives" runat="server" /></span>
                        <span class="dossier-metric-lbl">Active Drives</span>
                    </div>
                    <div class="dossier-metric-card">
                        <span class="dossier-metric-num"><asp:Literal ID="litDetailsTotalOffers" runat="server" /></span>
                        <span class="dossier-metric-lbl">Cumulative Offers</span>
                    </div>
                </div>

                <!-- Recruiter SPOC Information -->
                <div class="qb-preview-section">
                    <h3 class="qb-section-heading">Institutional Recruitment Contacts</h3>
                    <div class="qb-options-grid">
                        <div class="qb-option-card">
                            <span class="qb-opt-letter">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                            </span>
                            <span class="qb-opt-text">Lead Campus Recruiter: <strong><asp:Literal ID="litDetailsRecruiterName" runat="server" /></strong></span>
                        </div>
                        <div class="qb-option-card">
                            <span class="qb-opt-letter">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path><polyline points="22,6 12,13 2,6"></polyline></svg>
                            </span>
                            <span class="qb-opt-text">Email Address: <strong><asp:Literal ID="litDetailsRecruiterEmail" runat="server" /></strong></span>
                        </div>
                        <div class="qb-option-card">
                            <span class="qb-opt-letter">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path></svg>
                            </span>
                            <span class="qb-opt-text">Phone Contact: <strong><asp:Literal ID="litDetailsRecruiterPhone" runat="server" /></strong></span>
                        </div>
                    </div>
                </div>

                <!-- About Description -->
                <div class="qb-preview-section">
                    <h3 class="qb-section-heading">Company Overview &amp; Profile</h3>
                    <div class="qb-prompt-box">
                        <asp:Literal ID="litDetailsAbout" runat="server" />
                    </div>
                </div>

                <!-- Associated Placement Drives -->
                <div class="qb-preview-section">
                    <h3 class="qb-section-heading">Associated Placement Drives</h3>
                    <asp:Literal ID="litDetailsDrivesHtml" runat="server" />
                </div>

                <div class="users-hint">
                    <strong>Demonstration Sample Data:</strong> This company profile represents simulated university corporate partner information for administrative testing.
                </div>
            </div>
            <div class="users-modal-footer">
                <a id="btnFullDetailsPage" runat="server" class="action-button">Open Dedicated Details Page &rarr;</a>
                <asp:LinkButton ID="btnDismissDetails" runat="server" CssClass="action-button primary"
                    OnClick="btnCloseDetails_Click" CausesValidation="false">Close Dossier</asp:LinkButton>
            </div>
        </div>
    </asp:Panel>

    <!-- Create / Edit Company Modal -->
    <asp:Panel ID="pnlCompanyModal" runat="server" Visible="false" CssClass="users-modal-backdrop">
        <div class="users-modal users-modal-large" role="dialog" aria-modal="true" aria-labelledby="companyModalTitle">
            <div class="users-modal-header">
                <h2 id="companyModalTitle"><asp:Literal ID="litModalTitle" runat="server" Text="Add Corporate Partner" /></h2>
                <asp:LinkButton ID="btnCloseModal" runat="server" CssClass="users-modal-close"
                    OnClick="btnCloseModal_Click" CausesValidation="false" aria-label="Close">&times;</asp:LinkButton>
            </div>
            <div class="users-modal-body">
                <asp:ValidationSummary ID="valSummaryCompany" runat="server" CssClass="users-validation"
                    ValidationGroup="CompanyForm" HeaderText="Please address the following validation errors:" />

                <div class="users-form-grid">
                    <div class="users-field">
                        <label for="<%= txtCompanyName.ClientID %>">Company Name *</label>
                        <asp:TextBox ID="txtCompanyName" runat="server" MaxLength="120" placeholder="e.g. Google India" />
                        <asp:RequiredFieldValidator ID="rfvCompanyName" runat="server"
                            ControlToValidate="txtCompanyName" ValidationGroup="CompanyForm"
                            ErrorMessage="Company name is required." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field">
                        <label for="<%= ddlFormIndustry.ClientID %>">Industry *</label>
                        <asp:DropDownList ID="ddlFormIndustry" runat="server">
                            <asp:ListItem Text="Software &amp; Internet" Value="Software &amp; Internet" Selected="True" />
                            <asp:ListItem Text="Cloud &amp; Enterprise IT" Value="Cloud &amp; Enterprise IT" />
                            <asp:ListItem Text="E-Commerce &amp; Cloud" Value="E-Commerce &amp; Cloud" />
                            <asp:ListItem Text="FinTech &amp; Banking" Value="FinTech &amp; Banking" />
                            <asp:ListItem Text="Consulting &amp; Analytics" Value="Consulting &amp; Analytics" />
                            <asp:ListItem Text="IT Services &amp; Consulting" Value="IT Services &amp; Consulting" />
                            <asp:ListItem Text="Hardware &amp; Embedded" Value="Hardware &amp; Embedded" />
                            <asp:ListItem Text="Manufacturing &amp; Core" Value="Manufacturing &amp; Core" />
                        </asp:DropDownList>
                    </div>

                    <div class="users-field">
                        <label for="<%= ddlFormTier.ClientID %>">Partnership Tier</label>
                        <asp:DropDownList ID="ddlFormTier" runat="server">
                            <asp:ListItem Text="Tier 1 (Dream)" Value="Tier 1 (Dream)" Selected="True" />
                            <asp:ListItem Text="Tier 2" Value="Tier 2" />
                            <asp:ListItem Text="Mass Recruiter" Value="Mass Recruiter" />
                        </asp:DropDownList>
                    </div>

                    <div class="users-field">
                        <label for="<%= ddlFormHiringStatus.ClientID %>">Hiring Status</label>
                        <asp:DropDownList ID="ddlFormHiringStatus" runat="server">
                            <asp:ListItem Text="Hiring This Season" Value="Hiring This Season" Selected="True" />
                            <asp:ListItem Text="Active Partner" Value="Active Partner" />
                            <asp:ListItem Text="Upcoming" Value="Upcoming" />
                            <asp:ListItem Text="Inactive" Value="Inactive" />
                        </asp:DropDownList>
                    </div>

                    <div class="users-field">
                        <label for="<%= txtWebsiteUrl.ClientID %>">Website / Career Portal *</label>
                        <asp:TextBox ID="txtWebsiteUrl" runat="server" MaxLength="200" placeholder="https://careers.example.com" />
                        <asp:RequiredFieldValidator ID="rfvWebsiteUrl" runat="server"
                            ControlToValidate="txtWebsiteUrl" ValidationGroup="CompanyForm"
                            ErrorMessage="Website URL is required." Display="Dynamic" CssClass="field-error" />
                        <asp:RegularExpressionValidator ID="revWebsiteUrl" runat="server"
                            ControlToValidate="txtWebsiteUrl" ValidationGroup="CompanyForm"
                            ValidationExpression="^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$"
                            ErrorMessage="Enter a valid URL (e.g. https://careers.example.com)." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field">
                        <label for="<%= txtRecruiterName.ClientID %>">Campus Recruiter Name *</label>
                        <asp:TextBox ID="txtRecruiterName" runat="server" MaxLength="100" placeholder="e.g. Priyanka Sen" />
                        <asp:RequiredFieldValidator ID="rfvRecruiterName" runat="server"
                            ControlToValidate="txtRecruiterName" ValidationGroup="CompanyForm"
                            ErrorMessage="Recruiter contact name is required." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field">
                        <label for="<%= txtRecruiterEmail.ClientID %>">Recruiter Email *</label>
                        <asp:TextBox ID="txtRecruiterEmail" runat="server" MaxLength="200" TextMode="Email" placeholder="e.g. recruiter@company.com" />
                        <asp:RequiredFieldValidator ID="rfvRecruiterEmail" runat="server"
                            ControlToValidate="txtRecruiterEmail" ValidationGroup="CompanyForm"
                            ErrorMessage="Recruiter email is required." Display="Dynamic" CssClass="field-error" />
                        <asp:RegularExpressionValidator ID="revRecruiterEmail" runat="server"
                            ControlToValidate="txtRecruiterEmail" ValidationGroup="CompanyForm"
                            ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                            ErrorMessage="Enter a valid email address." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field">
                        <label for="<%= txtRecruiterPhone.ClientID %>">Recruiter Phone</label>
                        <asp:TextBox ID="txtRecruiterPhone" runat="server" MaxLength="30" placeholder="e.g. +91 98450 11223" />
                    </div>

                    <div class="users-field">
                        <label for="<%= txtAvgPackage.ClientID %>">Avg Package LPA (0 - 150) *</label>
                        <asp:TextBox ID="txtAvgPackage" runat="server" Text="12.0" MaxLength="6" />
                        <asp:RequiredFieldValidator ID="rfvAvgPackage" runat="server"
                            ControlToValidate="txtAvgPackage" ValidationGroup="CompanyForm"
                            ErrorMessage="Average package is required." Display="Dynamic" CssClass="field-error" />
                        <asp:RangeValidator ID="rvAvgPackage" runat="server"
                            ControlToValidate="txtAvgPackage" ValidationGroup="CompanyForm"
                            Type="Double" MinimumValue="0.0" MaximumValue="150.0"
                            ErrorMessage="Average package must be between 0.0 and 150.0 LPA." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field">
                        <label for="<%= txtHighestPackage.ClientID %>">Highest Package LPA (0 - 150) *</label>
                        <asp:TextBox ID="txtHighestPackage" runat="server" Text="24.0" MaxLength="6" />
                        <asp:RequiredFieldValidator ID="rfvHighestPackage" runat="server"
                            ControlToValidate="txtHighestPackage" ValidationGroup="CompanyForm"
                            ErrorMessage="Highest package is required." Display="Dynamic" CssClass="field-error" />
                        <asp:RangeValidator ID="rvHighestPackage" runat="server"
                            ControlToValidate="txtHighestPackage" ValidationGroup="CompanyForm"
                            Type="Double" MinimumValue="0.0" MaximumValue="150.0"
                            ErrorMessage="Highest package must be between 0.0 and 150.0 LPA." Display="Dynamic" CssClass="field-error" />
                    </div>

                    <div class="users-field users-field-span">
                        <label for="<%= txtLocations.ClientID %>">Operating Campus Locations</label>
                        <asp:TextBox ID="txtLocations" runat="server" MaxLength="200" placeholder="e.g. Bangalore, Hyderabad, Pune, Gurgaon" />
                    </div>

                    <div class="users-field users-field-span">
                        <label for="<%= txtAbout.ClientID %>">Company Overview &amp; Description</label>
                        <asp:TextBox ID="txtAbout" runat="server" TextMode="MultiLine" Rows="3" MaxLength="500" placeholder="Brief mission, technological domain, and engineering culture..." />
                    </div>
                </div>
            </div>
            <div class="users-modal-footer">
                <asp:LinkButton ID="btnCancelModal" runat="server" CssClass="action-button"
                    OnClick="btnCloseModal_Click" CausesValidation="false">Cancel</asp:LinkButton>
                <asp:LinkButton ID="btnSaveCompany" runat="server" CssClass="action-button primary"
                    OnClick="btnSaveCompany_Click" ValidationGroup="CompanyForm">Save Company Partner</asp:LinkButton>
            </div>
        </div>
    </asp:Panel>

</div>
</asp:Content>

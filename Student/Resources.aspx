<%@ Page Title="Learning Resources" Language="C#" MasterPageFile="~/Student.Master"
    AutoEventWireup="true" CodeBehind="Resources.aspx.cs"
    Inherits="PlacementPrep.Resources" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Learning Resources &amp; Guides | Placement Prep</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="student-resources-container">
        
        <!-- Header -->
        <header class="student-aptitude-header">
            <div>
                <div class="student-analyzer-tag" style="margin-bottom:4px;">
                    <span class="tag-dot"></span>
                    <span>CURATED STUDY MATERIALS &bull; PLACEMENT LIBRARY</span>
                </div>
                <h1 style="font-size:22px; font-weight:800; margin:0 0 4px; letter-spacing:-0.5px;">Placement Learning Resources</h1>
                <p style="margin:0; font-size:11px; color:#64748b;">
                    Official cheat sheets, company drive pattern guides, algorithmic problem breakdowns, and interview preparation handbooks.
                </p>
            </div>
        </header>

        <!-- Search & Category Filters -->
        <div class="student-problems-controls" style="margin-bottom:14px;">
            <div class="student-search-box" style="min-width:320px;">
                <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="#64748b" stroke-width="1.8"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
                <asp:TextBox ID="txtSearchResource" runat="server" placeholder="Search formulas, cheat sheets, interview guides..." AutoPostBack="true" OnTextChanged="Search_TextChanged" />
            </div>

            <div style="display:flex; align-items:center; gap:8px;">
                <label style="font-size:10.5px; font-weight:700; color:#475569;">Filter Category:</label>
                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="stu-btn-outline" AutoPostBack="true" OnSelectedIndexChanged="Category_SelectedIndexChanged" style="padding:5px 10px; font-size:10.5px;">
                    <asp:ListItem Value="All" Selected="True">All Categories</asp:ListItem>
                    <asp:ListItem Value="Aptitude">Quantitative &amp; Logical</asp:ListItem>
                    <asp:ListItem Value="Coding">Data Structures &amp; Algorithms</asp:ListItem>
                    <asp:ListItem Value="Interview">Interview &amp; STAR Method</asp:ListItem>
                    <asp:ListItem Value="Resume">Resume &amp; ATS Templates</asp:ListItem>
                    <asp:ListItem Value="Core">Core CS Subjects (OS, DBMS, CN)</asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>

        <!-- Filter Chips Cloud -->
        <div class="student-chips-cloud">
            <asp:LinkButton ID="chipAll" runat="server" CssClass="student-chip-btn active" CommandArgument="All" OnClick="Chip_Click">All Resources (6)</asp:LinkButton>
            <asp:LinkButton ID="chipAptitude" runat="server" CssClass="student-chip-btn" CommandArgument="Aptitude" OnClick="Chip_Click">Quantitative Formulas</asp:LinkButton>
            <asp:LinkButton ID="chipCoding" runat="server" CssClass="student-chip-btn" CommandArgument="Coding" OnClick="Chip_Click">DSA Cheat Sheets</asp:LinkButton>
            <asp:LinkButton ID="chipInterview" runat="server" CssClass="student-chip-btn" CommandArgument="Interview" OnClick="Chip_Click">Interview Guides</asp:LinkButton>
            <asp:LinkButton ID="chipResume" runat="server" CssClass="student-chip-btn" CommandArgument="Resume" OnClick="Chip_Click">Resume Building</asp:LinkButton>
            <asp:LinkButton ID="chipCore" runat="server" CssClass="student-chip-btn" CommandArgument="Core" OnClick="Chip_Click">Core CS Topics</asp:LinkButton>
        </div>

        <!-- Resources Cards Grid -->
        <asp:Panel ID="pnlResourceCards" runat="server">
            <div class="resource-cards-grid">
                <asp:Repeater ID="rptResources" runat="server">
                    <ItemTemplate>
                        <div class="resource-card">
                            <div>
                                <div style="display:flex; align-items:center; justify-content:space-between; margin-bottom:8px;">
                                    <span class='<%# "resource-badge-type " + Eval("BadgeClass") %>'>
                                        <%# Eval("ResourceType") %>
                                    </span>
                                    <span class='<%# "difficulty-badge " + Eval("DifficultyClass") %>'>
                                        <%# Eval("Difficulty") %>
                                    </span>
                                </div>

                                <h3 style="font-size:14px; font-weight:800; margin:0 0 6px; color:var(--stu-text);">
                                    <%# Eval("Title") %>
                                </h3>
                                <p style="font-size:11px; color:#556260; margin:0 0 10px; line-height:1.5;">
                                    <%# Eval("Description") %>
                                </p>

                                <div style="font-size:10px; color:#64748b; display:flex; gap:10px;">
                                    <span>Category: <strong><%# Eval("Category") %></strong></span> &bull; 
                                    <span>Pages/Length: <strong><%# Eval("LengthInfo") %></strong></span>
                                </div>
                            </div>

                            <div style="display:flex; align-items:center; justify-content:space-between; padding-top:12px; border-top:1px solid #f1f2f8; margin-top:8px;">
                                <span style="font-size:9.5px; color:#64748b;">
                                    Updated: <%# Eval("LastUpdated") %>
                                </span>
                                <a href='<%# ResolveUrl(Eval("ActionLink").ToString()) %>' class="stu-btn-primary" style="font-size:9.5px; padding:4px 10px; text-decoration:none;">
                                    <%# Eval("ActionText") %> &rarr;
                                </a>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </asp:Panel>

        <!-- Empty State Panel (When search returns 0 results) -->
        <asp:Panel ID="pnlEmptyState" runat="server" Visible="false" CssClass="empty-resource-state">
            <svg viewBox="0 0 24 24" width="40" height="40" fill="none" stroke="#94a3b8" stroke-width="1.8" style="margin:0 auto 10px; display:block;"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/><line x1="8" y1="11" x2="14" y2="11"/></svg>
            <strong style="font-size:14px; color:var(--stu-text); display:block; margin-bottom:4px;">No matching learning resources found</strong>
            <p style="font-size:11px; color:#64748b; margin:0 0 14px;">Try searching with broader terms like "Algorithms", "Formulas", "STAR", or clear your filter.</p>
            <asp:Button ID="btnResetFilter" runat="server" Text="Reset Filters" CssClass="stu-btn-outline" OnClick="btnResetFilter_Click" />
        </asp:Panel>

    </div>
</asp:Content>

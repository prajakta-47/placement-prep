<%@ Page Title="Aptitude Practice" Language="C#" MasterPageFile="~/Student.Master"
    AutoEventWireup="true" CodeBehind="Quantitative.aspx.cs"
    Inherits="PlacementPrep.Quantitative" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Aptitude Practice | Placement Prep</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="student-aptitude-container">
        
        <!-- Header -->
        <header class="student-aptitude-header">
            <h1>Aptitude Practice</h1>
            <p>Select a category to begin your targeted preparation. Master foundational concepts through curated problem sets designed for placement tests.</p>
        </header>

        <!-- Category Cards Grid -->
        <div class="student-aptitude-grid">
            
            <!-- Category 1: Quantitative Aptitude -->
            <article class="student-category-card">
                <div>
                    <div class="student-category-top">
                        <div class="student-category-icon">
                            <svg viewBox="0 0 24 24"><rect x="4" y="3" width="16" height="18" rx="2"/><path d="M8 7h8M8 11h2m4 0h2M8 15h2m4 0h2M8 18h2m4 0h2"/></svg>
                        </div>
                        <span class="student-question-badge">120 Questions</span>
                    </div>
                    <h3>Quantitative Aptitude</h3>
                    <p>Master numbers, algebra, geometry, and advanced mathematical concepts crucial for clearing initial technical screening rounds.</p>
                </div>
                <asp:HyperLink ID="lnkStartQuant" runat="server" CssClass="student-category-action" NavigateUrl="~/Student/TestResults.aspx?cat=Quant">
                    Start Practice &rarr;
                </asp:HyperLink>
            </article>

            <!-- Category 2: Logical Reasoning -->
            <article class="student-category-card">
                <div>
                    <div class="student-category-top">
                        <div class="student-category-icon">
                            <svg viewBox="0 0 24 24"><polygon points="12 2 2 7 12 12 22 7 12 2"/><polyline points="2 17 12 22 22 17"/><polyline points="2 12 12 17 22 12"/></svg>
                        </div>
                        <span class="student-question-badge">85 Questions</span>
                    </div>
                    <h3>Logical Reasoning</h3>
                    <p>Enhance your analytical thinking with puzzles, sequence patterns, syllogisms, and complex deductive reasoning scenarios.</p>
                </div>
                <asp:HyperLink ID="lnkStartLogical" runat="server" CssClass="student-category-action" NavigateUrl="~/Student/TestResults.aspx?cat=Logical">
                    Start Practice &rarr;
                </asp:HyperLink>
            </article>

            <!-- Category 3: Verbal Ability -->
            <article class="student-category-card">
                <div>
                    <div class="student-category-top">
                        <div class="student-category-icon">
                            <svg viewBox="0 0 24 24"><path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"/></svg>
                        </div>
                        <span class="student-question-badge">150 Questions</span>
                    </div>
                    <h3>Verbal Ability</h3>
                    <p>Improve comprehension, grammar, vocabulary, and communication skills necessary for professional verbal assessments.</p>
                </div>
                <asp:HyperLink ID="lnkStartVerbal" runat="server" CssClass="student-category-action" NavigateUrl="~/Student/TestResults.aspx?cat=Verbal">
                    Start Practice &rarr;
                </asp:HyperLink>
            </article>

            <!-- Category 4: Data Interpretation -->
            <article class="student-category-card">
                <div>
                    <div class="student-category-top">
                        <div class="student-category-icon">
                            <svg viewBox="0 0 24 24"><line x1="18" y1="20" x2="18" y2="10"/><line x1="12" y1="20" x2="12" y2="4"/><line x1="6" y1="20" x2="6" y2="14"/></svg>
                        </div>
                        <span class="student-question-badge">65 Questions</span>
                    </div>
                    <h3>Data Interpretation</h3>
                    <p>Analyze complex charts, graphs, and tabular data sets. Develop speed and accuracy in extracting meaningful business insights.</p>
                </div>
                <asp:HyperLink ID="lnkStartDI" runat="server" CssClass="student-category-action" NavigateUrl="~/Student/TestResults.aspx?cat=DI">
                    Start Practice &rarr;
                </asp:HyperLink>
            </article>

        </div>

        <!-- Weekly Goal Progress Banner -->
        <section class="student-goal-card">
            <div class="student-goal-info">
                <h3>Weekly Goal</h3>
                <p>Complete 50 aptitude questions this week to stay on track for your campus placement drive benchmark.</p>
            </div>

            <div class="student-goal-progress">
                <div class="student-goal-stats">
                    32 <small>/ 50 completed (64%)</small>
                </div>
                <div style="flex:1; height:8px; background:rgba(255,255,255,0.2); border-radius:6px; overflow:hidden;">
                    <div style="width:64%; height:100%; background:#10b981; border-radius:6px;"></div>
                </div>
            </div>
        </section>

    </div>
</asp:Content>

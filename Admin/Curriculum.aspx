<%@ Page Title="Placement Training Curriculum" Language="C#" MasterPageFile="~/Admin.Master"
    AutoEventWireup="true" CodeBehind="Curriculum.aspx.cs"
    Inherits="PlacementPrep.Curriculum" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Placement Training Curriculum &amp; Roadmaps | Placement Prep Admin</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="admin-shell-page">

    <!-- Page Header -->
    <div class="users-header">
        <div>
            <div class="users-breadcrumb">
                <a href="<%= ResolveUrl("~/Admin/AdminDashboard.aspx") %>">Dashboard</a>
                <span>/</span>
                <span>Academic Training</span>
                <span>/</span>
                <span>Curriculum Roadmaps</span>
            </div>
            <h1 class="users-title">Placement Preparation Curriculum &amp; Syllabi</h1>
            <p class="users-subtitle">
                Institutional readiness roadmaps, modular competency milestones, faculty mentoring allocations, and technical domain track coverage.
            </p>
        </div>
        <div class="users-header-actions">
            <a href="<%= ResolveUrl("~/Admin/QuestionBank.aspx") %>" class="action-button">
                Question Bank
            </a>
            <a href="<%= ResolveUrl("~/Admin/ManageTests.aspx") %>" class="action-button primary">
                Assessments
            </a>
        </div>
    </div>

    <!-- 4 Track Summary KPI Cards -->
    <div class="users-kpi-grid">
        <div class="users-kpi-card">
            <span class="users-kpi-label">Aptitude Milestones</span>
            <div class="users-kpi-value">24 Units</div>
            <span class="users-kpi-sub">Quant, Logical, Verbal &amp; DI</span>
        </div>
        <div class="users-kpi-card">
            <span class="users-kpi-label">Technical CS Tracks</span>
            <div class="users-kpi-value">36 Units</div>
            <span class="users-kpi-sub">DSA, Systems, OS &amp; DBMS</span>
        </div>
        <div class="users-kpi-card">
            <span class="users-kpi-label">Coding Challenge Tiers</span>
            <div class="users-kpi-value">120 Problems</div>
            <span class="users-kpi-sub">Curated LeetCode/HackerRank track</span>
        </div>
        <div class="users-kpi-card">
            <span class="users-kpi-label">Faculty Mentors</span>
            <div class="users-kpi-value">18 Faculty</div>
            <span class="users-kpi-sub">Active track advisors assigned</span>
        </div>
    </div>

    <!-- 4 Structured Curriculum Track Cards -->
    <div class="curriculum-grid">
        
        <!-- Track 1: Quantitative & Analytical Aptitude -->
        <div class="curriculum-card">
            <div class="curriculum-card-header">
                <div class="curriculum-card-icon">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <line x1="18" y1="20" x2="18" y2="10"></line>
                        <line x1="12" y1="20" x2="12" y2="4"></line>
                        <line x1="6" y1="20" x2="6" y2="14"></line>
                    </svg>
                </div>
                <div class="curriculum-card-title">
                    <h3>Quantitative &amp; Mathematical Reasoning</h3>
                    <p>Foundation for Tier 1 Online Screening Assessments</p>
                </div>
            </div>
            <ul class="curriculum-milestones">
                <li class="curriculum-milestone-item">
                    <span><strong>Unit 1:</strong> Number Systems, LCM/HCF &amp; Divisibility</span>
                    <span class="status-pill status-active"><i></i>100% Covered</span>
                </li>
                <li class="curriculum-milestone-item">
                    <span><strong>Unit 2:</strong> Time &amp; Work, Pipes &amp; Cisterns</span>
                    <span class="status-pill status-active"><i></i>100% Covered</span>
                </li>
                <li class="curriculum-milestone-item">
                    <span><strong>Unit 3:</strong> Time, Speed, Distance &amp; Relative Motion</span>
                    <span class="status-pill status-active"><i></i>100% Covered</span>
                </li>
                <li class="curriculum-milestone-item">
                    <span><strong>Unit 4:</strong> Probability, Permutations &amp; Combinations</span>
                    <span class="status-pill status-process"><i></i>85% Covered</span>
                </li>
            </ul>
        </div>

        <!-- Track 2: Data Structures & Algorithms -->
        <div class="curriculum-card">
            <div class="curriculum-card-header">
                <div class="curriculum-card-icon">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <rect x="2" y="3" width="20" height="14" rx="2" ry="2"></rect>
                        <line x1="8" y1="21" x2="16" y2="21"></line>
                        <line x1="12" y1="17" x2="12" y2="21"></line>
                    </svg>
                </div>
                <div class="curriculum-card-title">
                    <h3>Data Structures &amp; Algorithmic Mastery</h3>
                    <p>Core Problem-Solving Track for Product Engineering Companies</p>
                </div>
            </div>
            <ul class="curriculum-milestones">
                <li class="curriculum-milestone-item">
                    <span><strong>Unit 1:</strong> Arrays, Two Pointers &amp; Sliding Window</span>
                    <span class="status-pill status-active"><i></i>100% Covered</span>
                </li>
                <li class="curriculum-milestone-item">
                    <span><strong>Unit 2:</strong> Trees, Binary Search Trees &amp; Tries</span>
                    <span class="status-pill status-active"><i></i>100% Covered</span>
                </li>
                <li class="curriculum-milestone-item">
                    <span><strong>Unit 3:</strong> Graphs (BFS/DFS, Dijkstra, Topo Sort)</span>
                    <span class="status-pill status-process"><i></i>90% Covered</span>
                </li>
                <li class="curriculum-milestone-item">
                    <span><strong>Unit 4:</strong> Dynamic Programming &amp; Memoization Patterns</span>
                    <span class="status-pill status-process"><i></i>78% Covered</span>
                </li>
            </ul>
        </div>

        <!-- Track 3: Computer Systems & Core CS -->
        <div class="curriculum-card">
            <div class="curriculum-card-header">
                <div class="curriculum-card-icon">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <circle cx="12" cy="12" r="3"></circle>
                        <path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z"></path>
                    </svg>
                </div>
                <div class="curriculum-card-title">
                    <h3>Computer Systems, OS &amp; DBMS</h3>
                    <p>Technical Core Essentials for Campus Technical Interviews</p>
                </div>
            </div>
            <ul class="curriculum-milestones">
                <li class="curriculum-milestone-item">
                    <span><strong>Unit 1:</strong> Operating Systems (Concurrency, Virtual Memory)</span>
                    <span class="status-pill status-active"><i></i>100% Covered</span>
                </li>
                <li class="curriculum-milestone-item">
                    <span><strong>Unit 2:</strong> DBMS (Indexing, Normalization, ACID Transactions)</span>
                    <span class="status-pill status-active"><i></i>100% Covered</span>
                </li>
                <li class="curriculum-milestone-item">
                    <span><strong>Unit 3:</strong> Computer Networks (TCP/IP, HTTP/3, Routing)</span>
                    <span class="status-pill status-active"><i></i>95% Covered</span>
                </li>
                <li class="curriculum-milestone-item">
                    <span><strong>Unit 4:</strong> Object Oriented Design &amp; SOLID Principles</span>
                    <span class="status-pill status-active"><i></i>100% Covered</span>
                </li>
            </ul>
        </div>

        <!-- Track 4: Verbal Ability & Corporate Readiness -->
        <div class="curriculum-card">
            <div class="curriculum-card-header">
                <div class="curriculum-card-icon">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
                    </svg>
                </div>
                <div class="curriculum-card-title">
                    <h3>Verbal Communication &amp; HR Behavioral Fit</h3>
                    <p>Leadership Principles, STAR Method, and Resume Polish</p>
                </div>
            </div>
            <ul class="curriculum-milestones">
                <li class="curriculum-milestone-item">
                    <span><strong>Unit 1:</strong> ATS-Optimized Resume Engineering</span>
                    <span class="status-pill status-active"><i></i>100% Covered</span>
                </li>
                <li class="curriculum-milestone-item">
                    <span><strong>Unit 2:</strong> Behavioral Competency &amp; Amazon 16 Principles</span>
                    <span class="status-pill status-active"><i></i>100% Covered</span>
                </li>
                <li class="curriculum-milestone-item">
                    <span><strong>Unit 3:</strong> Group Discussion Strategy &amp; Case Study Pitch</span>
                    <span class="status-pill status-process"><i></i>88% Covered</span>
                </li>
                <li class="curriculum-milestone-item">
                    <span><strong>Unit 4:</strong> Executive Communication &amp; Offer Negotiation</span>
                    <span class="status-pill status-active"><i></i>92% Covered</span>
                </li>
            </ul>
        </div>

    </div>

    <!-- Faculty Mentoring Allocations Table -->
    <div class="details-section-card">
        <div class="details-section-header">
            <div>
                <h2>Faculty Mentoring Assignments by Cohort &amp; Track</h2>
                <p class="text-muted" style="margin: 3px 0 0; font-size: 11px;">
                    Departmental training leads overseeing student cohort readiness and mock assessment evaluations.
                </p>
            </div>
        </div>

        <div class="table-scroll">
            <table class="users-table">
                <thead>
                    <tr>
                        <th>Faculty Mentor</th>
                        <th>Department</th>
                        <th>Supervised Curriculum Track</th>
                        <th style="width: 130px;">Assigned Cohort</th>
                        <th style="width: 140px;">Weekly Office Hours</th>
                        <th style="width: 120px;">Review Cadence</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><strong>Dr. Rajeshwari K.</strong><br/><small class="text-muted">Professor &amp; Head</small></td>
                        <td>Computer Science</td>
                        <td><span class="qb-code">DSA &amp; Competitive Programming</span></td>
                        <td><span class="qb-usage-count">Batch '25 (Sec A-C)</span></td>
                        <td>Tue &amp; Thu 16:00 - 18:00</td>
                        <td><span class="status-pill status-active"><i></i>Weekly Mock Tests</span></td>
                    </tr>
                    <tr>
                        <td><strong>Prof. Arun M. Sen</strong><br/><small class="text-muted">Associate Professor</small></td>
                        <td>Information Technology</td>
                        <td><span class="qb-code">Systems, Cloud &amp; Microservices</span></td>
                        <td><span class="qb-usage-count">Batch '25 (Sec D-F)</span></td>
                        <td>Mon &amp; Wed 15:00 - 17:00</td>
                        <td><span class="status-pill status-active"><i></i>Bi-Weekly Reviews</span></td>
                    </tr>
                    <tr>
                        <td><strong>Dr. Meenakshi Sundaram</strong><br/><small class="text-muted">Professor</small></td>
                        <td>Electronics &amp; Comm</td>
                        <td><span class="qb-code">Hardware, VLSI &amp; Embedded Systems</span></td>
                        <td><span class="qb-usage-count">Batch '25 (ECE 1-4)</span></td>
                        <td>Wed &amp; Fri 14:00 - 16:00</td>
                        <td><span class="status-pill status-active"><i></i>Weekly Mock Tests</span></td>
                    </tr>
                    <tr>
                        <td><strong>Prof. Sunita Deshmukh</strong><br/><small class="text-muted">Director of Communications</small></td>
                        <td>Humanities &amp; Soft Skills</td>
                        <td><span class="qb-code">Verbal Ability &amp; Behavioral HR</span></td>
                        <td><span class="qb-usage-count">All Engineering Cohorts</span></td>
                        <td>Daily 11:00 - 13:00</td>
                        <td><span class="status-pill status-active"><i></i>Continuous Sessions</span></td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="users-hint" style="margin-top: 14px;">
            <strong>Demonstration Curriculum:</strong> The milestones and faculty mentoring assignments above reflect institutional curriculum benchmarks configured for academic review.
        </div>
    </div>

</div>
</asp:Content>

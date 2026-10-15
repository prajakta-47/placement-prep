
<%@ Page Title="Student Dashboard" Language="C#" MasterPageFile="~/Student.Master"
    AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs"
    Inherits="PlacementPrep.StudentDashboard" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Dashboard | Placement Prep</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="student-dashboard">

    <section class="student-welcome">
        <h1>Welcome, Vishal!</h1>
        <p>You have 2 scheduled tests this week. Keep up the momentum.</p>
    </section>

    <div class="student-dashboard-grid">

        <div class="student-primary-column">

            <!-- Upcoming tests -->
            <section class="student-upcoming-grid">

                <article class="student-module-card">
                    <div class="student-module-meta">
                        <span class="student-chip">TECHNICAL</span>
                        <span class="student-module-time">Tomorrow, 10:00 AM</span>
                    </div>
                    <h2>Data Structures Core</h2>
                    <div class="student-module-details">
                        <span>◷ &nbsp;45 mins</span>
                        <span>•</span>
                        <span>30 Questions</span>
                    </div>
                    <a class="student-module-action" href="<%= ResolveUrl("~/Student/MockTests.aspx") %>">
                        Launch Module
                    </a>
                </article>

                <article class="student-module-card">
                    <div class="student-module-meta">
                        <span class="student-chip">APTITUDE</span>
                        <span class="student-module-time" style="color:#687773">Fri, 2:00 PM</span>
                    </div>
                    <h2>Quantitative Set A</h2>
                    <div class="student-module-details">
                        <span>◷ &nbsp;60 mins</span>
                        <span>•</span>
                        <span>50 Questions</span>
                    </div>
                    <a class="student-module-action" href="<%= ResolveUrl("~/Student/Quantitative.aspx") %>">
                        Review Syllabus
                    </a>
                </article>

            </section>

            <!-- Subject mastery -->
            <section class="student-mastery-section">
                <div class="student-section-heading">
                    <h2>Subject Mastery</h2>
                    <span>UPDATED TODAY</span>
                </div>

                <div class="student-mastery-grid">

                    <article class="student-mastery-card">
                        <div class="student-mastery-title">
                            <span class="student-mastery-icon">&lt;&gt;</span>
                            <span>Technical Core</span>
                        </div>
                        <div class="student-progress-label">
                            <span>Progress</span>
                            <strong>68%</strong>
                        </div>
                        <div class="student-progress-track">
                            <div class="student-progress-fill" style="width:68%"></div>
                        </div>
                    </article>

                    <article class="student-mastery-card">
                        <div class="student-mastery-title">
                            <span class="student-mastery-icon">▦</span>
                            <span>Quantitative</span>
                        </div>
                        <div class="student-progress-label">
                            <span>Progress</span>
                            <strong>42%</strong>
                        </div>
                        <div class="student-progress-track">
                            <div class="student-progress-fill" style="width:42%"></div>
                        </div>
                    </article>

                    <article class="student-mastery-card">
                        <div class="student-mastery-title">
                            <span class="student-mastery-icon">♙</span>
                            <span>Soft Skills</span>
                        </div>
                        <div class="student-progress-label">
                            <span>Progress</span>
                            <strong>85%</strong>
                        </div>
                        <div class="student-progress-track">
                            <div class="student-progress-fill" style="width:85%"></div>
                        </div>
                    </article>

                </div>
            </section>

            <!-- Recent code submission -->
            <section class="student-code-card">
                <div class="student-code-header">
                    <span class="student-window-dot"></span>
                    <span class="student-window-dot"></span>
                    <span class="student-window-dot"></span>
                    <span class="student-code-title">Recent Submission: Binary Search</span>
                    <span class="student-passed">PASSED</span>
                </div>

                <div class="student-code-body">
<pre><span class="code-keyword">function</span> <span class="code-function">binarySearch</span>(arr, target) {
    <span class="code-keyword">let</span> left = <span class="code-number">0</span>;
    <span class="code-keyword">let</span> right = arr.length - <span class="code-number">1</span>;

    <span class="code-keyword">while</span> (left &lt;= right) {
        <span class="code-keyword">const</span> mid = Math.floor((left + right) / <span class="code-number">2</span>);
        <span class="code-keyword">if</span> (arr[mid] === target) <span class="code-keyword">return</span> mid;
        <span class="code-keyword">if</span> (arr[mid] &lt; target) left = mid + <span class="code-number">1</span>;
        <span class="code-keyword">else</span> right = mid - <span class="code-number">1</span>;
    }
    <span class="code-keyword">return</span> -<span class="code-number">1</span>;
}</pre>
                </div>
            </section>

        </div>

        <!-- Right column -->
        <aside class="student-secondary-column">

            <section class="student-resume-card">
                <h2>Pick up where you left off</h2>
                <p>System Design Fundamentals - Module 3</p>
                <a class="student-resume-button" href="<%= ResolveUrl("~/Student/InterviewPrep.aspx") %>">
                    ▶ &nbsp; Resume Last Module
                </a>
            </section>

            <section class="student-calendar-card">

                <div class="student-calendar-heading">
                    <h2>September</h2>
                    <div class="student-calendar-controls">
                        <span>‹</span><span>›</span>
                    </div>
                </div>

                <div class="student-calendar-grid">
                    <span class="student-calendar-day weekday">S</span>
                    <span class="student-calendar-day weekday">M</span>
                    <span class="student-calendar-day weekday">T</span>
                    <span class="student-calendar-day weekday">W</span>
                    <span class="student-calendar-day weekday">T</span>
                    <span class="student-calendar-day weekday">F</span>
                    <span class="student-calendar-day weekday">S</span>

                    <span class="student-calendar-day muted">28</span>
                    <span class="student-calendar-day muted">29</span>
                    <span class="student-calendar-day muted">30</span>
                    <span class="student-calendar-day muted">31</span>
                    <span class="student-calendar-day">1</span>
                    <span class="student-calendar-day">2</span>
                    <span class="student-calendar-day">3</span>

                    <span class="student-calendar-day">4</span>
                    <span class="student-calendar-day">5</span>
                    <span class="student-calendar-day">6</span>
                    <span class="student-calendar-day today">7</span>
                    <span class="student-calendar-day has-event">8</span>
                    <span class="student-calendar-day">9</span>
                    <span class="student-calendar-day has-event">10</span>
                </div>

                <div class="student-deadlines">
                    <h3>Upcoming Deadlines</h3>

                    <div class="student-deadline">
                        <span class="student-deadline-bar"></span>
                        <div>
                            <strong>Company Registration</strong>
                            <small>Sep 8 • Tech Corp Inc.</small>
                        </div>
                    </div>

                    <div class="student-deadline">
                        <span class="student-deadline-bar"></span>
                        <div>
                            <strong>Resume Submission</strong>
                            <small>Sep 10 • Global Finance</small>
                        </div>
                    </div>
                </div>

            </section>

        </aside>

    </div>
</div>

</asp:Content>

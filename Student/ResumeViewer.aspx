<%@ Page Title="Resume Viewer" Language="C#" MasterPageFile="~/Student.Master"
    AutoEventWireup="true" CodeBehind="ResumeViewer.aspx.cs"
    Inherits="PlacementPrep.ResumeViewer" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Resume Viewer | Placement Prep</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="student-viewer-container">
        
        <!-- Header Bar -->
        <header class="student-viewer-header">
            <div class="student-viewer-title-group">
                <h1>Resume Analyzer</h1>
                <span class="student-file-tag">
                    <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/></svg>
                    <asp:Label ID="lblFileName" runat="server" Text="jdoe_resume_v4_final.pdf" />
                </span>
                <span class="student-parsed-time">&bull; Parsed in 1.2s</span>
            </div>

            <div class="student-viewer-actions">
                <asp:LinkButton ID="btnExportJson" runat="server" CssClass="stu-btn-outline" OnClick="btnExportJson_Click">
                    <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg>
                    <span>Export JSON</span>
                </asp:LinkButton>
                <asp:HyperLink ID="lnkGapAnalysis" runat="server" CssClass="stu-btn-secondary" NavigateUrl="~/Student/SkillGapAnalysis.aspx">
                    <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="12" r="10"/><path d="m10 15 5-3-5-3v6z"/></svg>
                    <span>Run Gap Analysis</span>
                </asp:HyperLink>
                <asp:HyperLink ID="lnkFinalReport" runat="server" CssClass="stu-btn-primary" NavigateUrl="~/Student/AIResumeAnalysis.aspx">
                    <span>Final Report &rarr;</span>
                </asp:HyperLink>
            </div>
        </header>

        <!-- 2-Column Split: Document Preview & Extracted Intelligence -->
        <div class="student-viewer-grid">
            
            <!-- Left Column: Document Preview -->
            <div class="student-doc-pane">
                <div class="student-doc-toolbar">
                    <div class="student-doc-zoom">
                        <button type="button" class="student-tool-btn" id="btnZoomOut" aria-label="Zoom out">&minus;</button>
                        <span id="lblZoomLevel">100%</span>
                        <button type="button" class="student-tool-btn" id="btnZoomIn" aria-label="Zoom in">&#43;</button>
                    </div>

                    <div class="student-doc-page-nav">
                        <button type="button" class="student-tool-btn" aria-label="Previous page">&lsaquo;</button>
                        <span>Page 1 of 1</span>
                        <button type="button" class="student-tool-btn" aria-label="Next page">&rsaquo;</button>
                    </div>

                    <button type="button" class="student-tool-btn" id="btnFullscreen" aria-label="Toggle full screen">
                        <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M8 3H5a2 2 0 0 0-2 2v3m18 0V5a2 2 0 0 0-2-2h-3m0 18h3a2 2 0 0 0 2-2v-3M3 16v3a2 2 0 0 0 2 2h3"/></svg>
                    </button>
                </div>

                <!-- Simulated High-Fidelity Resume Document Sheet -->
                <article class="student-resume-sheet" id="resumeSheet">
                    <header class="resume-header">
                        <h2>Alexander Chen</h2>
                        <div class="resume-contact">
                            San Francisco, CA &bull; (415) 555-0192 &bull; alex.chen@alum.mit.edu &bull; linkedin.com/in/alexanderchen
                        </div>
                        <span class="resume-badge-candidate">&#10003; Verified Senior Candidate &bull; 6+ YOE</span>
                    </header>

                    <section class="resume-section">
                        <h3 class="resume-section-title">Professional Summary</h3>
                        <p class="resume-text">
                            Results-driven Senior Backend Engineer with over 6 years of expertise architecting high-throughput distributed systems, event-driven microservices, and high-concurrency cloud backends. Proven track record reducing API latency by 40% across tier-1 production applications and leading zero-downtime database migrations.
                        </p>
                    </section>

                    <section class="resume-section">
                        <h3 class="resume-section-title">Work Experience</h3>
                        
                        <div class="resume-job">
                            <div class="resume-job-header">
                                <span><strong>Senior Backend Engineer</strong> &bull; <span class="resume-job-company">TechFlow Systems Inc.</span></span>
                                <span class="resume-job-date">2021 &ndash; Present</span>
                            </div>
                            <ul class="resume-bullets">
                                <li>Architected scalable microservices using Node.js, Go, and gRPC, serving 45M+ daily requests across multi-tier production environments.</li>
                                <li>Reduced API latency by 40% through multi-tier Redis caching strategies and optimized database query plans.</li>
                                <li>Orchestrated production Kubernetes clusters managing 120+ micro-deployments with 99.99% SLA.</li>
                            </ul>
                        </div>

                        <div class="resume-job">
                            <div class="resume-job-header">
                                <span><strong>Software Engineer II</strong> &bull; <span class="resume-job-company">DataSphere Analytics</span></span>
                                <span class="resume-job-date">2019 &ndash; 2021</span>
                            </div>
                            <ul class="resume-bullets">
                                <li>Engineered real-time ETL pipeline processing 10TB daily telemetry using Apache Kafka and PostgreSQL.</li>
                                <li>Spearheaded automated CI/CD pipeline implementation cutting regression deployment cycles in half.</li>
                            </ul>
                        </div>
                    </section>

                    <section class="resume-section">
                        <h3 class="resume-section-title">Education</h3>
                        <div class="resume-job">
                            <div class="resume-job-header">
                                <span><strong>Master of Science in Computer Science</strong> &bull; Stanford University</span>
                                <span class="resume-job-date">2019 &ndash; 2021</span>
                            </div>
                            <div class="resume-job-header" style="margin-top: 4px;">
                                <span><strong>Bachelor of Science in Software Engineering</strong> &bull; UC Berkeley</span>
                                <span class="resume-job-date">2015 &ndash; 2019</span>
                            </div>
                        </div>
                    </section>

                    <section class="resume-section" style="margin-bottom:0;">
                        <h3 class="resume-section-title">Technical Skills</h3>
                        <p class="resume-text">
                            <strong>Languages:</strong> Go, Python, TypeScript, SQL, Java<br />
                            <strong>Cloud &amp; Infrastructure:</strong> Kubernetes, Docker, AWS (ECS, S3, RDS), Terraform<br />
                            <strong>Databases &amp; Tools:</strong> PostgreSQL, Redis, Apache Kafka, GraphQL, Git
                        </p>
                    </section>
                </article>
            </div>

            <!-- Right Column: Extracted Intelligence Cards -->
            <aside class="student-extracted-pane">
                
                <!-- Status Banner -->
                <div class="student-card-status-bar">
                    <div class="student-status-indicator">
                        <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
                        <div>
                            <strong>Extraction Complete</strong>
                            <div style="font-size:9px; color:#065f46; font-weight:normal;">All key sections identified successfully</div>
                        </div>
                    </div>
                    <span class="student-badge-match">100% Match</span>
                </div>

                <!-- Education Card -->
                <section class="student-extracted-card">
                    <div class="student-extracted-card-header">
                        <h3>
                            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M22 10v6M2 10l10-5 10 5-10 5z"/><path d="M6 12v5c0 2 2 3 6 3s6-1 6-3v-5"/></svg>
                            <span>Education</span>
                        </h3>
                        <span class="student-pill-count">2 Verified</span>
                    </div>

                    <div class="student-timeline-item">
                        <span class="student-timeline-dot"></span>
                        <div class="student-timeline-content">
                            <strong>Master of Science in Computer Science</strong>
                            <small>Stanford University &bull; 2019 &ndash; 2021</small>
                        </div>
                    </div>

                    <div class="student-timeline-item">
                        <span class="student-timeline-dot"></span>
                        <div class="student-timeline-content">
                            <strong>Bachelor of Science in Software Engineering</strong>
                            <small>University of California, Berkeley &bull; 2015 &ndash; 2019</small>
                        </div>
                    </div>
                </section>

                <!-- Experience Card -->
                <section class="student-extracted-card">
                    <div class="student-extracted-card-header">
                        <h3>
                            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="2" y="7" width="20" height="14" rx="2" ry="2"/><path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"/></svg>
                            <span>Experience</span>
                        </h3>
                        <span class="student-pill-count">3 Roles Found</span>
                    </div>

                    <div class="student-timeline-item">
                        <span class="student-timeline-dot"></span>
                        <div class="student-timeline-content">
                            <strong>Senior Backend Engineer</strong>
                            <small>TechFlow Systems Inc. &bull; <span style="color:var(--stu-teal); font-weight:700;">Present</span></small>
                            <p>Architected scalable microservices using Node.js and Go; reduced latency by 40% via Redis.</p>
                        </div>
                    </div>

                    <div class="student-timeline-item">
                        <span class="student-timeline-dot"></span>
                        <div class="student-timeline-content">
                            <strong>Software Engineer II</strong>
                            <small>DataSphere Analytics &bull; 2019 &ndash; 2021</small>
                            <p>Engineered real-time ETL telemetry pipelines and cut deployment regressions by 50%.</p>
                        </div>
                    </div>
                </section>

                <!-- Technical Skills Card -->
                <section class="student-extracted-card">
                    <div class="student-extracted-card-header">
                        <h3>
                            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8"><polygon points="12 2 2 7 12 12 22 7 12 2"/><polyline points="2 17 12 22 22 17"/><polyline points="2 12 12 17 22 12"/></svg>
                            <span>Technical Skills</span>
                        </h3>
                        <span class="student-pill-count">8 Identified</span>
                    </div>

                    <div class="student-skills-cloud">
                        <span class="student-skill-chip">Python</span>
                        <span class="student-skill-chip">Kubernetes</span>
                        <span class="student-skill-chip">React.js</span>
                        <span class="student-skill-chip">TypeScript</span>
                        <span class="student-skill-chip">PostgreSQL</span>
                        <span class="student-skill-chip">AWS</span>
                        <span class="student-skill-chip">Docker</span>
                        <span class="student-skill-chip">Go / Golang</span>
                    </div>
                </section>

                <!-- ATS Benchmark Meter Card -->
                <section class="student-benchmark-card">
                    <div class="student-benchmark-header">
                        <span>ATS Parsability Benchmark</span>
                        <span style="color:var(--stu-teal);">98 / 100</span>
                    </div>
                    <div class="student-benchmark-bar">
                        <div class="student-benchmark-fill" style="width: 98%;"></div>
                    </div>
                </section>

            </aside>

        </div>

    </div>

    <!-- Interactive script for Zoom & Fullscreen -->
    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function () {
            var sheet = document.getElementById('resumeSheet');
            var btnZoomIn = document.getElementById('btnZoomIn');
            var btnZoomOut = document.getElementById('btnZoomOut');
            var lblZoom = document.getElementById('lblZoomLevel');
            var btnFullscreen = document.getElementById('btnFullscreen');
            var currentZoom = 100;

            function updateZoom() {
                lblZoom.textContent = currentZoom + '%';
                sheet.style.transformOrigin = 'top center';
                sheet.style.transform = 'scale(' + (currentZoom / 100) + ')';
            }

            if (btnZoomIn) {
                btnZoomIn.addEventListener('click', function () {
                    if (currentZoom < 140) {
                        currentZoom += 10;
                        updateZoom();
                    }
                });
            }

            if (btnZoomOut) {
                btnZoomOut.addEventListener('click', function () {
                    if (currentZoom > 70) {
                        currentZoom -= 10;
                        updateZoom();
                    }
                });
            }

            if (btnFullscreen) {
                btnFullscreen.addEventListener('click', function () {
                    if (!document.fullscreenElement) {
                        sheet.parentElement.requestFullscreen().catch(function(err) {});
                    } else {
                        document.exitFullscreen();
                    }
                });
            }
        });
    </script>
</asp:Content>

<%@ Page Title="Upload Your Resume" Language="C#" MasterPageFile="~/Student.Master"
    AutoEventWireup="true" CodeBehind="ResumeAnalyzer.aspx.cs"
    Inherits="PlacementPrep.ResumeAnalyzer" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Upload Your Resume | Placement Prep</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="student-analyzer">
        
        <!-- Header -->
        <header class="student-analyzer-header">
            <div class="student-analyzer-tag">
                <span class="tag-dot"></span>
                <span>AI EVALUATION ENGINE &bull; VERSION 3.4</span>
            </div>
            <h1>Upload Your Resume</h1>
            <p>Submit your latest resume for our AI parser to extract skills, experience, and format quality. We recommend uploading a clean PDF for the most accurate analysis.</p>
        </header>

        <!-- Feedback Alert Panel -->
        <asp:Panel ID="pnlAlert" runat="server" Visible="false">
            <asp:Literal ID="litAlertMessage" runat="server" />
        </asp:Panel>

        <!-- Main Grid Layout -->
        <div class="student-analyzer-grid">
            
            <!-- Left Column: Upload & Security -->
            <div class="student-analyzer-main">
                
                <section class="student-upload-card">
                    <!-- Validation Summary -->
                    <asp:ValidationSummary ID="valSummary" runat="server"
                        ValidationGroup="ResumeUploadGroup"
                        CssClass="stu-val-summary"
                        HeaderText="Please correct the following errors:" />

                    <!-- Drag & Drop Zone -->
                    <div class="student-dropzone" id="dropZone">
                        <div class="student-dropzone-icon" aria-hidden="true">
                            <svg viewBox="0 0 24 24"><path d="M7 16a4 4 0 0 1-.88-7.903A5 5 0 1 1 15.9 6L16 6a5 5 0 0 1 1 9.9M15 13l-3-3m0 0l-3 3m3-3v12"/></svg>
                        </div>
                        <div class="student-dropzone-title">Drag &amp; Drop your resume here</div>
                        <div class="student-dropzone-browse">or click to browse from your computer</div>
                        
                        <div class="student-dropzone-formats">
                            <span class="student-dropzone-badge">PDF</span>
                            <span class="student-dropzone-badge">DOCX</span>
                        </div>
                        
                        <div class="student-dropzone-limit">Maximum file size: 5MB</div>

                        <asp:FileUpload ID="fileUploadResume" runat="server"
                            CssClass="stu-file-input"
                            accept=".pdf,.docx,.doc" />
                    </div>

                    <!-- Selected File Info (display toggled via JS) -->
                    <div id="selectedFileInfo" class="student-selected-file" style="display:none;">
                        <div class="student-selected-file-info">
                            <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/></svg>
                            <div>
                                <div id="selectedFileName" class="student-selected-file-name">filename.pdf</div>
                                <div id="selectedFileSize" class="student-selected-file-size">0 KB</div>
                            </div>
                        </div>
                        <button type="button" id="btnRemoveFile" class="student-btn-remove">Remove</button>
                    </div>

                    <!-- Validation Controls -->
                    <asp:RequiredFieldValidator ID="rfvResume" runat="server"
                        ControlToValidate="fileUploadResume"
                        ErrorMessage="Please select a resume file to upload."
                        Display="Dynamic"
                        CssClass="stu-val-error"
                        ValidationGroup="ResumeUploadGroup" />

                    <asp:RegularExpressionValidator ID="revResume" runat="server"
                        ControlToValidate="fileUploadResume"
                        ValidationExpression="^.*\.([pP][dD][fF]|[dD][oO][cC][xX]|[dD][oO][cC])$"
                        ErrorMessage="Only .PDF and .DOCX files are supported."
                        Display="Dynamic"
                        CssClass="stu-val-error"
                        ValidationGroup="ResumeUploadGroup" />

                    <asp:CustomValidator ID="cvFileSize" runat="server"
                        ControlToValidate="fileUploadResume"
                        ErrorMessage="File size must not exceed 5 MB."
                        Display="Dynamic"
                        CssClass="stu-val-error"
                        ValidationGroup="ResumeUploadGroup"
                        ClientValidationFunction="validateResumeFileSize"
                        OnServerValidate="cvFileSize_ServerValidate" />

                    <!-- Submit Button -->
                    <asp:Button ID="btnUpload" runat="server"
                        Text="Upload &amp; Analyze Resume"
                        CssClass="stu-btn-upload"
                        ValidationGroup="ResumeUploadGroup"
                        OnClick="btnUpload_Click" />
                </section>

                <!-- Institutional Privacy Card -->
                <section class="student-privacy-card">
                    <div class="student-privacy-left">
                        <div class="student-privacy-icon" aria-hidden="true">
                            <svg viewBox="0 0 24 24"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>
                        </div>
                        <div class="student-privacy-text">
                            <strong>Institutional Privacy Protected</strong>
                            <p>Resumes are encrypted end-to-end and strictly retained for analytical evaluation.</p>
                        </div>
                    </div>
                    <div class="student-privacy-badge">
                        <svg viewBox="0 0 24 24" aria-hidden="true"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg>
                        <span>SOC-2 Type II Certified</span>
                    </div>
                </section>

            </div>

            <!-- Right Column: Pro Tip & Recent Uploads -->
            <aside class="student-analyzer-side">
                
                <!-- Pro Tip Card -->
                <section class="student-tip-card">
                    <div class="student-tip-header">
                        <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 2v4M12 18v4M4.93 4.93l2.83 2.83M16.24 16.24l2.83 2.83M2 12h4M18 12h4M4.93 19.07l2.83-2.83M16.24 7.76l2.83-2.83"/></svg>
                        <span>Pro Tip for Parsing</span>
                    </div>
                    <p class="student-tip-body">Avoid using complex multi-column layouts or heavy graphics. Standard one-column layouts ensure the AI correctly identifies headers like &ldquo;Experience&rdquo; and &ldquo;Education&rdquo;.</p>
                    <a href="javascript:void(0);" class="student-tip-link">View optimal templates &rarr;</a>
                </section>

                <!-- Recent Uploads Card -->
                <section class="student-recent-card">
                    <div class="student-recent-header">
                        <h2>Recent Uploads</h2>
                        <asp:Label ID="lblStoredCount" runat="server" CssClass="student-recent-counter" Text="2 of 10 stored" />
                    </div>

                    <div class="student-recent-list">
                        <asp:Repeater ID="rptRecentUploads" runat="server">
                            <ItemTemplate>
                                <div class="student-recent-item">
                                    <div class="student-recent-item-main">
                                        <div class='student-status-icon <%# ((bool)Eval("IsSuccess")) ? "success" : "warning" %>'>
                                            <%# ((bool)Eval("IsSuccess")) 
                                                ? "<svg viewBox='0 0 24 24'><polyline points='20 6 9 17 4 12'></polyline></svg>" 
                                                : "<svg viewBox='0 0 24 24'><path d='m21.73 18-8-14a2 2 0 0 0-3.48 0l-8 14A2 2 0 0 0 4 21h16a2 2 0 0 0 1.73-3Z'></path><line x1='12' y1='9' x2='12' y2='13'></line><line x1='12' y1='17' x2='12.01' y2='17'></line></svg>" %>
                                        </div>
                                        <div class="student-recent-info">
                                            <span class="student-recent-filename" title='<%# Eval("FileName") %>'><%# Eval("FileName") %></span>
                                            <span class="student-recent-status"><%# Eval("UploadTimeAgo") %></span>
                                        </div>
                                    </div>
                                    <a class="student-recent-open" href='<%= ResolveUrl("~/Student/ResumeViewer.aspx?file=") %><%# HttpUtility.UrlEncode((string)Eval("FileName")) %>' title="Open in Resume Viewer" aria-label="Open Resume">
                                        <svg viewBox="0 0 24 24"><path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"/><polyline points="15 3 21 3 21 9"/><line x1="10" y1="14" x2="21" y2="3"/></svg>
                                    </a>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <div class="student-baseline-bar">
                        <span>&bull; ATS Baseline Target: <strong>85%</strong></span>
                        <a href="javascript:void(0);">View All History</a>
                    </div>
                </section>

            </aside>

        </div>

    </div>

    <!-- Client-side script for drag and drop and file size validation -->
    <script type="text/javascript">
        function validateResumeFileSize(sender, args) {
            var fileInput = document.getElementById('<%= fileUploadResume.ClientID %>');
            if (fileInput && fileInput.files && fileInput.files.length > 0) {
                var maxBytes = 5 * 1024 * 1024; // 5 MB
                args.IsValid = (fileInput.files[0].size <= maxBytes);
            } else {
                args.IsValid = true;
            }
        }

        document.addEventListener('DOMContentLoaded', function () {
            var dropZone = document.getElementById('dropZone');
            var fileInput = document.getElementById('<%= fileUploadResume.ClientID %>');
            var fileInfo = document.getElementById('selectedFileInfo');
            var fileNameSpan = document.getElementById('selectedFileName');
            var fileSizeSpan = document.getElementById('selectedFileSize');
            var btnRemove = document.getElementById('btnRemoveFile');

            if (!dropZone || !fileInput) return;

            function formatBytes(bytes) {
                if (bytes === 0) return '0 Bytes';
                var k = 1024;
                var sizes = ['Bytes', 'KB', 'MB'];
                var i = Math.floor(Math.log(bytes) / Math.log(k));
                return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
            }

            function updateFileDisplay(file) {
                if (file) {
                    fileNameSpan.textContent = file.name;
                    fileSizeSpan.textContent = formatBytes(file.size);
                    fileInfo.style.display = 'flex';
                } else {
                    fileInfo.style.display = 'none';
                }
            }

            fileInput.addEventListener('change', function () {
                if (fileInput.files && fileInput.files.length > 0) {
                    updateFileDisplay(fileInput.files[0]);
                } else {
                    updateFileDisplay(null);
                }
            });

            if (btnRemove) {
                btnRemove.addEventListener('click', function () {
                    fileInput.value = '';
                    updateFileDisplay(null);
                });
            }

            ['dragenter', 'dragover'].forEach(function (eventName) {
                dropZone.addEventListener(eventName, function (e) {
                    e.preventDefault();
                    e.stopPropagation();
                    dropZone.classList.add('dragover');
                }, false);
            });

            ['dragleave', 'drop'].forEach(function (eventName) {
                dropZone.addEventListener(eventName, function (e) {
                    e.preventDefault();
                    e.stopPropagation();
                    dropZone.classList.remove('dragover');
                }, false);
            });

            dropZone.addEventListener('drop', function (e) {
                var dt = e.dataTransfer;
                if (dt && dt.files && dt.files.length > 0) {
                    fileInput.files = dt.files;
                    updateFileDisplay(dt.files[0]);
                }
            }, false);
        });
    </script>
</asp:Content>

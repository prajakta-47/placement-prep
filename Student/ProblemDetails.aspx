<%@ Page Title="Problem Details" Language="C#" MasterPageFile="~/Student.Master"
    AutoEventWireup="true" CodeBehind="ProblemDetails.aspx.cs"
    Inherits="PlacementPrep.ProblemDetails" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Problem Details | Placement Prep</title>
    <script type="text/javascript">
        function copyCode(btn, text) {
            navigator.clipboard.writeText(text).then(function () {
                var orig = btn.innerText;
                btn.innerText = "Copied!";
                setTimeout(function () { btn.innerText = orig; }, 1800);
            });
        }
    </script>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="student-problem-container">
        
        <!-- Breadcrumb & Top Bar -->
        <div style="font-size:11px; color:#64748b; margin-bottom:12px; display:flex; justify-content:space-between; align-items:center;">
            <div>
                <a href="<%= ResolveUrl("~/Student/CodingProblems.aspx") %>" style="color:#64748b; text-decoration:none;">Coding Problems</a> &rsaquo; 
                <strong style="color:var(--stu-text);"><asp:Label ID="lblBreadcrumbTitle" runat="server" Text="1. Two Sum" /></strong>
            </div>
            <div style="display:flex; gap:8px;">
                <a href="<%= ResolveUrl("~/Student/CodingProblems.aspx") %>" class="stu-btn-outline" style="font-size:10px; padding:4px 10px;">
                    &larr; Back to Problems
                </a>
                <asp:HyperLink ID="lnkOpenEditorTop" runat="server" CssClass="stu-btn-primary" NavigateUrl="~/Student/CodeEditor.aspx?id=1" style="font-size:10px; padding:4px 12px;">
                    Solve in Code Editor &rarr;
                </asp:HyperLink>
            </div>
        </div>

        <!-- Problem Content Grid -->
        <div class="student-problem-grid">
            
            <!-- Left Main Column: Problem Statement & Cases -->
            <div style="display:flex; flex-direction:column; gap:16px;">
                
                <section class="student-extracted-card">
                    <!-- Title & Badges -->
                    <div style="display:flex; align-items:center; justify-content:space-between; flex-wrap:wrap; gap:8px; margin-bottom:12px;">
                        <h1 style="font-size:20px; font-weight:800; margin:0; letter-spacing:-0.5px;">
                            <asp:Label ID="lblProblemTitle" runat="server" Text="1. Two Sum" />
                        </h1>
                        <div style="display:flex; align-items:center; gap:6px;">
                            <span class="difficulty-badge easy">Easy</span>
                            <span style="font-size:10px; color:#64748b; font-weight:700;">Acceptance: 54.2%</span>
                        </div>
                    </div>

                    <!-- Topics & Companies Bar -->
                    <div style="display:flex; flex-wrap:wrap; gap:6px; margin-bottom:16px; padding-bottom:12px; border-bottom:1px solid #f1f2f8;">
                        <span class="student-pill-count">Arrays</span>
                        <span class="student-pill-count">Hash Table</span>
                        <span class="company-chip">Amazon</span>
                        <span class="company-chip">Google</span>
                        <span class="company-chip">Microsoft</span>
                        <span class="company-chip">TCS Digital</span>
                    </div>

                    <!-- Problem Description -->
                    <div style="font-size:12px; line-height:1.6; color:#334155; margin-bottom:16px;">
                        <p style="margin:0 0 10px;">
                            Given an array of integers <code>nums</code> and an integer <code>target</code>, return <em>indices of the two numbers such that they add up to <code>target</code></em>.
                        </p>
                        <p style="margin:0 0 10px;">
                            You may assume that each input would have <strong>exactly one solution</strong>, and you may not use the same element twice.
                        </p>
                        <p style="margin:0;">
                            You can return the answer in any order.
                        </p>
                    </div>

                    <!-- Sample Case 1 -->
                    <div style="margin-bottom:14px;">
                        <strong style="font-size:11px; color:var(--stu-text);">Example 1:</strong>
                        <div class="student-code-block">
                            <button type="button" class="student-copy-btn" onclick="copyCode(this, 'Input: nums = [2,7,11,15], target = 9\nOutput: [0,1]');">Copy</button>
                            <strong>Input:</strong> nums = [2,7,11,15], target = 9<br />
                            <strong>Output:</strong> [0,1]<br />
                            <strong>Explanation:</strong> Because nums[0] + nums[1] == 9, we return [0, 1].
                        </div>
                    </div>

                    <!-- Sample Case 2 -->
                    <div style="margin-bottom:14px;">
                        <strong style="font-size:11px; color:var(--stu-text);">Example 2:</strong>
                        <div class="student-code-block">
                            <button type="button" class="student-copy-btn" onclick="copyCode(this, 'Input: nums = [3,2,4], target = 6\nOutput: [1,2]');">Copy</button>
                            <strong>Input:</strong> nums = [3,2,4], target = 6<br />
                            <strong>Output:</strong> [1,2]<br />
                            <strong>Explanation:</strong> Because nums[1] + nums[2] == 6, we return [1, 2].
                        </div>
                    </div>

                    <!-- Sample Case 3 -->
                    <div style="margin-bottom:16px;">
                        <strong style="font-size:11px; color:var(--stu-text);">Example 3:</strong>
                        <div class="student-code-block">
                            <button type="button" class="student-copy-btn" onclick="copyCode(this, 'Input: nums = [3,3], target = 6\nOutput: [0,1]');">Copy</button>
                            <strong>Input:</strong> nums = [3,3], target = 6<br />
                            <strong>Output:</strong> [0,1]
                        </div>
                    </div>

                    <!-- Constraints -->
                    <div style="background:#f8fafc; border:1px solid #e2e8f0; border-radius:8px; padding:12px 16px; margin-bottom:16px;">
                        <strong style="font-size:11px; color:var(--stu-text); display:block; margin-bottom:6px;">Constraints:</strong>
                        <ul style="margin:0; padding-left:18px; font-size:11px; color:#475569; line-height:1.6;">
                            <li><code>2 &le; nums.length &le; 10<sup>4</sup></code></li>
                            <li><code>-10<sup>9</sup> &le; nums[i] &le; 10<sup>9</sup></code></li>
                            <li><code>-10<sup>9</sup> &le; target &le; 10<sup>9</sup></code></li>
                            <li><strong>Only one valid answer exists.</strong></li>
                        </ul>
                    </div>

                    <!-- Follow up -->
                    <div class="student-shortcut-tip">
                        <strong>Follow-up:</strong> Can you come up with an algorithm that is less than <code>O(n<sup>2</sup>)</code> time complexity?
                    </div>
                </section>

            </div>

            <!-- Right Column: Algorithm Guidance, Personal Stats & Launch -->
            <div style="display:flex; flex-direction:column; gap:16px;">
                
                <!-- Launch Card -->
                <div class="student-extracted-card" style="background:linear-gradient(135deg, #f0fdf9 0%, #e6fffa 100%); border-color:#8fe3d2;">
                    <div class="student-extracted-card-header">
                        <h3 style="color:var(--stu-teal);">
                            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8"><polygon points="5 3 19 12 5 21 5 3"/></svg>
                            <span>Ready to Solve?</span>
                        </h3>
                    </div>
                    <p style="font-size:10.5px; color:#334155; margin:0 0 12px; line-height:1.5;">
                        Open the integrated editor to write, run sample test cases, and verify your solution against our evaluation suite.
                    </p>
                    <asp:HyperLink ID="lnkLaunchEditor" runat="server" CssClass="stu-btn-primary" NavigateUrl="~/Student/CodeEditor.aspx?id=1" style="width:100%; text-align:center; box-sizing:border-box;">
                        Launch Code Editor &rarr;
                    </asp:HyperLink>
                </div>

                <!-- Personal Statistics -->
                <div class="student-extracted-card">
                    <div class="student-extracted-card-header">
                        <h3>
                            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M12 20v-6M6 20V10M18 20V4"/></svg>
                            <span>Your Statistics</span>
                        </h3>
                        <span class="student-badge-correct">&#10003; Solved</span>
                    </div>
                    <div style="display:flex; flex-direction:column; gap:10px; font-size:11px;">
                        <div style="display:flex; justify-content:space-between; border-bottom:1px solid #f1f5f9; padding-bottom:6px;">
                            <span style="color:#64748b;">Submissions:</span>
                            <strong>3 Attempts</strong>
                        </div>
                        <div style="display:flex; justify-content:space-between; border-bottom:1px solid #f1f5f9; padding-bottom:6px;">
                            <span style="color:#64748b;">Best Runtime:</span>
                            <strong style="color:#10b981;">42 ms (faster than 88.4%)</strong>
                        </div>
                        <div style="display:flex; justify-content:space-between;">
                            <span style="color:#64748b;">Memory Usage:</span>
                            <strong>15.6 MB (less than 92.1%)</strong>
                        </div>
                    </div>
                </div>

                <!-- Algorithm Guidance & Approaches -->
                <div class="student-extracted-card">
                    <div class="student-extracted-card-header">
                        <h3>
                            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/></svg>
                            <span>Algorithm Guidance</span>
                        </h3>
                    </div>

                    <div style="font-size:10.5px; color:#475569; line-height:1.5;">
                        <div style="margin-bottom:10px;">
                            <strong style="color:var(--stu-text); display:block;">Approach 1: One-pass Hash Table (Recommended)</strong>
                            While iterating through the array, check if <code>target - nums[i]</code> already exists in the dictionary. If yes, return their indices; otherwise, store <code>nums[i] &rarr; i</code>.
                            <br /><span style="font-size:9.5px; color:#059669; font-weight:700;">Complexity: O(N) Time, O(N) Space</span>
                        </div>
                        <div>
                            <strong style="color:var(--stu-text); display:block;">Approach 2: Brute Force</strong>
                            Check every pair using two nested loops: <code>for i</code> and <code>for j</code>.
                            <br /><span style="font-size:9.5px; color:#dc2626; font-weight:700;">Complexity: O(N<sup>2</sup>) Time, O(1) Space</span>
                        </div>
                    </div>
                </div>

                <!-- Similar Recommended Problems -->
                <div class="student-extracted-card">
                    <div class="student-extracted-card-header">
                        <h3>
                            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 14 14"/></svg>
                            <span>Similar Placement Problems</span>
                        </h3>
                    </div>
                    <ul style="margin:0; padding-left:16px; font-size:10.5px; line-height:1.6; color:#475569;">
                        <li><a href="<%= ResolveUrl("~/Student/ProblemDetails.aspx?id=4") %>" style="color:var(--stu-teal); text-decoration:none; font-weight:700;">Container With Most Water</a> (Medium)</li>
                        <li><a href="<%= ResolveUrl("~/Student/ProblemDetails.aspx?id=5") %>" style="color:var(--stu-teal); text-decoration:none; font-weight:700;">Merge Intervals</a> (Medium)</li>
                        <li><a href="<%= ResolveUrl("~/Student/ProblemDetails.aspx?id=9") %>" style="color:var(--stu-teal); text-decoration:none; font-weight:700;">Trapping Rain Water</a> (Hard)</li>
                    </ul>
                </div>

            </div>

        </div>

    </div>
</asp:Content>

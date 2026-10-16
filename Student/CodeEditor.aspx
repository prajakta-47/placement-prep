<%@ Page Title="Code Editor" Language="C#" MasterPageFile="~/Student.Master"
    AutoEventWireup="true" CodeBehind="CodeEditor.aspx.cs"
    Inherits="PlacementPrep.CodeEditor" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Code Editor | Placement Prep</title>
    <style>
        .ide-console-output {
            background: #0f172a;
            color: #e2e8f0;
            border-radius: 6px;
            padding: 10px 12px;
            font-family: Consolas, monospace;
            font-size: 10.5px;
            line-height: 1.5;
            min-height: 90px;
            max-height: 130px;
            overflow-y: auto;
            margin-top: 8px;
            border: 1px solid #1e293b;
        }
        .ide-pass-badge {
            display: inline-block;
            background: #065f46;
            color: #34d399;
            padding: 2px 6px;
            border-radius: 4px;
            font-weight: 800;
            font-size: 9.5px;
        }
        .ide-sandbox-pill {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            background: rgba(56, 189, 248, 0.15);
            color: #38bdf8;
            padding: 2px 8px;
            border-radius: 10px;
            font-size: 9px;
            font-weight: 700;
        }
    </style>
    <script type="text/javascript">
        function changeFontSize(size) {
            var editor = document.getElementById('<%= txtCodeArea.ClientID %>');
            if (editor) {
                editor.style.fontSize = size;
            }
        }

        function switchTestTab(tabId) {
            document.querySelectorAll('.student-ide-tab-btn').forEach(function (b) { b.classList.remove('active'); });
            var btn = document.getElementById('tab-btn-' + tabId);
            if (btn) btn.classList.add('active');

            var c1 = document.getElementById('case-view-1');
            var c2 = document.getElementById('case-view-2');
            var custom = document.getElementById('case-view-custom');

            if (c1) c1.style.display = (tabId === 1) ? 'block' : 'none';
            if (c2) c2.style.display = (tabId === 2) ? 'block' : 'none';
            if (custom) custom.style.display = (tabId === 3) ? 'block' : 'none';
        }
    </script>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="student-ide-container">
        
        <!-- IDE Split Layout -->
        <div class="student-ide-grid">
            
            <!-- Left Pane: Problem Description -->
            <div class="student-ide-left-pane">
                <div style="display:flex; align-items:center; justify-content:space-between;">
                    <a href="<%= ResolveUrl("~/Student/ProblemDetails.aspx?id=1") %>" style="font-size:10px; color:#64748b; text-decoration:none;">
                        &larr; View Details
                    </a>
                    <span class="difficulty-badge easy">Easy</span>
                </div>

                <div>
                    <h2 style="font-size:18px; font-weight:800; margin:0 0 4px; letter-spacing:-0.5px; color:var(--stu-text);">
                        <asp:Label ID="lblEditorProblemTitle" runat="server" Text="1. Two Sum" />
                    </h2>
                    <span style="font-size:9.5px; color:#64748b;">Tags: Arrays, Hash Table &bull; Amazon, Google</span>
                </div>

                <div style="font-size:11px; line-height:1.6; color:#475569;">
                    <p style="margin:0 0 8px;">
                        Given an array of integers <code>nums</code> and an integer <code>target</code>, return indices of the two numbers such that they add up to <code>target</code>.
                    </p>
                    <p style="margin:0 0 8px;">
                        You may assume that each input would have <strong>exactly one solution</strong>, and you may not use the same element twice.
                    </p>
                </div>

                <!-- Test Case Mini Example -->
                <div style="background:#f8fafc; border:1px solid #e2e8f0; border-radius:6px; padding:10px 12px; font-size:10.5px;">
                    <strong style="color:var(--stu-text); display:block; margin-bottom:4px;">Sample 1:</strong>
                    <code>nums = [2,7,11,15], target = 9</code><br />
                    <span style="color:#059669; font-weight:700;">Output: [0, 1]</span>
                </div>

                <div style="background:#f8fafc; border:1px solid #e2e8f0; border-radius:6px; padding:10px 12px; font-size:10.5px;">
                    <strong style="color:var(--stu-text); display:block; margin-bottom:4px;">Sample 2:</strong>
                    <code>nums = [3,2,4], target = 6</code><br />
                    <span style="color:#059669; font-weight:700;">Output: [1, 2]</span>
                </div>

                <!-- Constraints -->
                <div>
                    <strong style="font-size:10.5px; color:var(--stu-text); display:block; margin-bottom:4px;">Constraints:</strong>
                    <ul style="margin:0; padding-left:16px; font-size:10px; color:#64748b; line-height:1.5;">
                        <li><code>2 &le; nums.length &le; 10<sup>4</sup></code></li>
                        <li><code>-10<sup>9</sup> &le; nums[i] &le; 10<sup>9</sup></code></li>
                        <li><code>-10<sup>9</sup> &le; target &le; 10<sup>9</sup></code></li>
                    </ul>
                </div>

                <div class="student-shortcut-tip" style="margin-top:auto;">
                    <strong>Notice:</strong> This web code editor runs in simulated evaluation mode. Code execution and verification are handled through testcase assertions directly in the browser session.
                </div>
            </div>

            <!-- Right Pane: Code Studio & Terminal -->
            <div class="student-ide-right-pane">
                
                <!-- Toolbar -->
                <div class="student-ide-toolbar">
                    <div style="display:flex; align-items:center; gap:10px;">
                        <asp:DropDownList ID="ddlLanguage" runat="server" CssClass="stu-btn-outline" AutoPostBack="true" OnSelectedIndexChanged="ddlLanguage_SelectedIndexChanged" style="background:#1e293b; color:#e2e8f0; border-color:#475569; padding:4px 8px; font-size:10px;">
                            <asp:ListItem Value="csharp" Selected="True">C# (Mono .NET)</asp:ListItem>
                            <asp:ListItem Value="cpp">C++ (GCC 11)</asp:ListItem>
                            <asp:ListItem Value="java">Java (OpenJDK 17)</asp:ListItem>
                            <asp:ListItem Value="python">Python 3.10</asp:ListItem>
                            <asp:ListItem Value="javascript">JavaScript (Node.js)</asp:ListItem>
                        </asp:DropDownList>

                        <div style="display:flex; align-items:center; gap:4px; font-size:10px; color:#94a3b8;">
                            <span>Font:</span>
                            <button type="button" class="student-filter-tab" style="padding:2px 6px; font-size:9px;" onclick="changeFontSize('11px');">A-</button>
                            <button type="button" class="student-filter-tab" style="padding:2px 6px; font-size:9px;" onclick="changeFontSize('13px');">A</button>
                            <button type="button" class="student-filter-tab" style="padding:2px 6px; font-size:9px;" onclick="changeFontSize('15px');">A+</button>
                        </div>
                    </div>

                    <div style="display:flex; align-items:center; gap:8px;">
                        <span class="ide-sandbox-pill">&#9881; Simulation Mode</span>
                        <asp:Button ID="btnResetCode" runat="server" CssClass="btn-ide-run" Text="Reset" OnClick="btnResetCode_Click" style="padding:4px 8px; font-size:9.5px;" />
                    </div>
                </div>

                <!-- Code Textarea -->
                <asp:TextBox ID="txtCodeArea" runat="server" TextMode="MultiLine" CssClass="student-ide-editor" spellcheck="false" />

                <!-- Bottom Panel: Testcases & Execution Console -->
                <div class="student-ide-bottom">
                    <div class="student-ide-bottom-tabs">
                        <div style="display:flex; align-items:center; gap:6px;">
                            <button type="button" id="tab-btn-1" class="student-ide-tab-btn active" onclick="switchTestTab(1);">Case 1</button>
                            <button type="button" id="tab-btn-2" class="student-ide-tab-btn" onclick="switchTestTab(2);">Case 2</button>
                            <button type="button" id="tab-btn-3" class="student-ide-tab-btn" onclick="switchTestTab(3);">+ Custom Input</button>
                        </div>

                        <!-- Action Buttons -->
                        <div class="student-ide-actions">
                            <asp:Button ID="btnRunCode" runat="server" CssClass="btn-ide-run" Text="&#9654; Run Code" OnClick="btnRunCode_Click" />
                            <asp:Button ID="btnSubmitCode" runat="server" CssClass="btn-ide-submit" Text="&#10003; Submit Solution" OnClick="btnSubmitCode_Click" />
                        </div>
                    </div>

                    <!-- Test Case Panels -->
                    <div id="case-view-1" style="font-size:10px; color:#cbd5e1; font-family:Consolas, monospace;">
                        <span>nums = [2, 7, 11, 15] &bull; target = 9</span>
                    </div>

                    <div id="case-view-2" style="display:none; font-size:10px; color:#cbd5e1; font-family:Consolas, monospace;">
                        <span>nums = [3, 2, 4] &bull; target = 6</span>
                    </div>

                    <div id="case-view-3" style="display:none;">
                        <asp:TextBox ID="txtCustomInput" runat="server" CssClass="stu-input" style="background:#0f172a; color:#e2e8f0; border-color:#334155; height:28px; font-size:10px;" placeholder="e.g. nums = [1,5,8], target = 9" />
                    </div>

                    <!-- Output Console Area -->
                    <div class="ide-console-output">
                        <asp:Literal ID="litConsoleOutput" runat="server">
                            <span style="color:#64748b;">// Click "Run Code" to test against sample cases or "Submit Solution" to run full evaluation suite.</span>
                        </asp:Literal>
                    </div>
                </div>

            </div>

        </div>

    </div>
</asp:Content>

<%@ Page Title="AI Config" Language="C#" MasterPageFile="~/Faculty.Master" AutoEventWireup="true" CodeBehind="AIConfig.aspx.cs" Inherits="PlacementPrep.Faculty.AIConfig" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <style>
        .ai-config-wrap {
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .faculty-alert {
            display: flex;
            align-items: center;
            padding: 10px 14px;
            border-radius: 8px;
            font-size: 12px;
            gap: 10px;
        }

        .faculty-alert-success {
            background: #e6f9f5;
            color: #00685e;
            border: 1px solid #b5f0e5;
        }

        .faculty-alert-info {
            background: #f0f4ff;
            color: #2b4c7e;
            border: 1px solid #d4e0fc;
        }

        /* Action bar */
        .ai-action-buttons {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-fac-secondary {
            background: #ffffff;
            color: var(--fac-text);
            border: 1px solid #d9dfeb;
            padding: 6px 14px;
            border-radius: 6px;
            font-size: 11px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.15s ease;
        }

        .btn-fac-secondary:hover {
            background: #f4f6fa;
            border-color: #cbd3e2;
        }

        .btn-fac-primary {
            background: var(--fac-teal);
            color: #ffffff;
            border: 1px solid var(--fac-dark-teal);
            padding: 6px 16px;
            border-radius: 6px;
            font-size: 11px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.15s ease;
        }

        .btn-fac-primary:hover {
            background: var(--fac-dark-teal);
        }

        /* Tab Bar */
        .faculty-tab-bar {
            display: flex;
            align-items: center;
            gap: 6px;
            background: #ffffff;
            padding: 6px 8px;
            border-radius: 8px;
            border: 1px solid var(--fac-border);
            overflow-x: auto;
        }

        .faculty-tab-btn {
            display: flex;
            align-items: center;
            gap: 6px;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 11px;
            font-weight: 500;
            color: var(--fac-muted);
            border: 1px solid transparent;
            background: transparent;
            cursor: pointer;
            text-decoration: none;
            white-space: nowrap;
            transition: all 0.15s ease;
        }

        .faculty-tab-btn:hover {
            background: #f4f6fb;
            color: var(--fac-text);
        }

        .faculty-tab-btn.active {
            background: var(--fac-teal);
            color: #ffffff;
            font-weight: 600;
        }

        .faculty-tab-btn svg {
            width: 14px;
            height: 14px;
            stroke: currentColor;
            fill: none;
            stroke-width: 2;
        }

        /* Code & textareas */
        .faculty-prompt-textarea {
            width: 100%;
            font-family: 'Consolas', 'Courier New', monospace;
            font-size: 12px;
            line-height: 1.6;
            color: #1e293b;
            background: #fafbfe;
            border: 1px solid #dde3ea;
            border-radius: 8px;
            padding: 12px;
            box-sizing: border-box;
            resize: vertical;
            transition: border-color 0.15s ease, box-shadow 0.15s ease;
        }

        .faculty-prompt-textarea:focus {
            outline: none;
            border-color: var(--fac-teal);
            box-shadow: 0 0 0 3px rgba(0, 104, 94, 0.1);
            background: #ffffff;
        }

        .prompt-meta-strip {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 8px;
            padding-top: 8px;
            border-top: 1px solid #f0f3f8;
            font-size: 11px;
            color: var(--fac-muted);
        }

        /* Parameter fields */
        .fac-field-group {
            display: flex;
            flex-direction: column;
            gap: 4px;
            margin-bottom: 12px;
        }

        .fac-field-label {
            font-size: 11px;
            font-weight: 600;
            color: var(--fac-text);
            display: flex;
            justify-content: space-between;
        }

        .fac-field-help {
            font-size: 10px;
            color: var(--fac-muted);
            margin-top: 2px;
        }

        .fac-control {
            width: 100%;
            padding: 7px 10px;
            font-size: 12px;
            color: var(--fac-text);
            background: #ffffff;
            border: 1px solid #dde3ea;
            border-radius: 6px;
            box-sizing: border-box;
            transition: border-color 0.15s ease;
        }

        .fac-control:focus {
            outline: none;
            border-color: var(--fac-teal);
        }

        .fac-checkbox-label {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 11px;
            font-weight: 500;
            cursor: pointer;
            user-select: none;
        }

        /* Live test console */
        .json-preview-box {
            background: #0f172a;
            color: #38bdf8;
            font-family: 'Consolas', 'Courier New', monospace;
            font-size: 11px;
            line-height: 1.5;
            padding: 12px;
            border-radius: 6px;
            overflow-x: auto;
            white-space: pre-wrap;
            border: 1px solid #1e293b;
        }

        .spec-badge {
            display: inline-flex;
            align-items: center;
            padding: 2px 7px;
            border-radius: 4px;
            font-size: 10px;
            font-weight: 600;
            background: #eef2f6;
            color: #475569;
        }

        .spec-badge-teal {
            background: var(--fac-mint);
            color: var(--fac-dark-teal);
        }
    </style>
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="faculty-dashboard ai-config-wrap">

    <!-- Header with title & actions -->
    <div class="faculty-dashboard-heading" style="margin-bottom:0;">
        <div>
            <h1>AI Prompt &amp; Model Configuration</h1>
            <p>Fine-tune system prompts, model temperatures, and evaluation rubrics driving student AI assessments</p>
        </div>
        <div class="ai-action-buttons">
            <asp:Button ID="btnDiscard" runat="server" Text="Discard Changes" CssClass="btn-fac-secondary" OnClick="btnDiscard_Click" CausesValidation="false" />
            <asp:Button ID="btnDeploy" runat="server" Text="Deploy Configuration" CssClass="btn-fac-primary" ValidationGroup="valPrompt" OnClick="btnDeploy_Click" />
        </div>
    </div>

    <!-- Alert Banner -->
    <asp:Panel ID="pnlAlert" runat="server" Visible="false">
        <svg viewBox="0 0 24 24" style="width:16px; height:16px; stroke:currentColor; fill:none; stroke-width:2;" aria-hidden="true">
            <circle cx="12" cy="12" r="10" />
            <path d="m9 12 2 2 4-4" />
        </svg>
        <span><asp:Literal ID="litAlertMessage" runat="server" /></span>
    </asp:Panel>

    <!-- Validation Summary -->
    <asp:ValidationSummary ID="valSummaryPrompt" runat="server" ValidationGroup="valPrompt" 
        CssClass="faculty-alert faculty-alert-info" 
        HeaderText="Please review the parameter inputs:" />

    <!-- Metric Cards Grid -->
    <div class="faculty-metric-grid">
        <article class="faculty-metric-card">
            <div class="faculty-metric-top">
                <span class="faculty-metric-icon" style="background:#e6f9f5; color:#00685e;">
                    <svg viewBox="0 0 24 24" aria-hidden="true" style="width:18px; height:18px; stroke:currentColor; fill:none; stroke-width:2;">
                        <path d="M12 3a7 7 0 0 0-4 12.7V19h8v-3.3A7 7 0 0 0 12 3z"/>
                        <path d="M9 22h6m-3-15v5m-2-2h4"/>
                    </svg>
                </span>
                <span class="faculty-tag" style="background:#e6f9f5; color:#00685e;">Production</span>
            </div>
            <div class="faculty-metric-value" style="font-size:18px; margin-top:8px;">GPT-4 Turbo</div>
            <div class="faculty-metric-caption">Primary inference engine</div>
            <div class="faculty-metric-change">Avg latency: 420ms</div>
        </article>

        <article class="faculty-metric-card">
            <div class="faculty-metric-top">
                <span class="faculty-metric-icon" style="background:#e4edff; color:#415978;">
                    <svg viewBox="0 0 24 24" aria-hidden="true" style="width:18px; height:18px; stroke:currentColor; fill:none; stroke-width:2;">
                        <rect x="4" y="4" width="16" height="16" rx="2" />
                        <path d="M4 10h16M10 4v16" />
                    </svg>
                </span>
                <span class="faculty-tag" style="background:#e4edff; color:#2c4b82;">4 Active</span>
            </div>
            <div class="faculty-metric-value" style="font-size:18px; margin-top:8px;">Inference Modules</div>
            <div class="faculty-metric-caption">Resume, Mock, Gap, Questions</div>
            <div class="faculty-metric-change">100% operational</div>
        </article>

        <article class="faculty-metric-card">
            <div class="faculty-metric-top">
                <span class="faculty-metric-icon" style="background:#fef3c7; color:#92400e;">
                    <svg viewBox="0 0 24 24" aria-hidden="true" style="width:18px; height:18px; stroke:currentColor; fill:none; stroke-width:2;">
                        <polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2" />
                    </svg>
                </span>
                <span class="faculty-tag" style="background:#fef3c7; color:#92400e;">Tokens</span>
            </div>
            <div class="faculty-metric-value" style="font-size:18px; margin-top:8px;">482 avg / call</div>
            <div class="faculty-metric-caption">Monthly budget utilization</div>
            <div class="faculty-metric-change">64% of 100k quota</div>
        </article>

        <article class="faculty-metric-card">
            <div class="faculty-metric-top">
                <span class="faculty-metric-icon" style="background:#f3e8ff; color:#6b21a8;">
                    <svg viewBox="0 0 24 24" aria-hidden="true" style="width:18px; height:18px; stroke:currentColor; fill:none; stroke-width:2;">
                        <circle cx="12" cy="12" r="10" />
                        <path d="m10 15 5-3-5-3v6z" />
                    </svg>
                </span>
                <span class="faculty-tag" style="background:#f3e8ff; color:#6b21a8;">Alignment</span>
            </div>
            <div class="faculty-metric-value" style="font-size:18px; margin-top:8px;">98.4%</div>
            <div class="faculty-metric-caption">Faculty rubric benchmark</div>
            <div class="faculty-metric-change">+1.2% over last cycle</div>
        </article>
    </div>

    <!-- Module Selector Tab Bar -->
    <div class="faculty-tab-bar">
        <asp:LinkButton ID="btnTabResume" runat="server" CssClass="faculty-tab-btn" OnClick="SelectModule_Resume" CausesValidation="false">
            <svg viewBox="0 0 24 24"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/></svg>
            <span>Resume Parser</span>
        </asp:LinkButton>
        <asp:LinkButton ID="btnTabMock" runat="server" CssClass="faculty-tab-btn" OnClick="SelectModule_Mock" CausesValidation="false">
            <svg viewBox="0 0 24 24"><path d="M12 2a3 3 0 0 0-3 3v7a3 3 0 0 0 6 0V5a3 3 0 0 0-3-3z"/><path d="M19 10v2a7 7 0 0 1-14 0v-2"/><line x1="12" y1="19" x2="12" y2="23"/></svg>
            <span>Mock Interview</span>
        </asp:LinkButton>
        <asp:LinkButton ID="btnTabGap" runat="server" CssClass="faculty-tab-btn" OnClick="SelectModule_Gap" CausesValidation="false">
            <svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><circle cx="12" cy="12" r="6"/><circle cx="12" cy="12" r="2"/></svg>
            <span>Skill Gap Analysis</span>
        </asp:LinkButton>
        <asp:LinkButton ID="btnTabQuestions" runat="server" CssClass="faculty-tab-btn" OnClick="SelectModule_Questions" CausesValidation="false">
            <svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"/><line x1="12" y1="17" x2="12.01" y2="17"/></svg>
            <span>Question Generator</span>
        </asp:LinkButton>
    </div>

    <!-- Dual Column Main Layout -->
    <div class="faculty-dashboard-grid">

        <!-- Left Column: System Prompt & Testing Sandbox -->
        <div class="faculty-left-column">

            <!-- Prompt Definition Panel -->
            <section class="faculty-panel">
                <div class="faculty-panel-heading">
                    <div>
                        <h2><asp:Literal ID="litActiveModuleName" runat="server" /></h2>
                        <p><asp:Literal ID="litActiveModuleDesc" runat="server" /></p>
                    </div>
                    <div style="display:flex; gap:6px;">
                        <span class="spec-badge spec-badge-teal">Active</span>
                        <span class="spec-badge"><asp:Literal ID="litVersionTag" runat="server" /></span>
                    </div>
                </div>

                <div style="margin-top:12px;">
                    <label class="fac-field-label" style="margin-bottom:6px;">
                        <span>System Prompt Instructions</span>
                        <span style="font-weight:400; color:var(--fac-muted);">Markdown supported</span>
                    </label>

                    <asp:TextBox ID="txtSystemPrompt" runat="server" 
                        TextMode="MultiLine" Rows="13" 
                        CssClass="faculty-prompt-textarea" />

                    <asp:RequiredFieldValidator ID="rfvPrompt" runat="server" 
                        ControlToValidate="txtSystemPrompt" 
                        ErrorMessage="System Prompt cannot be blank." 
                        ValidationGroup="valPrompt" 
                        Display="Dynamic" 
                        ForeColor="#dc2626" 
                        style="font-size:11px; margin-top:4px;" />

                    <div class="prompt-meta-strip">
                        <div>
                            <span>Last updated: <strong><asp:Literal ID="litLastUpdated" runat="server" /></strong></span>
                            <span style="margin-left:10px;">By: <strong><asp:Literal ID="litUpdatedBy" runat="server" /></strong></span>
                        </div>
                        <div>
                            <span>Estimated Prompt Tokens: <strong><asp:Literal ID="litTokenEstimate" runat="server" /></strong></span>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Test Inference Sandbox Panel -->
            <section class="faculty-panel">
                <div class="faculty-panel-heading">
                    <div>
                        <h2>Interactive Prompt Sandbox</h2>
                        <p>Simulate model execution against sample input payload to verify schema validation and output quality</p>
                    </div>
                    <asp:Button ID="btnExecuteTest" runat="server" 
                        Text="Run Test Simulation" 
                        CssClass="btn-fac-secondary" 
                        OnClick="btnExecuteTest_Click" 
                        ValidationGroup="valPrompt" />
                </div>

                <div style="margin-top:12px;">
                    <div class="fac-field-group">
                        <label class="fac-field-label">Sample Input Payload (JSON)</label>
                        <asp:TextBox ID="txtTestPayload" runat="server" 
                            TextMode="MultiLine" Rows="4" 
                            CssClass="faculty-prompt-textarea" 
                            style="font-size:11px;" />
                    </div>

                    <asp:Panel ID="pnlTestOutput" runat="server" Visible="false" style="margin-top:12px;">
                        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:6px;">
                            <span style="font-size:11px; font-weight:600; color:var(--fac-text);">Simulation Output Payload</span>
                            <span style="font-size:10px; color:var(--fac-muted);">Timestamp: <asp:Literal ID="litExecutionTimestamp" runat="server" /> &bull; Latency: 382ms</span>
                        </div>
                        <div class="json-preview-box">
<asp:Literal ID="litTestResultJson" runat="server" />
                        </div>
                    </asp:Panel>
                </div>
            </section>

        </div>

        <!-- Right Column: Parameters & Controls -->
        <aside class="faculty-right-column">

            <!-- Hyperparameters Panel -->
            <section class="faculty-panel">
                <div class="faculty-panel-heading">
                    <h2>Model Hyperparameters</h2>
                </div>

                <div style="margin-top:12px;">
                    <div class="fac-field-group">
                        <label class="fac-field-label">Inference Engine</label>
                        <asp:DropDownList ID="ddlModelEngine" runat="server" CssClass="fac-control">
                            <asp:ListItem Value="gpt-4-turbo" Text="OpenAI GPT-4 Turbo (Standard)" Selected="True" />
                            <asp:ListItem Value="claude-3-5-sonnet" Text="Anthropic Claude 3.5 Sonnet" />
                            <asp:ListItem Value="gemini-1.5-pro" Text="Google Gemini 1.5 Pro" />
                        </asp:DropDownList>
                        <span class="fac-field-help">Target LLM provider endpoint</span>
                    </div>

                    <div class="fac-field-group">
                        <label class="fac-field-label">
                            <span>Temperature</span>
                            <span style="font-weight:400; color:var(--fac-muted);">[0.0 - 1.0]</span>
                        </label>
                        <asp:TextBox ID="txtTemperature" runat="server" CssClass="fac-control" />
                        <asp:RequiredFieldValidator ID="rfvTemperature" runat="server" 
                            ControlToValidate="txtTemperature" 
                            ErrorMessage="Temperature is required." 
                            ValidationGroup="valPrompt" Display="Dynamic" ForeColor="#dc2626" style="font-size:10px;" />
                        <asp:RangeValidator ID="rvTemperature" runat="server" 
                            ControlToValidate="txtTemperature" 
                            MinimumValue="0.0" MaximumValue="1.0" Type="Double" 
                            ErrorMessage="Temperature must be between 0.0 and 1.0" 
                            ValidationGroup="valPrompt" Display="Dynamic" ForeColor="#dc2626" style="font-size:10px;" />
                        <span class="fac-field-help">Lower = deterministic evaluation; Higher = creative advice</span>
                    </div>

                    <div class="fac-field-group">
                        <label class="fac-field-label">
                            <span>Max Output Tokens</span>
                            <span style="font-weight:400; color:var(--fac-muted);">[256 - 8192]</span>
                        </label>
                        <asp:TextBox ID="txtMaxTokens" runat="server" CssClass="fac-control" />
                        <asp:RequiredFieldValidator ID="rfvMaxTokens" runat="server" 
                            ControlToValidate="txtMaxTokens" 
                            ErrorMessage="Max tokens limit is required." 
                            ValidationGroup="valPrompt" Display="Dynamic" ForeColor="#dc2626" style="font-size:10px;" />
                        <asp:RangeValidator ID="rvMaxTokens" runat="server" 
                            ControlToValidate="txtMaxTokens" 
                            MinimumValue="256" MaximumValue="8192" Type="Integer" 
                            ErrorMessage="Tokens must be an integer between 256 and 8192" 
                            ValidationGroup="valPrompt" Display="Dynamic" ForeColor="#dc2626" style="font-size:10px;" />
                        <span class="fac-field-help">Enforces upper bound on response generation</span>
                    </div>

                    <div class="fac-field-group" style="margin-top:6px;">
                        <label class="fac-checkbox-label">
                            <asp:CheckBox ID="chkStrictJson" runat="server" />
                            <span>Strict JSON Schema Enforcement</span>
                        </label>
                        <span class="fac-field-help" style="margin-left:22px;">Rejects non-conforming responses automatically</span>
                    </div>
                </div>
            </section>

            <!-- Safety Guardrails -->
            <section class="faculty-panel">
                <div class="faculty-panel-heading">
                    <h2>Guardrails &amp; Policies</h2>
                </div>

                <div style="display:flex; flex-direction:column; gap:8px; margin-top:10px; font-size:11px;">
                    <div style="display:flex; justify-content:space-between; align-items:center; padding:6px 0; border-bottom:1px solid #f0f3f8;">
                        <span style="color:var(--fac-text);">Prompt Injection Defense</span>
                        <span class="spec-badge spec-badge-teal">Active</span>
                    </div>
                    <div style="display:flex; justify-content:space-between; align-items:center; padding:6px 0; border-bottom:1px solid #f0f3f8;">
                        <span style="color:var(--fac-text);">Student PII Masking</span>
                        <span class="spec-badge spec-badge-teal">Enforced</span>
                    </div>
                    <div style="display:flex; justify-content:space-between; align-items:center; padding:6px 0; border-bottom:1px solid #f0f3f8;">
                        <span style="color:var(--fac-text);">Automated Grading Audit</span>
                        <span class="spec-badge spec-badge-teal">Enabled</span>
                    </div>
                    <div style="display:flex; justify-content:space-between; align-items:center; padding:6px 0;">
                        <span style="color:var(--fac-text);">Coordinator Review Gate</span>
                        <span class="spec-badge">Mandatory for v3.0+</span>
                    </div>
                </div>
            </section>

            <!-- Version Timeline -->
            <section class="faculty-panel">
                <div class="faculty-panel-heading">
                    <h2>Prompt Revision History</h2>
                </div>

                <div class="faculty-timeline" style="margin-top:10px;">
                    <article class="faculty-timeline-item">
                        <span class="faculty-timeline-marker">&bull;</span>
                        <div class="faculty-activity-content">
                            <div class="faculty-activity-title">
                                <strong>v2.4.1 Production Sync</strong>
                                <small>Today</small>
                            </div>
                            <p>Refined STAR formula grading weightage for technical projects.</p>
                        </div>
                    </article>

                    <article class="faculty-timeline-item">
                        <span class="faculty-timeline-marker">&bull;</span>
                        <div class="faculty-activity-content">
                            <div class="faculty-activity-title">
                                <strong>v2.3.8 Strict JSON schema</strong>
                                <small>3 days ago</small>
                            </div>
                            <p>Enabled schema lock for mock interview evaluation payload.</p>
                        </div>
                    </article>
                </div>
            </section>

        </aside>

    </div>

</div>
</asp:Content>

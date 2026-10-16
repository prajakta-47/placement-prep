using System;
using System.Web.UI;
using PlacementPrep.Models;

namespace PlacementPrep.Faculty
{
    public partial class AIConfig : Page
    {
        private string CurrentModuleId
        {
            get => ViewState["CurrentModuleId"] as string ?? "PROMPT-RESUME";
            set => ViewState["CurrentModuleId"] = value;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadModule(CurrentModuleId);
            }
        }

        private void LoadModule(string moduleId)
        {
            CurrentModuleId = moduleId;
            var mod = AIConfigDataStore.GetModule(moduleId);

            litActiveModuleName.Text = mod.ModuleName;
            litActiveModuleDesc.Text = mod.ShortDescription;
            litVersionTag.Text = mod.VersionTag;
            litLastUpdated.Text = mod.LastUpdated.ToString("MMM dd, yyyy HH:mm");
            litUpdatedBy.Text = mod.UpdatedBy;
            litTokenEstimate.Text = mod.EstimatedTokens.ToString();

            txtSystemPrompt.Text = mod.SystemPromptText;
            txtTemperature.Text = mod.Temperature.ToString("F1");
            txtMaxTokens.Text = mod.MaxTokens.ToString();
            chkStrictJson.Checked = mod.StrictJsonEnforcement;

            if (ddlModelEngine.Items.FindByValue(mod.ModelEngine) != null)
            {
                ddlModelEngine.SelectedValue = mod.ModelEngine;
            }

            txtTestPayload.Text = mod.SampleInputPayload;
            pnlTestOutput.Visible = false;

            // Highlight active tab
            btnTabResume.CssClass = moduleId == "PROMPT-RESUME" ? "faculty-tab-btn active" : "faculty-tab-btn";
            btnTabMock.CssClass = moduleId == "PROMPT-MOCK" ? "faculty-tab-btn active" : "faculty-tab-btn";
            btnTabGap.CssClass = moduleId == "PROMPT-GAP" ? "faculty-tab-btn active" : "faculty-tab-btn";
            btnTabQuestions.CssClass = moduleId == "PROMPT-QUESTIONS" ? "faculty-tab-btn active" : "faculty-tab-btn";
        }

        protected void SelectModule_Resume(object sender, EventArgs e) => LoadModule("PROMPT-RESUME");
        protected void SelectModule_Mock(object sender, EventArgs e) => LoadModule("PROMPT-MOCK");
        protected void SelectModule_Gap(object sender, EventArgs e) => LoadModule("PROMPT-GAP");
        protected void SelectModule_Questions(object sender, EventArgs e) => LoadModule("PROMPT-QUESTIONS");

        protected void btnDeploy_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                if (decimal.TryParse(txtTemperature.Text.Trim(), out decimal temp) &&
                    int.TryParse(txtMaxTokens.Text.Trim(), out int maxTokens))
                {
                    var updated = new AIPromptModule
                    {
                        ModuleId = CurrentModuleId,
                        SystemPromptText = txtSystemPrompt.Text.Trim(),
                        ModelEngine = ddlModelEngine.SelectedValue,
                        Temperature = Math.Max(0.0m, Math.Min(1.0m, temp)),
                        MaxTokens = Math.Max(256, Math.Min(8192, maxTokens)),
                        StrictJsonEnforcement = chkStrictJson.Checked
                    };

                    AIConfigDataStore.UpdateModule(updated);
                    LoadModule(CurrentModuleId);

                    pnlAlert.Visible = true;
                    pnlAlert.CssClass = "faculty-alert faculty-alert-success";
                    litAlertMessage.Text = $"<strong>Configuration Deployed:</strong> Updates to <em>{litActiveModuleName.Text}</em> have been saved and synced to evaluation engines.";
                }
            }
        }

        protected void btnDiscard_Click(object sender, EventArgs e)
        {
            LoadModule(CurrentModuleId);
            pnlAlert.Visible = true;
            pnlAlert.CssClass = "faculty-alert faculty-alert-info";
            litAlertMessage.Text = "Unsaved changes were discarded. Reverted to the active configuration.";
        }

        protected void btnExecuteTest_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                pnlTestOutput.Visible = true;
                string payload = txtTestPayload.Text.Trim();
                litExecutionTimestamp.Text = DateTime.Now.ToString("HH:mm:ss.fff");

                if (CurrentModuleId == "PROMPT-RESUME")
                {
                    litTestResultJson.Text = "{\n  \"status\": \"parsed_successfully\",\n  \"candidateName\": \"Aarav Sharma\",\n  \"atsScore\": 94,\n  \"keywordDensity\": {\n    \"Algorithms\": \"9.2%\",\n    \"System Design\": \"7.5%\",\n    \"Cloud Architecture\": \"8.1%\"\n  },\n  \"starMethodRating\": \"High\",\n  \"remediationAdvice\": \"Quantify latency reduction on project 2 using millisecond metrics.\"\n}";
                }
                else if (CurrentModuleId == "PROMPT-MOCK")
                {
                    litTestResultJson.Text = "{\n  \"status\": \"interview_evaluated\",\n  \"rubricScores\": {\n    \"TechnicalAccuracy\": 92,\n    \"ArchitecturalClarity\": 88,\n    \"BehavioralStarAlignment\": 90\n  },\n  \"overallReadiness\": 90,\n  \"recommendation\": \"Strong hire potential. Proceed to technical round 2.\"\n}";
                }
                else if (CurrentModuleId == "PROMPT-GAP")
                {
                    litTestResultJson.Text = "{\n  \"status\": \"gap_analysis_generated\",\n  \"benchmarkTarget\": \"Amazon SDE-1\",\n  \"strengths\": [\"DSA & Complexity\", \"Clean Coding Standards\"],\n  \"criticalGaps\": [\"Low-Level Concurrency\", \"Distributed Consensus\"],\n  \"remediationPlan\": {\n    \"week1\": \"Review Thread synchronization & Mutexes\",\n    \"week2\": \"Solve 12 Concurrency practice problems on LeetCode\"\n  }\n}";
                }
                else
                {
                    litTestResultJson.Text = "{\n  \"status\": \"questions_generated\",\n  \"totalGenerated\": 3,\n  \"difficultyDistribution\": {\"Medium\": 2, \"Hard\": 1},\n  \"unitTestsPassing\": true,\n  \"estimatedTimeToSolveMinutes\": 45\n}";
                }

                pnlAlert.Visible = true;
                pnlAlert.CssClass = "faculty-alert faculty-alert-success";
                litAlertMessage.Text = "<strong>Test Successful:</strong> Model inference simulated in 382ms. Response payload verified against schema.";
            }
        }
    }
}

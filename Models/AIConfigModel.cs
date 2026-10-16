using System;
using System.Collections.Generic;
using System.Linq;

namespace PlacementPrep.Models
{
    public class AIPromptModule
    {
        public string ModuleId { get; set; }
        public string ModuleName { get; set; }
        public string ShortDescription { get; set; }
        public string SystemPromptText { get; set; }
        public string ModelEngine { get; set; }
        public decimal Temperature { get; set; }
        public int MaxTokens { get; set; }
        public bool StrictJsonEnforcement { get; set; }
        public int EstimatedTokens { get; set; }
        public string VersionTag { get; set; }
        public DateTime LastUpdated { get; set; }
        public string UpdatedBy { get; set; }
        public string SampleInputPayload { get; set; }
    }

    public static class AIConfigDataStore
    {
        private static readonly object _lock = new object();
        private static List<AIPromptModule> _modules;

        static AIConfigDataStore()
        {
            ResetToDefaults();
        }

        public static List<AIPromptModule> GetAllModules()
        {
            lock (_lock)
            {
                return _modules.Select(Clone).ToList();
            }
        }

        public static AIPromptModule GetModule(string moduleId)
        {
            lock (_lock)
            {
                var mod = _modules.FirstOrDefault(m => string.Equals(m.ModuleId, moduleId, StringComparison.OrdinalIgnoreCase));
                return mod != null ? Clone(mod) : Clone(_modules[0]);
            }
        }

        public static bool UpdateModule(AIPromptModule updated)
        {
            lock (_lock)
            {
                var existing = _modules.FirstOrDefault(m => string.Equals(m.ModuleId, updated.ModuleId, StringComparison.OrdinalIgnoreCase));
                if (existing != null)
                {
                    existing.SystemPromptText = updated.SystemPromptText;
                    existing.ModelEngine = updated.ModelEngine;
                    existing.Temperature = updated.Temperature;
                    existing.MaxTokens = updated.MaxTokens;
                    existing.StrictJsonEnforcement = updated.StrictJsonEnforcement;
                    existing.EstimatedTokens = Math.Max(100, updated.SystemPromptText.Length / 4);
                    existing.LastUpdated = DateTime.Now;
                    existing.UpdatedBy = "Faculty Coordinator (CSE)";
                    existing.VersionTag = "v2." + (DateTime.Now.Day) + "." + (DateTime.Now.Hour);
                    return true;
                }
                return false;
            }
        }

        public static void ResetToDefaults()
        {
            lock (_lock)
            {
                _modules = new List<AIPromptModule>
                {
                    new AIPromptModule
                    {
                        ModuleId = "PROMPT-RESUME",
                        ModuleName = "Resume Analysis Parser",
                        ShortDescription = "Extracts education, CGPA, projects, and calculates ATS formatting scores using STAR criteria.",
                        SystemPromptText = "You are an expert technical recruiter and ATS parsing engine. Extract all candidate education degrees, GPA, verified hard skills, and project accomplishments. Benchmark against the selected target role and compute keyword density, formatting score, and actionable rewrite recommendations using the STAR formula.",
                        ModelEngine = "gpt-4-turbo",
                        Temperature = 0.2m,
                        MaxTokens = 2048,
                        StrictJsonEnforcement = true,
                        EstimatedTokens = 420,
                        VersionTag = "v2.4.1",
                        LastUpdated = DateTime.Now.AddDays(-2),
                        UpdatedBy = "Prof. R. Sharma",
                        SampleInputPayload = "{\n  \"candidateName\": \"Aarav Sharma\",\n  \"targetRole\": \"Software Development Engineer I (Full Stack)\",\n  \"resumeExcerpt\": \"B.Tech CSE, CGPA 9.2. Implemented distributed cache with Redis and ASP.NET Core reducing query latency by 45%.\"\n}"
                    },
                    new AIPromptModule
                    {
                        ModuleId = "PROMPT-MOCK",
                        ModuleName = "Mock Interview Evaluator",
                        ShortDescription = "Conducts dynamic technical interviews and scores candidate answers on clarity and architecture.",
                        SystemPromptText = "You are a Senior Principal Engineer conducting technical and behavioral interviews. Ask clarifying questions, challenge assumptions, and score candidates on Clarity, Technical Accuracy, System Architecture, and STAR behavioral alignment. Return structured rubric JSON with timestamped remediation advice.",
                        ModelEngine = "gpt-4-turbo",
                        Temperature = 0.5m,
                        MaxTokens = 4096,
                        StrictJsonEnforcement = true,
                        EstimatedTokens = 680,
                        VersionTag = "v2.3.8",
                        LastUpdated = DateTime.Now.AddHours(-18),
                        UpdatedBy = "Prof. R. Sharma",
                        SampleInputPayload = "{\n  \"topic\": \"System Design - Distributed Rate Limiter\",\n  \"candidateAnswer\": \"I would use a token bucket algorithm stored in Redis with atomic Lua scripts to prevent race conditions across server nodes.\"\n}"
                    },
                    new AIPromptModule
                    {
                        ModuleId = "PROMPT-GAP",
                        ModuleName = "Skill Gap Analysis Model",
                        ShortDescription = "Analyzes assessment results against company hiring tracks and generates 30-day remediation plans.",
                        SystemPromptText = "Analyze candidate assessment scores and resume skills against required industry competencies. Identify critical, moderate, and low-priority gaps. Formulate a step-by-step 30-day curriculum with targeted module recommendations to close the identified deficit.",
                        ModelEngine = "gpt-4-turbo",
                        Temperature = 0.3m,
                        MaxTokens = 2048,
                        StrictJsonEnforcement = true,
                        EstimatedTokens = 385,
                        VersionTag = "v2.1.0",
                        LastUpdated = DateTime.Now.AddDays(-4),
                        UpdatedBy = "Prof. R. Sharma",
                        SampleInputPayload = "{\n  \"studentId\": \"24SOECE1101\",\n  \"dsaScore\": 88,\n  \"systemDesignScore\": 62,\n  \"coreJavaScore\": 90,\n  \"companyTarget\": \"Amazon SDE-1\"\n}"
                    },
                    new AIPromptModule
                    {
                        ModuleId = "PROMPT-QUESTIONS",
                        ModuleName = "Dynamic Question Generator",
                        ShortDescription = "Generates targeted aptitude, coding, and system design test items with automated unit tests.",
                        SystemPromptText = "You are an automated assessment creator for university campus drives. Generate high-quality multiple choice and coding evaluation questions based on the selected domain, difficulty level, and company benchmark. Provide correct answers, distractors, and execution test cases.",
                        ModelEngine = "gpt-4-turbo",
                        Temperature = 0.6m,
                        MaxTokens = 3072,
                        StrictJsonEnforcement = true,
                        EstimatedTokens = 512,
                        VersionTag = "v2.5.0",
                        LastUpdated = DateTime.Now.AddHours(-6),
                        UpdatedBy = "Prof. R. Sharma",
                        SampleInputPayload = "{\n  \"domain\": \"Data Structures & Algorithms\",\n  \"topic\": \"Dynamic Programming on Trees\",\n  \"difficulty\": \"Medium-Hard\",\n  \"numQuestions\": 3\n}"
                    }
                };
            }
        }

        private static AIPromptModule Clone(AIPromptModule source)
        {
            return new AIPromptModule
            {
                ModuleId = source.ModuleId,
                ModuleName = source.ModuleName,
                ShortDescription = source.ShortDescription,
                SystemPromptText = source.SystemPromptText,
                ModelEngine = source.ModelEngine,
                Temperature = source.Temperature,
                MaxTokens = source.MaxTokens,
                StrictJsonEnforcement = source.StrictJsonEnforcement,
                EstimatedTokens = source.EstimatedTokens,
                VersionTag = source.VersionTag,
                LastUpdated = source.LastUpdated,
                UpdatedBy = source.UpdatedBy,
                SampleInputPayload = source.SampleInputPayload
            };
        }
    }
}

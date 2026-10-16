-- ==============================================================================
-- PlacementPrep Database Schema & Seed Script (Option 1: Git-Versioned Schema)
-- Project: Placement Prep (.NET / C# Web Forms & MVC)
-- Target Engine: Microsoft SQL Server (LocalDB / SQL Server Express / Full SQL Server)
-- ==============================================================================

-- 1. Create Database if it does not already exist
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'PlacementPrepDB')
BEGIN
    CREATE DATABASE PlacementPrepDB;
END
GO

USE PlacementPrepDB;
GO

-- ==============================================================================
-- 2. DDL: Create Tables (With Idempotent IF NOT EXISTS checks)
-- ==============================================================================

-- Table: Users (Authentication & RBAC)
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Users] (
        [UserId] INT IDENTITY(1,1) PRIMARY KEY,
        [FullName] NVARCHAR(150) NOT NULL,
        [Email] NVARCHAR(150) NOT NULL UNIQUE,
        [PasswordHash] NVARCHAR(256) NOT NULL,
        [UserRole] NVARCHAR(50) NOT NULL DEFAULT 'Student', -- 'Student', 'Faculty', 'Admin'
        [Department] NVARCHAR(100) NULL,
        [IsOnboardingCompleted] BIT NOT NULL DEFAULT 0,
        [ProfilePictureUrl] NVARCHAR(500) NULL,
        [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE()
    );
END
GO

-- Table: Students (Academic Profiles & Placement Metrics)
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Students]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Students] (
        [RollNo] NVARCHAR(50) PRIMARY KEY,
        [UserId] INT NULL FOREIGN KEY REFERENCES [dbo].[Users]([UserId]),
        [Name] NVARCHAR(150) NOT NULL,
        [Department] NVARCHAR(100) NOT NULL,
        [ClassYear] NVARCHAR(50) NOT NULL,
        [CGPA] DECIMAL(4,2) NOT NULL DEFAULT 0.00,
        [AvgScore] DECIMAL(5,2) NOT NULL DEFAULT 0.00,
        [TestsCompleted] INT NOT NULL DEFAULT 0,
        [Status] NVARCHAR(50) NOT NULL DEFAULT 'On Track', -- 'Strong Fit', 'On Track', 'Needs Review'
        [Trend] NVARCHAR(20) NOT NULL DEFAULT '+0%',
        [Email] NVARCHAR(150) NOT NULL,
        [ReadinessIndex] DECIMAL(5,2) NOT NULL DEFAULT 0.00,
        [BatchRank] INT NOT NULL DEFAULT 0,
        [TotalSolved] INT NOT NULL DEFAULT 0,
        [Skills] NVARCHAR(MAX) NULL, -- Comma-separated or JSON string
        [GraduationYear] INT NOT NULL DEFAULT 2026,
        [ActiveBacklogs] INT NOT NULL DEFAULT 0,
        [AttendancePercentage] DECIMAL(5,2) NOT NULL DEFAULT 100.00,
        [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE()
    );
END
GO

-- Table: CurriculumSubjects (Curriculum & Syllabus Management)
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CurriculumSubjects]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[CurriculumSubjects] (
        [SubjectCode] NVARCHAR(50) PRIMARY KEY,
        [SubjectName] NVARCHAR(150) NOT NULL,
        [Department] NVARCHAR(100) NOT NULL,
        [Semester] INT NOT NULL,
        [TopicsCount] INT NOT NULL DEFAULT 0,
        [ReadinessRate] DECIMAL(5,2) NOT NULL DEFAULT 0.00,
        [AIRelevance] DECIMAL(5,2) NOT NULL DEFAULT 0.00,
        [IsActive] BIT NOT NULL DEFAULT 1
    );
END
GO

-- Table: CurriculumTopics (Sub-topics and weightage under subjects)
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CurriculumTopics]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[CurriculumTopics] (
        [TopicId] INT IDENTITY(1,1) PRIMARY KEY,
        [SubjectCode] NVARCHAR(50) NOT NULL FOREIGN KEY REFERENCES [dbo].[CurriculumSubjects]([SubjectCode]) ON DELETE CASCADE,
        [TopicName] NVARCHAR(150) NOT NULL,
        [WeightagePercentage] DECIMAL(5,2) NOT NULL DEFAULT 0.00
    );
END
GO

-- Table: Companies (Recruiter & Corporate Directory)
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Companies]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Companies] (
        [CompanyId] INT IDENTITY(1,1) PRIMARY KEY,
        [CompanyName] NVARCHAR(150) NOT NULL UNIQUE,
        [Industry] NVARCHAR(100) NOT NULL,
        [Role] NVARCHAR(150) NOT NULL,
        [TierClassification] NVARCHAR(50) NOT NULL DEFAULT 'Tier 2', -- 'Tier 1', 'Tier 2', 'Tier 3'
        [MinCgpa] DECIMAL(4,2) NOT NULL DEFAULT 6.00,
        [PackageLPA] DECIMAL(6,2) NOT NULL DEFAULT 0.00,
        [DriveDate] NVARCHAR(50) NOT NULL,
        [RecruiterContactName] NVARCHAR(150) NULL,
        [RecruiterEmail] NVARCHAR(150) NULL,
        [MouStatus] NVARCHAR(50) NOT NULL DEFAULT 'Active',
        [Status] NVARCHAR(50) NOT NULL DEFAULT 'Upcoming', -- 'Upcoming', 'Active', 'Completed'
        [EligibleCount] INT NOT NULL DEFAULT 0
    );
END
GO

-- Table: PlacementDrives (Scheduled Campus Placement Drives)
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PlacementDrives]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[PlacementDrives] (
        [DriveId] NVARCHAR(50) PRIMARY KEY,
        [CompanyId] INT NULL FOREIGN KEY REFERENCES [dbo].[Companies]([CompanyId]),
        [CompanyName] NVARCHAR(150) NOT NULL,
        [JobTitle] NVARCHAR(150) NOT NULL,
        [EventDate] NVARCHAR(50) NOT NULL,
        [TimeWindow] NVARCHAR(100) NOT NULL,
        [Location] NVARCHAR(200) NOT NULL,
        [Status] NVARCHAR(50) NOT NULL DEFAULT 'Scheduled', -- 'Scheduled', 'In Progress', 'Completed'
        [RegisteredStudents] INT NOT NULL DEFAULT 0,
        [MinCtcOffered] DECIMAL(6,2) NOT NULL DEFAULT 0.00,
        [MaxCtcOffered] DECIMAL(6,2) NOT NULL DEFAULT 0.00,
        [EligibilityMinCgpa] DECIMAL(4,2) NOT NULL DEFAULT 6.50,
        [MaxAllowedBacklogs] INT NOT NULL DEFAULT 0,
        [AssessmentCutoffScore] DECIMAL(5,2) NOT NULL DEFAULT 60.00
    );
END
GO

-- Table: AIPromptModules (AI Prompt Configurations)
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AIPromptModules]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[AIPromptModules] (
        [ModuleId] NVARCHAR(50) PRIMARY KEY,
        [ModuleName] NVARCHAR(150) NOT NULL,
        [ShortDescription] NVARCHAR(500) NULL,
        [SystemPromptText] NVARCHAR(MAX) NOT NULL,
        [ModelEngine] NVARCHAR(100) NOT NULL DEFAULT 'gpt-4o',
        [Temperature] DECIMAL(3,2) NOT NULL DEFAULT 0.70,
        [MaxTokens] INT NOT NULL DEFAULT 2048,
        [StrictJsonEnforcement] BIT NOT NULL DEFAULT 1,
        [EstimatedTokens] INT NOT NULL DEFAULT 0,
        [VersionTag] NVARCHAR(50) NOT NULL DEFAULT 'v2.1',
        [LastUpdated] DATETIME NOT NULL DEFAULT GETDATE(),
        [UpdatedBy] NVARCHAR(150) NOT NULL DEFAULT 'System Admin',
        [SampleInputPayload] NVARCHAR(MAX) NULL
    );
END
GO

-- Table: Assessments (Exam & Test Scheduling)
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Assessments]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Assessments] (
        [AssessmentId] INT IDENTITY(1,1) PRIMARY KEY,
        [Title] NVARCHAR(200) NOT NULL,
        [SystemCode] NVARCHAR(50) NOT NULL UNIQUE,
        [TrackType] NVARCHAR(50) NOT NULL, -- 'Aptitude', 'Technical', 'Combined'
        [TargetDepartment] NVARCHAR(100) NOT NULL,
        [TargetBatch] NVARCHAR(50) NOT NULL,
        [WindowStart] DATETIME NOT NULL,
        [WindowEnd] DATETIME NOT NULL,
        [DurationMinutes] INT NOT NULL DEFAULT 60,
        [PassingScore] DECIMAL(5,2) NOT NULL DEFAULT 50.00,
        [EnableNegativeMarking] BIT NOT NULL DEFAULT 0,
        [EnableFullscreenLockdown] BIT NOT NULL DEFAULT 1,
        [EnableWebcamMonitor] BIT NOT NULL DEFAULT 0,
        [LinkedPlacementDriveId] NVARCHAR(50) NULL FOREIGN KEY REFERENCES [dbo].[PlacementDrives]([DriveId]),
        [Status] NVARCHAR(50) NOT NULL DEFAULT 'Scheduled' -- 'Draft', 'Scheduled', 'Live', 'Closed'
    );
END
GO

-- Table: Questions (Central Question Bank)
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Questions]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Questions] (
        [QuestionId] INT IDENTITY(1,1) PRIMARY KEY,
        [QuestionBankType] NVARCHAR(50) NOT NULL, -- 'Aptitude', 'Technical', 'Coding'
        [Category] NVARCHAR(100) NOT NULL,
        [Topic] NVARCHAR(100) NOT NULL,
        [Difficulty] NVARCHAR(20) NOT NULL DEFAULT 'Medium', -- 'Easy', 'Medium', 'Hard'
        [QuestionText] NVARCHAR(MAX) NOT NULL,
        [OptionsJson] NVARCHAR(MAX) NULL,
        [CorrectAnswer] NVARCHAR(500) NOT NULL,
        [Explanation] NVARCHAR(MAX) NULL,
        [CodingTestCasesJson] NVARCHAR(MAX) NULL,
        [DefaultMarks] DECIMAL(4,2) NOT NULL DEFAULT 1.00,
        [NegativeMarks] DECIMAL(4,2) NOT NULL DEFAULT 0.00,
        [IsVerified] BIT NOT NULL DEFAULT 1
    );
END
GO

-- Table: SystemLogs (Audit Trail & Activity Log)
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SystemLogs]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[SystemLogs] (
        [EventId] NVARCHAR(50) PRIMARY KEY,
        [Timestamp] DATETIME NOT NULL DEFAULT GETDATE(),
        [Actor] NVARCHAR(150) NOT NULL,
        [Module] NVARCHAR(100) NOT NULL,
        [EventName] NVARCHAR(150) NOT NULL,
        [Severity] NVARCHAR(20) NOT NULL DEFAULT 'Info', -- 'Info', 'Warning', 'Critical'
        [ActionSynopsis] NVARCHAR(MAX) NOT NULL
    );
END
GO

-- ==============================================================================
-- 3. DML: Seed Baseline Data (Matching Current Faculty & AI DataStores)
-- ==============================================================================

-- Seed Users
IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [Email] = 'admin@placementprep.edu')
BEGIN
    INSERT INTO [dbo].[Users] ([FullName], [Email], [PasswordHash], [UserRole], [Department], [IsOnboardingCompleted])
    VALUES 
    ('Head of Placement', 'admin@placementprep.edu', 'AQAAAAEAACcQAAAAEP1...', 'Admin', 'Training & Placement', 1),
    ('Dr. Ramesh Sharma', 'faculty@placementprep.edu', 'AQAAAAEAACcQAAAAEP2...', 'Faculty', 'Computer Science', 1),
    ('Aarav Sharma', 'aarav.sharma@darshan.ac.in', 'AQAAAAEAACcQAAAAEP3...', 'Student', 'Computer Science', 1);
END
GO

-- Seed Students
IF NOT EXISTS (SELECT 1 FROM [dbo].[Students] WHERE [RollNo] = '22SOECE11001')
BEGIN
    INSERT INTO [dbo].[Students] ([RollNo], [Name], [Department], [ClassYear], [CGPA], [AvgScore], [TestsCompleted], [Status], [Trend], [Email], [ReadinessIndex], [BatchRank], [TotalSolved], [Skills], [GraduationYear], [ActiveBacklogs], [AttendancePercentage])
    VALUES
    ('22SOECE11001', 'Aarav Sharma', 'Computer Science', 'Final Year (2025)', 8.85, 87.50, 14, 'Strong Fit', '+4.2%', 'aarav.sharma@darshan.ac.in', 92.40, 1, 142, 'C#, .NET, SQL Server, Python, DSA', 2025, 0, 95.00),
    ('22SOECE11014', 'Priya Patel', 'Computer Science', 'Final Year (2025)', 8.20, 79.00, 11, 'On Track', '+1.8%', 'priya.patel@darshan.ac.in', 81.50, 4, 98, 'Java, SQL, Spring Boot, React', 2025, 0, 91.50),
    ('22SOECE11032', 'Rohan Mehta', 'Information Tech', 'Final Year (2025)', 7.60, 68.40, 8, 'Needs Review', '-2.1%', 'rohan.mehta@darshan.ac.in', 65.00, 12, 64, 'JavaScript, HTML/CSS, Python Basics', 2025, 1, 82.00),
    ('22SOECE11045', 'Ananya Iyer', 'Computer Science', 'Final Year (2025)', 9.15, 93.20, 16, 'Strong Fit', '+5.0%', 'ananya.iyer@darshan.ac.in', 96.00, 2, 178, 'C++, Algorithms, Machine Learning, SQL', 2025, 0, 98.00),
    ('22SOECE11058', 'Kavya Nair', 'Electronics & Comm', 'Final Year (2025)', 7.40, 71.00, 9, 'On Track', '+0.5%', 'kavya.nair@darshan.ac.in', 72.30, 8, 76, 'Embedded C, IoT, Python, SQL', 2025, 0, 88.00),
    ('22SOECE11072', 'Devendra Solanki', 'Computer Science', 'Pre-Final (2026)', 6.95, 59.80, 5, 'Needs Review', '-3.4%', 'devendra.s@darshan.ac.in', 58.20, 19, 42, 'C, Java, SQL Basics', 2026, 2, 79.50);
END
GO

-- Seed CurriculumSubjects
IF NOT EXISTS (SELECT 1 FROM [dbo].[CurriculumSubjects] WHERE [SubjectCode] = 'CS501')
BEGIN
    INSERT INTO [dbo].[CurriculumSubjects] ([SubjectCode], [SubjectName], [Department], [Semester], [TopicsCount], [ReadinessRate], [AIRelevance], [IsActive])
    VALUES
    ('CS501', 'Data Structures & Algorithms', 'Computer Science', 5, 8, 84.50, 95.00, 1),
    ('CS502', 'Database Management Systems', 'Computer Science', 5, 6, 78.20, 90.00, 1),
    ('CS503', 'Object-Oriented Programming (C# / Java)', 'Computer Science', 5, 7, 88.00, 85.00, 1),
    ('CS504', 'Computer Networks', 'Computer Science', 5, 5, 71.40, 75.00, 1),
    ('IT501', 'Web Application Development (.NET)', 'Information Tech', 5, 7, 82.00, 92.00, 1),
    ('EC501', 'Microcontrollers & Embedded Systems', 'Electronics & Comm', 5, 6, 69.50, 80.00, 1);
END
GO

-- Seed CurriculumTopics
IF NOT EXISTS (SELECT 1 FROM [dbo].[CurriculumTopics] WHERE [SubjectCode] = 'CS501')
BEGIN
    INSERT INTO [dbo].[CurriculumTopics] ([SubjectCode], [TopicName], [WeightagePercentage])
    VALUES
    ('CS501', 'Arrays, Strings & Pointers', 15.00),
    ('CS501', 'Linked Lists & Stacks/Queues', 15.00),
    ('CS501', 'Binary Trees & BSTs', 20.00),
    ('CS501', 'Graphs & Traversal Algorithms', 20.00),
    ('CS501', 'Dynamic Programming', 20.00),
    ('CS501', 'Sorting & Searching Complexity', 10.00);
END
GO

-- Seed Companies
IF NOT EXISTS (SELECT 1 FROM [dbo].[Companies] WHERE [CompanyName] = 'TCS Digital')
BEGIN
    INSERT INTO [dbo].[Companies] ([CompanyName], [Industry], [Role], [TierClassification], [MinCgpa], [PackageLPA], [DriveDate], [RecruiterContactName], [RecruiterEmail], [MouStatus], [Status], [EligibleCount])
    VALUES
    ('TCS Digital', 'IT Services', 'Systems Engineer (Digital)', 'Tier 2', 7.00, 7.50, '2026-11-10', 'Neha Kapoor', 'neha.k@tcs.com', 'Active', 'Upcoming', 48),
    ('Infosys SP', 'IT Services', 'Specialist Programmer', 'Tier 2', 7.50, 9.50, '2026-11-18', 'Vivek Menon', 'v.menon@infosys.com', 'Active', 'Upcoming', 32),
    ('Amazon WOW / SDE', 'Product / E-Commerce', 'Software Dev Engineer (SDE-1)', 'Tier 1', 8.50, 24.00, '2026-12-05', 'Sarah Jenkins', 'sjenkins@amazon.com', 'Active', 'Upcoming', 12),
    ('Reliance Jio', 'Telecom / Tech', 'Graduate Engineer Trainee', 'Tier 2', 6.50, 6.00, '2026-10-28', 'Anand Kulkarni', 'anand.k@ril.com', 'Active', 'Active', 65),
    ('Crest Data Systems', 'Product / Cybersecurity', 'Software Engineer (C# / Cloud)', 'Tier 2', 7.20, 8.00, '2026-10-22', 'Pooja Bhatt', 'pooja@crestdata.com', 'Active', 'Active', 41);
END
GO

-- Seed PlacementDrives
IF NOT EXISTS (SELECT 1 FROM [dbo].[PlacementDrives] WHERE [DriveId] = 'DRV-2026-001')
BEGIN
    INSERT INTO [dbo].[PlacementDrives] ([DriveId], [CompanyName], [JobTitle], [EventDate], [TimeWindow], [Location], [Status], [RegisteredStudents], [MinCtcOffered], [MaxCtcOffered], [EligibilityMinCgpa], [MaxAllowedBacklogs], [AssessmentCutoffScore])
    VALUES
    ('DRV-2026-001', 'Crest Data Systems', 'Software Engineer (Cloud & C#)', '22 Oct 2026', '09:00 AM - 05:00 PM', 'Audi-1 / Lab-4', 'Scheduled', 41, 6.00, 8.00, 7.20, 0, 65.00),
    ('DRV-2026-002', 'Reliance Jio', 'Graduate Engineer Trainee', '28 Oct 2026', '10:00 AM - 06:00 PM', 'Central Lab 2', 'Scheduled', 65, 5.50, 6.00, 6.50, 1, 60.00),
    ('DRV-2026-003', 'TCS Digital', 'Systems Engineer (Digital)', '10 Nov 2026', '09:30 AM - 04:30 PM', 'Campus Placement Hall', 'Scheduled', 48, 7.00, 7.50, 7.00, 0, 70.00),
    ('DRV-2026-004', 'Infosys SP', 'Specialist Programmer', '18 Nov 2026', '10:00 AM - 05:00 PM', 'Computer Center', 'Scheduled', 32, 8.00, 9.50, 7.50, 0, 75.00);
END
GO

-- Seed AIPromptModules
IF NOT EXISTS (SELECT 1 FROM [dbo].[AIPromptModules] WHERE [ModuleId] = 'MOD_RESUME_PARSER')
BEGIN
    INSERT INTO [dbo].[AIPromptModules] ([ModuleId], [ModuleName], [ShortDescription], [SystemPromptText], [ModelEngine], [Temperature], [MaxTokens], [StrictJsonEnforcement], [EstimatedTokens], [VersionTag], [LastUpdated], [UpdatedBy], [SampleInputPayload])
    VALUES
    ('MOD_RESUME_PARSER', 'Resume ATS Intelligence Parser', 'Parses uploaded PDF/DOCX resumes, extracts key skills, projects, and calculates ATS compatibility score against target roles.', 
     N'You are an expert Technical Recruiter and ATS evaluation engine. Given the candidate resume text, extract technical skills, calculate an ATS match score (0-100), identify missing keywords, and suggest targeted improvements in valid JSON format.',
     'gpt-4o', 0.20, 2048, 1, 1450, 'v2.4', GETDATE(), 'Dr. Ramesh Sharma', N'{"raw_resume_text": "Experienced C# and SQL developer...", "target_role": "Full Stack .NET Developer"}'),

    ('MOD_MOCK_INTERVIEW', 'AI Technical Interviewer Engine', 'Conducts adaptive multi-turn technical interviews, analyzes answers using STAR method, and rates clarity and technical depth.',
     N'You are a Senior Principal Engineer at a Tier-1 tech company conducting a technical interview. Ask deep follow-up questions, evaluate answers for accuracy and clarity, and provide constructive feedback in structured JSON format.',
     'gpt-4o', 0.70, 3072, 1, 2200, 'v3.1', GETDATE(), 'Placement Cell Admin', N'{"interview_track": "Backend C#", "student_response": "I used Entity Framework with indexing..."}'),

    ('MOD_QUESTION_GEN', 'Curriculum Adaptive Question Generator', 'Generates high-yield multiple choice and coding challenge questions calibrated to specific curriculum topics and difficulty tiers.',
     N'Generate high-quality multiple choice and coding questions adhering to Bloom''s taxonomy for the specified syllabus topic. Output strictly formatted JSON with options, correct answer index, and step-by-step rationale.',
     'gpt-4o-mini', 0.50, 2048, 1, 1200, 'v1.9', GETDATE(), 'Dr. Ramesh Sharma', N'{"subject": "DBMS", "topic": "B+ Trees and Indexing", "difficulty": "Medium", "count": 5}');
END
GO

-- Seed SystemLogs
IF NOT EXISTS (SELECT 1 FROM [dbo].[SystemLogs] WHERE [EventId] = 'EVT-1001')
BEGIN
    INSERT INTO [dbo].[SystemLogs] ([EventId], [Timestamp], [Actor], [Module], [EventName], [Severity], [ActionSynopsis])
    VALUES
    ('EVT-1001', DATEADD(MINUTE, -120, GETDATE()), 'System (Scheduler)', 'Placement Drives', 'Candidate Shortlist Triggered', 'Info', 'Auto-evaluated 65 students for Crest Data Systems drive. 41 students met CGPA and test criteria.'),
    ('EVT-1002', DATEADD(MINUTE, -75, GETDATE()), 'Dr. Ramesh Sharma', 'Curriculum', 'Syllabus Weightage Updated', 'Info', 'Updated topic weightages for CS501 Data Structures to reach 100% allocation.'),
    ('EVT-1003', DATEADD(MINUTE, -30, GETDATE()), 'Placement Cell Admin', 'AI Config', 'Prompt Model Changed', 'Warning', 'Updated MOD_MOCK_INTERVIEW engine parameter to gpt-4o with temperature 0.70.'),
    ('EVT-1004', DATEADD(MINUTE, -10, GETDATE()), 'Aarav Sharma (Student)', 'Assessments', 'Assessment Completed', 'Info', 'Completed CS501 Practice Assessment #4 with score 88.00%.');
END
GO

PRINT 'PlacementPrepDB schema and baseline seed records executed successfully!';
GO

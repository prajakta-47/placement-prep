/*
 Placement Prep - SQL Server schema starter
 Target: Microsoft SQL Server / ASP.NET Web Forms / C#
 This is a proposed schema derived from the project requirements. Review before deployment.
 Run against a new, empty database. Do not run blindly on a production database.
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;
GO

/* 1. Identity, roles, authentication and audit */
CREATE TABLE dbo.Users (
    UserId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Users PRIMARY KEY,
    FullName NVARCHAR(150) NOT NULL,
    Email NVARCHAR(320) NOT NULL,
    NormalizedEmail NVARCHAR(320) NOT NULL,
    PasswordHash NVARCHAR(500) NULL,
    PhoneNumber NVARCHAR(20) NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_Users_IsActive DEFAULT (1),
    EmailVerifiedAt DATETIME2(0) NULL,
    FailedLoginCount INT NOT NULL CONSTRAINT DF_Users_FailedLoginCount DEFAULT (0),
    LockoutUntil DATETIME2(0) NULL,
    CreatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_Users_CreatedAt DEFAULT SYSUTCDATETIME(),
    UpdatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_Users_UpdatedAt DEFAULT SYSUTCDATETIME(),
    LastLoginAt DATETIME2(0) NULL,
    CONSTRAINT UQ_Users_NormalizedEmail UNIQUE (NormalizedEmail),
    CONSTRAINT CK_Users_FailedLoginCount CHECK (FailedLoginCount >= 0)
);
GO
CREATE TABLE dbo.Roles (
    RoleId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Roles PRIMARY KEY,
    RoleName NVARCHAR(50) NOT NULL,
    Description NVARCHAR(250) NULL,
    CONSTRAINT UQ_Roles_RoleName UNIQUE (RoleName)
);
GO
CREATE TABLE dbo.UserRoles (
    UserId BIGINT NOT NULL,
    RoleId INT NOT NULL,
    AssignedAt DATETIME2(0) NOT NULL CONSTRAINT DF_UserRoles_AssignedAt DEFAULT SYSUTCDATETIME(),
    AssignedByUserId BIGINT NULL,
    CONSTRAINT PK_UserRoles PRIMARY KEY (UserId, RoleId),
    CONSTRAINT FK_UserRoles_Users FOREIGN KEY (UserId) REFERENCES dbo.Users(UserId),
    CONSTRAINT FK_UserRoles_Roles FOREIGN KEY (RoleId) REFERENCES dbo.Roles(RoleId),
    CONSTRAINT FK_UserRoles_AssignedBy FOREIGN KEY (AssignedByUserId) REFERENCES dbo.Users(UserId)
);
GO
CREATE TABLE dbo.ExternalLogins (
    ExternalLoginId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_ExternalLogins PRIMARY KEY,
    UserId BIGINT NOT NULL,
    Provider NVARCHAR(50) NOT NULL,
    ProviderUserKey NVARCHAR(300) NOT NULL,
    CreatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_ExternalLogins_CreatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_ExternalLogins_Users FOREIGN KEY (UserId) REFERENCES dbo.Users(UserId),
    CONSTRAINT UQ_ExternalLogins_Provider_Key UNIQUE (Provider, ProviderUserKey)
);
GO
CREATE TABLE dbo.EmailVerificationCodes (
    VerificationId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_EmailVerificationCodes PRIMARY KEY,
    UserId BIGINT NOT NULL,
    CodeHash NVARCHAR(500) NOT NULL,
    ExpiresAt DATETIME2(0) NOT NULL,
    UsedAt DATETIME2(0) NULL,
    AttemptCount INT NOT NULL CONSTRAINT DF_EmailVerificationCodes_AttemptCount DEFAULT (0),
    CreatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_EmailVerificationCodes_CreatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_EmailVerificationCodes_Users FOREIGN KEY (UserId) REFERENCES dbo.Users(UserId),
    CONSTRAINT CK_EmailVerificationCodes_AttemptCount CHECK (AttemptCount >= 0)
);
GO
CREATE TABLE dbo.PasswordResetTokens (
    ResetTokenId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_PasswordResetTokens PRIMARY KEY,
    UserId BIGINT NOT NULL,
    TokenHash NVARCHAR(500) NOT NULL,
    ExpiresAt DATETIME2(0) NOT NULL,
    UsedAt DATETIME2(0) NULL,
    CreatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_PasswordResetTokens_CreatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_PasswordResetTokens_Users FOREIGN KEY (UserId) REFERENCES dbo.Users(UserId),
    CONSTRAINT UQ_PasswordResetTokens_TokenHash UNIQUE (TokenHash)
);
GO
CREATE TABLE dbo.UserSettings (
    UserId BIGINT NOT NULL CONSTRAINT PK_UserSettings PRIMARY KEY,
    EmailNotificationsEnabled BIT NOT NULL CONSTRAINT DF_UserSettings_EmailNotifications DEFAULT (1),
    Theme NVARCHAR(20) NOT NULL CONSTRAINT DF_UserSettings_Theme DEFAULT ('System'),
    UpdatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_UserSettings_UpdatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_UserSettings_Users FOREIGN KEY (UserId) REFERENCES dbo.Users(UserId),
    CONSTRAINT CK_UserSettings_Theme CHECK (Theme IN ('System','Light','Dark'))
);
GO
CREATE TABLE dbo.AuditLogs (
    AuditLogId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_AuditLogs PRIMARY KEY,
    ActorUserId BIGINT NULL,
    Action NVARCHAR(100) NOT NULL,
    EntityType NVARCHAR(100) NULL,
    EntityId NVARCHAR(100) NULL,
    Details NVARCHAR(MAX) NULL,
    IpAddress NVARCHAR(45) NULL,
    CreatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_AuditLogs_CreatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_AuditLogs_ActorUser FOREIGN KEY (ActorUserId) REFERENCES dbo.Users(UserId)
);
GO

/* 2. Academic structure */
CREATE TABLE dbo.Departments (
    DepartmentId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Departments PRIMARY KEY,
    DepartmentCode NVARCHAR(30) NOT NULL,
    DepartmentName NVARCHAR(150) NOT NULL,
    Description NVARCHAR(500) NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_Departments_IsActive DEFAULT (1),
    CreatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_Departments_CreatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT UQ_Departments_Code UNIQUE (DepartmentCode),
    CONSTRAINT UQ_Departments_Name UNIQUE (DepartmentName)
);
GO
CREATE TABLE dbo.Programs (
    ProgramId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Programs PRIMARY KEY,
    DepartmentId BIGINT NOT NULL,
    ProgramCode NVARCHAR(30) NOT NULL,
    ProgramName NVARCHAR(150) NOT NULL,
    DegreeLevel NVARCHAR(50) NULL,
    DurationYears TINYINT NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_Programs_IsActive DEFAULT (1),
    CONSTRAINT FK_Programs_Departments FOREIGN KEY (DepartmentId) REFERENCES dbo.Departments(DepartmentId),
    CONSTRAINT UQ_Programs_Code UNIQUE (ProgramCode),
    CONSTRAINT CK_Programs_Duration CHECK (DurationYears IS NULL OR DurationYears BETWEEN 1 AND 12)
);
GO
CREATE TABLE dbo.AcademicYears (
    AcademicYearId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_AcademicYears PRIMARY KEY,
    YearLabel NVARCHAR(20) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_AcademicYears_IsActive DEFAULT (0),
    CreatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_AcademicYears_CreatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT UQ_AcademicYears_YearLabel UNIQUE (YearLabel),
    CONSTRAINT CK_AcademicYears_Dates CHECK (EndDate > StartDate)
);
GO
CREATE UNIQUE INDEX UX_AcademicYears_OneActive ON dbo.AcademicYears(IsActive) WHERE IsActive = 1;
GO
CREATE TABLE dbo.Cohorts (
    CohortId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Cohorts PRIMARY KEY,
    CohortCode NVARCHAR(40) NOT NULL,
    CohortName NVARCHAR(150) NOT NULL,
    ProgramId BIGINT NOT NULL,
    AcademicYearId BIGINT NOT NULL,
    AdmissionYear SMALLINT NULL,
    GraduationYear SMALLINT NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_Cohorts_IsActive DEFAULT (1),
    CreatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_Cohorts_CreatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT UQ_Cohorts_Code UNIQUE (CohortCode),
    CONSTRAINT FK_Cohorts_Programs FOREIGN KEY (ProgramId) REFERENCES dbo.Programs(ProgramId),
    CONSTRAINT FK_Cohorts_AcademicYears FOREIGN KEY (AcademicYearId) REFERENCES dbo.AcademicYears(AcademicYearId),
    CONSTRAINT CK_Cohorts_Years CHECK (AdmissionYear IS NULL OR GraduationYear IS NULL OR GraduationYear >= AdmissionYear)
);
GO
CREATE TABLE dbo.StudentProfiles (
    StudentProfileId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_StudentProfiles PRIMARY KEY,
    UserId BIGINT NOT NULL,
    ProgramId BIGINT NOT NULL,
    CohortId BIGINT NULL,
    EnrollmentNumber NVARCHAR(50) NULL,
    ExpectedGraduationYear SMALLINT NULL,
    CurrentCGPA DECIMAL(4,2) NULL,
    CurrentSemester TINYINT NULL,
    CreatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_StudentProfiles_CreatedAt DEFAULT SYSUTCDATETIME(),
    UpdatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_StudentProfiles_UpdatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT UQ_StudentProfiles_User UNIQUE (UserId),
    CONSTRAINT FK_StudentProfiles_Users FOREIGN KEY (UserId) REFERENCES dbo.Users(UserId),
    CONSTRAINT FK_StudentProfiles_Programs FOREIGN KEY (ProgramId) REFERENCES dbo.Programs(ProgramId),
    CONSTRAINT FK_StudentProfiles_Cohorts FOREIGN KEY (CohortId) REFERENCES dbo.Cohorts(CohortId),
    CONSTRAINT CK_StudentProfiles_CGPA CHECK (CurrentCGPA IS NULL OR CurrentCGPA BETWEEN 0 AND 10),
    CONSTRAINT CK_StudentProfiles_Semester CHECK (CurrentSemester IS NULL OR CurrentSemester BETWEEN 1 AND 20)
);
GO
CREATE UNIQUE INDEX UX_StudentProfiles_Enrollment ON dbo.StudentProfiles(EnrollmentNumber) WHERE EnrollmentNumber IS NOT NULL;
GO
CREATE TABLE dbo.FacultyProfiles (
    FacultyProfileId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_FacultyProfiles PRIMARY KEY,
    UserId BIGINT NOT NULL,
    EmployeeCode NVARCHAR(50) NULL,
    Designation NVARCHAR(100) NULL,
    DepartmentId BIGINT NULL,
    Bio NVARCHAR(1000) NULL,
    CreatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_FacultyProfiles_CreatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT UQ_FacultyProfiles_User UNIQUE (UserId),
    CONSTRAINT FK_FacultyProfiles_Users FOREIGN KEY (UserId) REFERENCES dbo.Users(UserId),
    CONSTRAINT FK_FacultyProfiles_Departments FOREIGN KEY (DepartmentId) REFERENCES dbo.Departments(DepartmentId)
);
GO
CREATE UNIQUE INDEX UX_FacultyProfiles_EmployeeCode ON dbo.FacultyProfiles(EmployeeCode) WHERE EmployeeCode IS NOT NULL;
GO
CREATE TABLE dbo.FacultyCohorts (
    FacultyProfileId BIGINT NOT NULL,
    CohortId BIGINT NOT NULL,
    AssignedAt DATETIME2(0) NOT NULL CONSTRAINT DF_FacultyCohorts_AssignedAt DEFAULT SYSUTCDATETIME(),
    AssignedByUserId BIGINT NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_FacultyCohorts_IsActive DEFAULT (1),
    CONSTRAINT PK_FacultyCohorts PRIMARY KEY (FacultyProfileId, CohortId),
    CONSTRAINT FK_FacultyCohorts_Faculty FOREIGN KEY (FacultyProfileId) REFERENCES dbo.FacultyProfiles(FacultyProfileId),
    CONSTRAINT FK_FacultyCohorts_Cohorts FOREIGN KEY (CohortId) REFERENCES dbo.Cohorts(CohortId),
    CONSTRAINT FK_FacultyCohorts_AssignedBy FOREIGN KEY (AssignedByUserId) REFERENCES dbo.Users(UserId)
);
GO
CREATE TABLE dbo.OnboardingProgress (
    OnboardingProgressId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_OnboardingProgress PRIMARY KEY,
    UserId BIGINT NOT NULL,
    CurrentStep NVARCHAR(100) NULL,
    CompletedStepsJson NVARCHAR(MAX) NULL,
    IsCompleted BIT NOT NULL CONSTRAINT DF_OnboardingProgress_IsCompleted DEFAULT (0),
    UpdatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_OnboardingProgress_UpdatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT UQ_OnboardingProgress_User UNIQUE (UserId),
    CONSTRAINT FK_OnboardingProgress_Users FOREIGN KEY (UserId) REFERENCES dbo.Users(UserId),
    CONSTRAINT CK_OnboardingProgress_Json CHECK (CompletedStepsJson IS NULL OR ISJSON(CompletedStepsJson) = 1)
);
GO

/* 3. Companies and skills */
CREATE TABLE dbo.Companies (
    CompanyId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Companies PRIMARY KEY,
    CompanyName NVARCHAR(200) NOT NULL,
    Category NVARCHAR(100) NULL,
    WebsiteUrl NVARCHAR(500) NULL,
    Description NVARCHAR(MAX) NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_Companies_IsActive DEFAULT (1),
    CreatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_Companies_CreatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT UQ_Companies_Name UNIQUE (CompanyName)
);
GO
CREATE TABLE dbo.StudentTargetCompanies (
    UserId BIGINT NOT NULL,
    CompanyId BIGINT NOT NULL,
    SelectedAt DATETIME2(0) NOT NULL CONSTRAINT DF_StudentTargetCompanies_SelectedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT PK_StudentTargetCompanies PRIMARY KEY (UserId, CompanyId),
    CONSTRAINT FK_StudentTargetCompanies_Student FOREIGN KEY (UserId) REFERENCES dbo.StudentProfiles(UserId),
    CONSTRAINT FK_StudentTargetCompanies_Company FOREIGN KEY (CompanyId) REFERENCES dbo.Companies(CompanyId)
);
GO
CREATE TABLE dbo.Skills (
    SkillId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Skills PRIMARY KEY,
    SkillName NVARCHAR(150) NOT NULL,
    SkillCategory NVARCHAR(100) NULL,
    Description NVARCHAR(500) NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_Skills_IsActive DEFAULT (1),
    CONSTRAINT UQ_Skills_SkillName UNIQUE (SkillName)
);
GO
CREATE TABLE dbo.StudentSkillRatings (
    UserId BIGINT NOT NULL,
    SkillId BIGINT NOT NULL,
    ProficiencyLevel TINYINT NOT NULL,
    RatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_StudentSkillRatings_RatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT PK_StudentSkillRatings PRIMARY KEY (UserId, SkillId),
    CONSTRAINT FK_StudentSkillRatings_Student FOREIGN KEY (UserId) REFERENCES dbo.StudentProfiles(UserId),
    CONSTRAINT FK_StudentSkillRatings_Skill FOREIGN KEY (SkillId) REFERENCES dbo.Skills(SkillId),
    CONSTRAINT CK_StudentSkillRatings_Level CHECK (ProficiencyLevel BETWEEN 1 AND 3)
);
GO

/* 4. Question bank and assessments */
CREATE TABLE dbo.QuestionCategories (
    QuestionCategoryId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_QuestionCategories PRIMARY KEY,
    CategoryName NVARCHAR(150) NOT NULL,
    CategoryType NVARCHAR(50) NOT NULL,
    ParentCategoryId BIGINT NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_QuestionCategories_IsActive DEFAULT (1),
    CONSTRAINT FK_QuestionCategories_Parent FOREIGN KEY (ParentCategoryId) REFERENCES dbo.QuestionCategories(QuestionCategoryId),
    CONSTRAINT UQ_QuestionCategories_Name_Type UNIQUE (CategoryName, CategoryType)
);
GO
CREATE TABLE dbo.Questions (
    QuestionId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Questions PRIMARY KEY,
    QuestionCategoryId BIGINT NOT NULL,
    QuestionType NVARCHAR(30) NOT NULL,
    QuestionText NVARCHAR(MAX) NOT NULL,
    Explanation NVARCHAR(MAX) NULL,
    Difficulty TINYINT NOT NULL CONSTRAINT DF_Questions_Difficulty DEFAULT (2),
    DefaultMarks DECIMAL(7,2) NOT NULL CONSTRAINT DF_Questions_DefaultMarks DEFAULT (1),
    Status NVARCHAR(20) NOT NULL CONSTRAINT DF_Questions_Status DEFAULT ('Draft'),
    CreatedByUserId BIGINT NULL,
    ReviewedByUserId BIGINT NULL,
    CreatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_Questions_CreatedAt DEFAULT SYSUTCDATETIME(),
    UpdatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_Questions_UpdatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_Questions_Category FOREIGN KEY (QuestionCategoryId) REFERENCES dbo.QuestionCategories(QuestionCategoryId),
    CONSTRAINT FK_Questions_CreatedBy FOREIGN KEY (CreatedByUserId) REFERENCES dbo.Users(UserId),
    CONSTRAINT FK_Questions_ReviewedBy FOREIGN KEY (ReviewedByUserId) REFERENCES dbo.Users(UserId),
    CONSTRAINT CK_Questions_Type CHECK (QuestionType IN ('SingleChoice','MultipleChoice','Text','Coding')),
    CONSTRAINT CK_Questions_Difficulty CHECK (Difficulty BETWEEN 1 AND 5),
    CONSTRAINT CK_Questions_Marks CHECK (DefaultMarks >= 0),
    CONSTRAINT CK_Questions_Status CHECK (Status IN ('Draft','Review','Published','Archived'))
);
GO
CREATE TABLE dbo.QuestionOptions (
    QuestionOptionId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_QuestionOptions PRIMARY KEY,
    QuestionId BIGINT NOT NULL,
    OptionLabel NVARCHAR(10) NOT NULL,
    OptionText NVARCHAR(MAX) NOT NULL,
    IsCorrect BIT NOT NULL CONSTRAINT DF_QuestionOptions_IsCorrect DEFAULT (0),
    SortOrder INT NOT NULL,
    CONSTRAINT FK_QuestionOptions_Questions FOREIGN KEY (QuestionId) REFERENCES dbo.Questions(QuestionId),
    CONSTRAINT UQ_QuestionOptions_Label UNIQUE (QuestionId, OptionLabel),
    CONSTRAINT UQ_QuestionOptions_Sort UNIQUE (QuestionId, SortOrder)
);
GO
CREATE TABLE dbo.Tags (
    TagId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Tags PRIMARY KEY,
    TagName NVARCHAR(100) NOT NULL,
    CONSTRAINT UQ_Tags_TagName UNIQUE (TagName)
);
GO
CREATE TABLE dbo.QuestionTags (
    QuestionId BIGINT NOT NULL,
    TagId BIGINT NOT NULL,
    CONSTRAINT PK_QuestionTags PRIMARY KEY (QuestionId, TagId),
    CONSTRAINT FK_QuestionTags_Questions FOREIGN KEY (QuestionId) REFERENCES dbo.Questions(QuestionId),
    CONSTRAINT FK_QuestionTags_Tags FOREIGN KEY (TagId) REFERENCES dbo.Tags(TagId)
);
GO
CREATE TABLE dbo.QuestionCompanyTags (
    QuestionId BIGINT NOT NULL,
    CompanyId BIGINT NOT NULL,
    CONSTRAINT PK_QuestionCompanyTags PRIMARY KEY (QuestionId, CompanyId),
    CONSTRAINT FK_QuestionCompanyTags_Questions FOREIGN KEY (QuestionId) REFERENCES dbo.Questions(QuestionId),
    CONSTRAINT FK_QuestionCompanyTags_Companies FOREIGN KEY (CompanyId) REFERENCES dbo.Companies(CompanyId)
);
GO
CREATE TABLE dbo.Assessments (
    AssessmentId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Assessments PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    SystemCode NVARCHAR(80) NULL,
    Description NVARCHAR(MAX) NULL,
    TrackType NVARCHAR(50) NOT NULL,
    DurationMinutes INT NOT NULL,
    PassingMarks DECIMAL(9,2) NULL,
    NegativeMarkingEnabled BIT NOT NULL CONSTRAINT DF_Assessments_NegativeMarking DEFAULT (0),
    NegativeMarksPerWrongAnswer DECIMAL(7,2) NOT NULL CONSTRAINT DF_Assessments_NegativeMarks DEFAULT (0),
    RandomizeQuestions BIT NOT NULL CONSTRAINT DF_Assessments_RandomizeQuestions DEFAULT (0),
    OpensAt DATETIME2(0) NULL,
    ClosesAt DATETIME2(0) NULL,
    MaxAttempts INT NULL,
    Status NVARCHAR(20) NOT NULL CONSTRAINT DF_Assessments_Status DEFAULT ('Draft'),
    CreatedByUserId BIGINT NULL,
    CreatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_Assessments_CreatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_Assessments_CreatedBy FOREIGN KEY (CreatedByUserId) REFERENCES dbo.Users(UserId),
    CONSTRAINT CK_Assessments_Duration CHECK (DurationMinutes > 0),
    CONSTRAINT CK_Assessments_MaxAttempts CHECK (MaxAttempts IS NULL OR MaxAttempts > 0),
    CONSTRAINT CK_Assessments_Window CHECK (ClosesAt IS NULL OR OpensAt IS NULL OR ClosesAt > OpensAt),
    CONSTRAINT CK_Assessments_Status CHECK (Status IN ('Draft','Published','Archived'))
);
GO
CREATE UNIQUE INDEX UX_Assessments_SystemCode ON dbo.Assessments(SystemCode) WHERE SystemCode IS NOT NULL;
GO
CREATE TABLE dbo.AssessmentSections (
    AssessmentSectionId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_AssessmentSections PRIMARY KEY,
    AssessmentId BIGINT NOT NULL,
    SectionName NVARCHAR(150) NOT NULL,
    SortOrder INT NOT NULL,
    DurationMinutes INT NULL,
    Instructions NVARCHAR(MAX) NULL,
    CONSTRAINT FK_AssessmentSections_Assessments FOREIGN KEY (AssessmentId) REFERENCES dbo.Assessments(AssessmentId),
    CONSTRAINT UQ_AssessmentSections_Sort UNIQUE (AssessmentId, SortOrder)
);
GO
CREATE TABLE dbo.AssessmentQuestions (
    AssessmentQuestionId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_AssessmentQuestions PRIMARY KEY,
    AssessmentSectionId BIGINT NOT NULL,
    QuestionId BIGINT NOT NULL,
    SortOrder INT NOT NULL,
    Marks DECIMAL(7,2) NOT NULL,
    NegativeMarks DECIMAL(7,2) NOT NULL CONSTRAINT DF_AssessmentQuestions_NegativeMarks DEFAULT (0),
    IsRequired BIT NOT NULL CONSTRAINT DF_AssessmentQuestions_IsRequired DEFAULT (1),
    CONSTRAINT FK_AssessmentQuestions_Sections FOREIGN KEY (AssessmentSectionId) REFERENCES dbo.AssessmentSections(AssessmentSectionId),
    CONSTRAINT FK_AssessmentQuestions_Questions FOREIGN KEY (QuestionId) REFERENCES dbo.Questions(QuestionId),
    CONSTRAINT UQ_AssessmentQuestions_Question UNIQUE (AssessmentSectionId, QuestionId),
    CONSTRAINT UQ_AssessmentQuestions_Sort UNIQUE (AssessmentSectionId, SortOrder),
    CONSTRAINT CK_AssessmentQuestions_Marks CHECK (Marks >= 0 AND NegativeMarks >= 0)
);
GO
CREATE TABLE dbo.AssessmentCohorts (
    AssessmentId BIGINT NOT NULL,
    CohortId BIGINT NOT NULL,
    AssignedAt DATETIME2(0) NOT NULL CONSTRAINT DF_AssessmentCohorts_AssignedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT PK_AssessmentCohorts PRIMARY KEY (AssessmentId, CohortId),
    CONSTRAINT FK_AssessmentCohorts_Assessments FOREIGN KEY (AssessmentId) REFERENCES dbo.Assessments(AssessmentId),
    CONSTRAINT FK_AssessmentCohorts_Cohorts FOREIGN KEY (CohortId) REFERENCES dbo.Cohorts(CohortId)
);
GO
CREATE TABLE dbo.AssessmentAttempts (
    AttemptId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_AssessmentAttempts PRIMARY KEY,
    AssessmentId BIGINT NOT NULL,
    UserId BIGINT NOT NULL,
    AttemptNumber INT NOT NULL,
    StartedAt DATETIME2(0) NOT NULL CONSTRAINT DF_AssessmentAttempts_StartedAt DEFAULT SYSUTCDATETIME(),
    SubmittedAt DATETIME2(0) NULL,
    TotalMarks DECIMAL(9,2) NULL,
    Percentage DECIMAL(5,2) NULL,
    Status NVARCHAR(20) NOT NULL CONSTRAINT DF_AssessmentAttempts_Status DEFAULT ('InProgress'),
    IsPassed BIT NULL,
    CONSTRAINT FK_AssessmentAttempts_Assessments FOREIGN KEY (AssessmentId) REFERENCES dbo.Assessments(AssessmentId),
    CONSTRAINT FK_AssessmentAttempts_Students FOREIGN KEY (UserId) REFERENCES dbo.StudentProfiles(UserId),
    CONSTRAINT UQ_AssessmentAttempts_Number UNIQUE (AssessmentId, UserId, AttemptNumber),
    CONSTRAINT CK_AssessmentAttempts_Number CHECK (AttemptNumber > 0),
    CONSTRAINT CK_AssessmentAttempts_Percentage CHECK (Percentage IS NULL OR Percentage BETWEEN 0 AND 100),
    CONSTRAINT CK_AssessmentAttempts_Status CHECK (Status IN ('InProgress','Submitted','Evaluated','Abandoned'))
);
GO
CREATE TABLE dbo.AttemptAnswers (
    AttemptAnswerId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_AttemptAnswers PRIMARY KEY,
    AttemptId BIGINT NOT NULL,
    AssessmentQuestionId BIGINT NOT NULL,
    SelectedQuestionOptionId BIGINT NULL,
    AnswerText NVARCHAR(MAX) NULL,
    IsCorrect BIT NULL,
    MarksAwarded DECIMAL(7,2) NULL,
    TimeSpentSeconds INT NULL,
    AnsweredAt DATETIME2(0) NULL,
    CONSTRAINT FK_AttemptAnswers_Attempts FOREIGN KEY (AttemptId) REFERENCES dbo.AssessmentAttempts(AttemptId),
    CONSTRAINT FK_AttemptAnswers_AssessmentQuestions FOREIGN KEY (AssessmentQuestionId) REFERENCES dbo.AssessmentQuestions(AssessmentQuestionId),
    CONSTRAINT FK_AttemptAnswers_Options FOREIGN KEY (SelectedQuestionOptionId) REFERENCES dbo.QuestionOptions(QuestionOptionId),
    CONSTRAINT UQ_AttemptAnswers_Question UNIQUE (AttemptId, AssessmentQuestionId),
    CONSTRAINT CK_AttemptAnswers_Time CHECK (TimeSpentSeconds IS NULL OR TimeSpentSeconds >= 0)
);
GO
CREATE TABLE dbo.AttemptAnswerOptions (
    AttemptAnswerId BIGINT NOT NULL,
    QuestionOptionId BIGINT NOT NULL,
    CONSTRAINT PK_AttemptAnswerOptions PRIMARY KEY (AttemptAnswerId, QuestionOptionId),
    CONSTRAINT FK_AttemptAnswerOptions_Answers FOREIGN KEY (AttemptAnswerId) REFERENCES dbo.AttemptAnswers(AttemptAnswerId),
    CONSTRAINT FK_AttemptAnswerOptions_Options FOREIGN KEY (QuestionOptionId) REFERENCES dbo.QuestionOptions(QuestionOptionId)
);
GO
CREATE TABLE dbo.ProctorEvents (
    ProctorEventId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_ProctorEvents PRIMARY KEY,
    AttemptId BIGINT NOT NULL,
    EventType NVARCHAR(80) NOT NULL,
    EventDetails NVARCHAR(MAX) NULL,
    OccurredAt DATETIME2(0) NOT NULL CONSTRAINT DF_ProctorEvents_OccurredAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_ProctorEvents_Attempts FOREIGN KEY (AttemptId) REFERENCES dbo.AssessmentAttempts(AttemptId)
);
GO
CREATE TABLE dbo.AssessmentAttemptTopicScores (
    AttemptTopicScoreId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_AssessmentAttemptTopicScores PRIMARY KEY,
    AttemptId BIGINT NOT NULL,
    QuestionCategoryId BIGINT NOT NULL,
    MarksEarned DECIMAL(9,2) NOT NULL CONSTRAINT DF_AssessmentAttemptTopicScores_MarksEarned DEFAULT (0),
    MarksAvailable DECIMAL(9,2) NOT NULL CONSTRAINT DF_AssessmentAttemptTopicScores_MarksAvailable DEFAULT (0),
    CONSTRAINT FK_AssessmentAttemptTopicScores_Attempts FOREIGN KEY (AttemptId) REFERENCES dbo.AssessmentAttempts(AttemptId),
    CONSTRAINT FK_AssessmentAttemptTopicScores_Categories FOREIGN KEY (QuestionCategoryId) REFERENCES dbo.QuestionCategories(QuestionCategoryId),
    CONSTRAINT UQ_AssessmentAttemptTopicScores UNIQUE (AttemptId, QuestionCategoryId),
    CONSTRAINT CK_AssessmentAttemptTopicScores_Marks CHECK (MarksEarned >= 0 AND MarksAvailable >= 0)
);
GO
CREATE TABLE dbo.AssessmentAttemptRecommendations (
    RecommendationId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_AssessmentAttemptRecommendations PRIMARY KEY,
    AttemptId BIGINT NOT NULL,
    QuestionCategoryId BIGINT NULL,
    RecommendationText NVARCHAR(MAX) NOT NULL,
    Priority TINYINT NOT NULL CONSTRAINT DF_AssessmentAttemptRecommendations_Priority DEFAULT (3),
    CreatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_AssessmentAttemptRecommendations_CreatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_AssessmentAttemptRecommendations_Attempts FOREIGN KEY (AttemptId) REFERENCES dbo.AssessmentAttempts(AttemptId),
    CONSTRAINT FK_AssessmentAttemptRecommendations_Categories FOREIGN KEY (QuestionCategoryId) REFERENCES dbo.QuestionCategories(QuestionCategoryId),
    CONSTRAINT CK_AssessmentAttemptRecommendations_Priority CHECK (Priority BETWEEN 1 AND 5)
);
GO

/* 5. Coding practice */
CREATE TABLE dbo.CodingProblems (
    CodingProblemId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_CodingProblems PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    Slug NVARCHAR(220) NOT NULL,
    ProblemStatement NVARCHAR(MAX) NOT NULL,
    InputFormat NVARCHAR(MAX) NULL,
    OutputFormat NVARCHAR(MAX) NULL,
    ConstraintsText NVARCHAR(MAX) NULL,
    Difficulty TINYINT NOT NULL CONSTRAINT DF_CodingProblems_Difficulty DEFAULT (2),
    TimeLimitMs INT NOT NULL CONSTRAINT DF_CodingProblems_TimeLimit DEFAULT (2000),
    MemoryLimitMb INT NOT NULL CONSTRAINT DF_CodingProblems_MemoryLimit DEFAULT (256),
    IsPublished BIT NOT NULL CONSTRAINT DF_CodingProblems_IsPublished DEFAULT (0),
    CreatedByUserId BIGINT NULL,
    CreatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_CodingProblems_CreatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT UQ_CodingProblems_Slug UNIQUE (Slug),
    CONSTRAINT FK_CodingProblems_CreatedBy FOREIGN KEY (CreatedByUserId) REFERENCES dbo.Users(UserId),
    CONSTRAINT CK_CodingProblems_Difficulty CHECK (Difficulty BETWEEN 1 AND 5),
    CONSTRAINT CK_CodingProblems_Limits CHECK (TimeLimitMs > 0 AND MemoryLimitMb > 0)
);
GO
CREATE TABLE dbo.CodingProblemTags (
    CodingProblemId BIGINT NOT NULL,
    TagId BIGINT NOT NULL,
    CONSTRAINT PK_CodingProblemTags PRIMARY KEY (CodingProblemId, TagId),
    CONSTRAINT FK_CodingProblemTags_Problems FOREIGN KEY (CodingProblemId) REFERENCES dbo.CodingProblems(CodingProblemId),
    CONSTRAINT FK_CodingProblemTags_Tags FOREIGN KEY (TagId) REFERENCES dbo.Tags(TagId)
);
GO
CREATE TABLE dbo.CodingExamples (
    CodingExampleId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_CodingExamples PRIMARY KEY,
    CodingProblemId BIGINT NOT NULL,
    InputText NVARCHAR(MAX) NOT NULL,
    ExpectedOutput NVARCHAR(MAX) NOT NULL,
    Explanation NVARCHAR(MAX) NULL,
    SortOrder INT NOT NULL,
    CONSTRAINT FK_CodingExamples_Problems FOREIGN KEY (CodingProblemId) REFERENCES dbo.CodingProblems(CodingProblemId),
    CONSTRAINT UQ_CodingExamples_Sort UNIQUE (CodingProblemId, SortOrder)
);
GO
CREATE TABLE dbo.CodingTestCases (
    CodingTestCaseId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_CodingTestCases PRIMARY KEY,
    CodingProblemId BIGINT NOT NULL,
    InputText NVARCHAR(MAX) NOT NULL,
    ExpectedOutput NVARCHAR(MAX) NOT NULL,
    IsHidden BIT NOT NULL CONSTRAINT DF_CodingTestCases_IsHidden DEFAULT (1),
    Weight DECIMAL(7,2) NOT NULL CONSTRAINT DF_CodingTestCases_Weight DEFAULT (1),
    SortOrder INT NOT NULL,
    CONSTRAINT FK_CodingTestCases_Problems FOREIGN KEY (CodingProblemId) REFERENCES dbo.CodingProblems(CodingProblemId),
    CONSTRAINT UQ_CodingTestCases_Sort UNIQUE (CodingProblemId, SortOrder),
    CONSTRAINT CK_CodingTestCases_Weight CHECK (Weight > 0)
);
GO
CREATE TABLE dbo.CodeSubmissions (
    CodeSubmissionId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_CodeSubmissions PRIMARY KEY,
    CodingProblemId BIGINT NOT NULL,
    UserId BIGINT NOT NULL,
    Language NVARCHAR(50) NOT NULL,
    SourceCode NVARCHAR(MAX) NOT NULL,
    Status NVARCHAR(30) NOT NULL CONSTRAINT DF_CodeSubmissions_Status DEFAULT ('Queued'),
    Score DECIMAL(9,2) NULL,
    ExecutionTimeMs INT NULL,
    MemoryUsedKb BIGINT NULL,
    SubmittedAt DATETIME2(0) NOT NULL CONSTRAINT DF_CodeSubmissions_SubmittedAt DEFAULT SYSUTCDATETIME(),
    CompletedAt DATETIME2(0) NULL,
    CONSTRAINT FK_CodeSubmissions_Problems FOREIGN KEY (CodingProblemId) REFERENCES dbo.CodingProblems(CodingProblemId),
    CONSTRAINT FK_CodeSubmissions_Students FOREIGN KEY (UserId) REFERENCES dbo.StudentProfiles(UserId),
    CONSTRAINT CK_CodeSubmissions_Status CHECK (Status IN ('Queued','Running','Accepted','WrongAnswer','CompileError','RuntimeError','TimeLimitExceeded','MemoryLimitExceeded','SystemError'))
);
GO
CREATE TABLE dbo.CodeSubmissionResults (
    CodeSubmissionResultId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_CodeSubmissionResults PRIMARY KEY,
    CodeSubmissionId BIGINT NOT NULL,
    CodingTestCaseId BIGINT NOT NULL,
    ResultStatus NVARCHAR(30) NOT NULL,
    ExecutionTimeMs INT NULL,
    MemoryUsedKb BIGINT NULL,
    ErrorOutput NVARCHAR(MAX) NULL,
    ExecutedAt DATETIME2(0) NOT NULL CONSTRAINT DF_CodeSubmissionResults_ExecutedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_CodeSubmissionResults_Submissions FOREIGN KEY (CodeSubmissionId) REFERENCES dbo.CodeSubmissions(CodeSubmissionId),
    CONSTRAINT FK_CodeSubmissionResults_TestCases FOREIGN KEY (CodingTestCaseId) REFERENCES dbo.CodingTestCases(CodingTestCaseId),
    CONSTRAINT UQ_CodeSubmissionResults_Run UNIQUE (CodeSubmissionId, CodingTestCaseId)
);
GO

/* 6. Resume upload and analysis */
CREATE TABLE dbo.Resumes (
    ResumeId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Resumes PRIMARY KEY,
    UserId BIGINT NOT NULL,
    OriginalFileName NVARCHAR(255) NOT NULL,
    StorageKey NVARCHAR(500) NOT NULL,
    ContentType NVARCHAR(100) NOT NULL,
    FileSizeBytes BIGINT NOT NULL,
    UploadStatus NVARCHAR(20) NOT NULL CONSTRAINT DF_Resumes_UploadStatus DEFAULT ('Uploaded'),
    IsPrimary BIT NOT NULL CONSTRAINT DF_Resumes_IsPrimary DEFAULT (0),
    UploadedAt DATETIME2(0) NOT NULL CONSTRAINT DF_Resumes_UploadedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_Resumes_Students FOREIGN KEY (UserId) REFERENCES dbo.StudentProfiles(UserId),
    CONSTRAINT UQ_Resumes_StorageKey UNIQUE (StorageKey),
    CONSTRAINT CK_Resumes_FileSize CHECK (FileSizeBytes > 0),
    CONSTRAINT CK_Resumes_UploadStatus CHECK (UploadStatus IN ('Uploaded','Processing','Processed','Failed','Deleted'))
);
GO
CREATE UNIQUE INDEX UX_Resumes_OnePrimaryPerUser ON dbo.Resumes(UserId) WHERE IsPrimary = 1 AND UploadStatus <> 'Deleted';
GO
CREATE TABLE dbo.ResumeAnalysisRuns (
    ResumeAnalysisRunId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_ResumeAnalysisRuns PRIMARY KEY,
    ResumeId BIGINT NOT NULL,
    TargetRole NVARCHAR(150) NULL,
    AtsScore DECIMAL(5,2) NULL,
    ParsabilityScore DECIMAL(5,2) NULL,
    Status NVARCHAR(20) NOT NULL CONSTRAINT DF_ResumeAnalysisRuns_Status DEFAULT ('Queued'),
    ModelName NVARCHAR(100) NULL,
    RawResultJson NVARCHAR(MAX) NULL,
    StartedAt DATETIME2(0) NULL,
    CompletedAt DATETIME2(0) NULL,
    CreatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_ResumeAnalysisRuns_CreatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_ResumeAnalysisRuns_Resumes FOREIGN KEY (ResumeId) REFERENCES dbo.Resumes(ResumeId),
    CONSTRAINT CK_ResumeAnalysisRuns_Scores CHECK ((AtsScore IS NULL OR AtsScore BETWEEN 0 AND 100) AND (ParsabilityScore IS NULL OR ParsabilityScore BETWEEN 0 AND 100)),
    CONSTRAINT CK_ResumeAnalysisRuns_Status CHECK (Status IN ('Queued','Running','Completed','Failed')),
    CONSTRAINT CK_ResumeAnalysisRuns_Json CHECK (RawResultJson IS NULL OR ISJSON(RawResultJson) = 1)
);
GO
CREATE TABLE dbo.ResumeEducation (
    ResumeEducationId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_ResumeEducation PRIMARY KEY,
    ResumeAnalysisRunId BIGINT NOT NULL,
    InstitutionName NVARCHAR(200) NULL,
    Degree NVARCHAR(150) NULL,
    FieldOfStudy NVARCHAR(150) NULL,
    StartDate DATE NULL,
    EndDate DATE NULL,
    Grade NVARCHAR(50) NULL,
    SortOrder INT NOT NULL CONSTRAINT DF_ResumeEducation_SortOrder DEFAULT (1),
    CONSTRAINT FK_ResumeEducation_Runs FOREIGN KEY (ResumeAnalysisRunId) REFERENCES dbo.ResumeAnalysisRuns(ResumeAnalysisRunId)
);
GO
CREATE TABLE dbo.ResumeExperience (
    ResumeExperienceId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_ResumeExperience PRIMARY KEY,
    ResumeAnalysisRunId BIGINT NOT NULL,
    EmployerName NVARCHAR(200) NULL,
    JobTitle NVARCHAR(150) NULL,
    Description NVARCHAR(MAX) NULL,
    StartDate DATE NULL,
    EndDate DATE NULL,
    SortOrder INT NOT NULL CONSTRAINT DF_ResumeExperience_SortOrder DEFAULT (1),
    CONSTRAINT FK_ResumeExperience_Runs FOREIGN KEY (ResumeAnalysisRunId) REFERENCES dbo.ResumeAnalysisRuns(ResumeAnalysisRunId)
);
GO
CREATE TABLE dbo.ResumeSkills (
    ResumeAnalysisRunId BIGINT NOT NULL,
    SkillId BIGINT NOT NULL,
    MentionCount INT NOT NULL CONSTRAINT DF_ResumeSkills_MentionCount DEFAULT (1),
    CONSTRAINT PK_ResumeSkills PRIMARY KEY (ResumeAnalysisRunId, SkillId),
    CONSTRAINT FK_ResumeSkills_Runs FOREIGN KEY (ResumeAnalysisRunId) REFERENCES dbo.ResumeAnalysisRuns(ResumeAnalysisRunId),
    CONSTRAINT FK_ResumeSkills_Skills FOREIGN KEY (SkillId) REFERENCES dbo.Skills(SkillId),
    CONSTRAINT CK_ResumeSkills_MentionCount CHECK (MentionCount > 0)
);
GO
CREATE TABLE dbo.ResumeFindings (
    ResumeFindingId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_ResumeFindings PRIMARY KEY,
    ResumeAnalysisRunId BIGINT NOT NULL,
    FindingType NVARCHAR(50) NOT NULL,
    Severity NVARCHAR(20) NOT NULL,
    FindingText NVARCHAR(MAX) NOT NULL,
    SuggestedFix NVARCHAR(MAX) NULL,
    SortOrder INT NOT NULL CONSTRAINT DF_ResumeFindings_SortOrder DEFAULT (1),
    CONSTRAINT FK_ResumeFindings_Runs FOREIGN KEY (ResumeAnalysisRunId) REFERENCES dbo.ResumeAnalysisRuns(ResumeAnalysisRunId),
    CONSTRAINT CK_ResumeFindings_Severity CHECK (Severity IN ('Info','Low','Medium','High','Critical'))
);
GO

/* 7. Learning modules and skill-gap analysis */
CREATE TABLE dbo.LearningModules (
    LearningModuleId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_LearningModules PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX) NULL,
    SkillId BIGINT NULL,
    ContentType NVARCHAR(50) NULL,
    ContentUrl NVARCHAR(1000) NULL,
    EstimatedMinutes INT NULL,
    Difficulty TINYINT NULL,
    IsPublished BIT NOT NULL CONSTRAINT DF_LearningModules_IsPublished DEFAULT (0),
    CreatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_LearningModules_CreatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_LearningModules_Skills FOREIGN KEY (SkillId) REFERENCES dbo.Skills(SkillId),
    CONSTRAINT CK_LearningModules_EstimatedMinutes CHECK (EstimatedMinutes IS NULL OR EstimatedMinutes > 0),
    CONSTRAINT CK_LearningModules_Difficulty CHECK (Difficulty IS NULL OR Difficulty BETWEEN 1 AND 5)
);
GO
CREATE TABLE dbo.LearningTopics (
    LearningTopicId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_LearningTopics PRIMARY KEY,
    LearningModuleId BIGINT NOT NULL,
    TopicTitle NVARCHAR(200) NOT NULL,
    TopicContent NVARCHAR(MAX) NULL,
    SortOrder INT NOT NULL,
    CONSTRAINT FK_LearningTopics_Modules FOREIGN KEY (LearningModuleId) REFERENCES dbo.LearningModules(LearningModuleId),
    CONSTRAINT UQ_LearningTopics_Sort UNIQUE (LearningModuleId, SortOrder)
);
GO
CREATE TABLE dbo.SkillGapAnalyses (
    SkillGapAnalysisId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_SkillGapAnalyses PRIMARY KEY,
    UserId BIGINT NOT NULL,
    TargetRole NVARCHAR(150) NULL,
    OverallScore DECIMAL(5,2) NULL,
    Status NVARCHAR(20) NOT NULL CONSTRAINT DF_SkillGapAnalyses_Status DEFAULT ('Completed'),
    CreatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_SkillGapAnalyses_CreatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_SkillGapAnalyses_Students FOREIGN KEY (UserId) REFERENCES dbo.StudentProfiles(UserId),
    CONSTRAINT CK_SkillGapAnalyses_Score CHECK (OverallScore IS NULL OR OverallScore BETWEEN 0 AND 100)
);
GO
CREATE TABLE dbo.SkillGapItems (
    SkillGapItemId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_SkillGapItems PRIMARY KEY,
    SkillGapAnalysisId BIGINT NOT NULL,
    SkillId BIGINT NOT NULL,
    CurrentLevel TINYINT NOT NULL,
    RequiredLevel TINYINT NOT NULL,
    RecommendedAction NVARCHAR(MAX) NULL,
    LearningModuleId BIGINT NULL,
    CONSTRAINT FK_SkillGapItems_Analyses FOREIGN KEY (SkillGapAnalysisId) REFERENCES dbo.SkillGapAnalyses(SkillGapAnalysisId),
    CONSTRAINT FK_SkillGapItems_Skills FOREIGN KEY (SkillId) REFERENCES dbo.Skills(SkillId),
    CONSTRAINT FK_SkillGapItems_Modules FOREIGN KEY (LearningModuleId) REFERENCES dbo.LearningModules(LearningModuleId),
    CONSTRAINT UQ_SkillGapItems_Skill UNIQUE (SkillGapAnalysisId, SkillId),
    CONSTRAINT CK_SkillGapItems_Levels CHECK (CurrentLevel BETWEEN 1 AND 5 AND RequiredLevel BETWEEN 1 AND 5)
);
GO
CREATE TABLE dbo.StudentLearningProgress (
    StudentLearningProgressId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_StudentLearningProgress PRIMARY KEY,
    UserId BIGINT NOT NULL,
    LearningModuleId BIGINT NOT NULL,
    Status NVARCHAR(20) NOT NULL CONSTRAINT DF_StudentLearningProgress_Status DEFAULT ('NotStarted'),
    ProgressPercent DECIMAL(5,2) NOT NULL CONSTRAINT DF_StudentLearningProgress_Percent DEFAULT (0),
    StartedAt DATETIME2(0) NULL,
    CompletedAt DATETIME2(0) NULL,
    UpdatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_StudentLearningProgress_UpdatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_StudentLearningProgress_Students FOREIGN KEY (UserId) REFERENCES dbo.StudentProfiles(UserId),
    CONSTRAINT FK_StudentLearningProgress_Modules FOREIGN KEY (LearningModuleId) REFERENCES dbo.LearningModules(LearningModuleId),
    CONSTRAINT UQ_StudentLearningProgress_UserModule UNIQUE (UserId, LearningModuleId),
    CONSTRAINT CK_StudentLearningProgress_Percent CHECK (ProgressPercent BETWEEN 0 AND 100),
    CONSTRAINT CK_StudentLearningProgress_Status CHECK (Status IN ('NotStarted','InProgress','Completed','Skipped'))
);
GO

/* 8. Mock interviews and evaluations */
CREATE TABLE dbo.MockInterviewSessions (
    MockInterviewSessionId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_MockInterviewSessions PRIMARY KEY,
    UserId BIGINT NOT NULL,
    TargetRole NVARCHAR(150) NULL,
    InterviewType NVARCHAR(50) NOT NULL,
    Status NVARCHAR(20) NOT NULL CONSTRAINT DF_MockInterviewSessions_Status DEFAULT ('Created'),
    StartedAt DATETIME2(0) NULL,
    EndedAt DATETIME2(0) NULL,
    CreatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_MockInterviewSessions_CreatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_MockInterviewSessions_Students FOREIGN KEY (UserId) REFERENCES dbo.StudentProfiles(UserId),
    CONSTRAINT CK_MockInterviewSessions_Status CHECK (Status IN ('Created','InProgress','Completed','Cancelled','Failed'))
);
GO
CREATE TABLE dbo.InterviewTranscriptEntries (
    InterviewTranscriptEntryId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_InterviewTranscriptEntries PRIMARY KEY,
    MockInterviewSessionId BIGINT NOT NULL,
    Speaker NVARCHAR(20) NOT NULL,
    EntryText NVARCHAR(MAX) NOT NULL,
    SequenceNumber INT NOT NULL,
    CreatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_InterviewTranscriptEntries_CreatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_InterviewTranscriptEntries_Sessions FOREIGN KEY (MockInterviewSessionId) REFERENCES dbo.MockInterviewSessions(MockInterviewSessionId),
    CONSTRAINT UQ_InterviewTranscriptEntries_Sequence UNIQUE (MockInterviewSessionId, SequenceNumber),
    CONSTRAINT CK_InterviewTranscriptEntries_Speaker CHECK (Speaker IN ('Interviewer','Candidate','System'))
);
GO
CREATE TABLE dbo.InterviewEvaluations (
    InterviewEvaluationId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_InterviewEvaluations PRIMARY KEY,
    MockInterviewSessionId BIGINT NOT NULL,
    EvaluatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_InterviewEvaluations_EvaluatedAt DEFAULT SYSUTCDATETIME(),
    OverallScore DECIMAL(5,2) NULL,
    Summary NVARCHAR(MAX) NULL,
    RawResultJson NVARCHAR(MAX) NULL,
    ModelName NVARCHAR(100) NULL,
    IsCurrent BIT NOT NULL CONSTRAINT DF_InterviewEvaluations_IsCurrent DEFAULT (1),
    CONSTRAINT FK_InterviewEvaluations_Sessions FOREIGN KEY (MockInterviewSessionId) REFERENCES dbo.MockInterviewSessions(MockInterviewSessionId),
    CONSTRAINT CK_InterviewEvaluations_Score CHECK (OverallScore IS NULL OR OverallScore BETWEEN 0 AND 100),
    CONSTRAINT CK_InterviewEvaluations_Json CHECK (RawResultJson IS NULL OR ISJSON(RawResultJson) = 1)
);
GO
CREATE UNIQUE INDEX UX_InterviewEvaluations_Current ON dbo.InterviewEvaluations(MockInterviewSessionId) WHERE IsCurrent = 1;
GO
CREATE TABLE dbo.InterviewEvaluationScores (
    InterviewEvaluationScoreId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_InterviewEvaluationScores PRIMARY KEY,
    InterviewEvaluationId BIGINT NOT NULL,
    CategoryName NVARCHAR(100) NOT NULL,
    Score DECIMAL(5,2) NOT NULL,
    Feedback NVARCHAR(MAX) NULL,
    CONSTRAINT FK_InterviewEvaluationScores_Evaluations FOREIGN KEY (InterviewEvaluationId) REFERENCES dbo.InterviewEvaluations(InterviewEvaluationId),
    CONSTRAINT UQ_InterviewEvaluationScores_Category UNIQUE (InterviewEvaluationId, CategoryName),
    CONSTRAINT CK_InterviewEvaluationScores_Score CHECK (Score BETWEEN 0 AND 100)
);
GO
CREATE TABLE dbo.MentorReviewRequests (
    MentorReviewRequestId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_MentorReviewRequests PRIMARY KEY,
    MockInterviewSessionId BIGINT NOT NULL,
    RequestedByUserId BIGINT NOT NULL,
    AssignedFacultyProfileId BIGINT NULL,
    Status NVARCHAR(20) NOT NULL CONSTRAINT DF_MentorReviewRequests_Status DEFAULT ('Pending'),
    RequestedAt DATETIME2(0) NOT NULL CONSTRAINT DF_MentorReviewRequests_RequestedAt DEFAULT SYSUTCDATETIME(),
    CompletedAt DATETIME2(0) NULL,
    CONSTRAINT FK_MentorReviewRequests_Sessions FOREIGN KEY (MockInterviewSessionId) REFERENCES dbo.MockInterviewSessions(MockInterviewSessionId),
    CONSTRAINT FK_MentorReviewRequests_RequestedBy FOREIGN KEY (RequestedByUserId) REFERENCES dbo.Users(UserId),
    CONSTRAINT FK_MentorReviewRequests_Faculty FOREIGN KEY (AssignedFacultyProfileId) REFERENCES dbo.FacultyProfiles(FacultyProfileId),
    CONSTRAINT CK_MentorReviewRequests_Status CHECK (Status IN ('Pending','Assigned','Completed','Cancelled'))
);
GO
CREATE TABLE dbo.MentorFeedback (
    MentorFeedbackId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_MentorFeedback PRIMARY KEY,
    MentorReviewRequestId BIGINT NOT NULL,
    FacultyProfileId BIGINT NOT NULL,
    Rating TINYINT NULL,
    FeedbackText NVARCHAR(MAX) NOT NULL,
    CreatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_MentorFeedback_CreatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_MentorFeedback_Requests FOREIGN KEY (MentorReviewRequestId) REFERENCES dbo.MentorReviewRequests(MentorReviewRequestId),
    CONSTRAINT FK_MentorFeedback_Faculty FOREIGN KEY (FacultyProfileId) REFERENCES dbo.FacultyProfiles(FacultyProfileId),
    CONSTRAINT CK_MentorFeedback_Rating CHECK (Rating IS NULL OR Rating BETWEEN 1 AND 5)
);
GO

/* 9. Placement drives and recruitment */
CREATE TABLE dbo.PlacementDrives (
    PlacementDriveId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_PlacementDrives PRIMARY KEY,
    CompanyId BIGINT NOT NULL,
    Title NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX) NULL,
    JobRole NVARCHAR(150) NULL,
    EmploymentType NVARCHAR(50) NULL,
    Location NVARCHAR(200) NULL,
    MinimumCGPA DECIMAL(4,2) NULL,
    ApplicationOpensAt DATETIME2(0) NULL,
    ApplicationClosesAt DATETIME2(0) NULL,
    DriveDate DATE NULL,
    Status NVARCHAR(20) NOT NULL CONSTRAINT DF_PlacementDrives_Status DEFAULT ('Draft'),
    CreatedByUserId BIGINT NULL,
    CreatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_PlacementDrives_CreatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_PlacementDrives_Companies FOREIGN KEY (CompanyId) REFERENCES dbo.Companies(CompanyId),
    CONSTRAINT FK_PlacementDrives_CreatedBy FOREIGN KEY (CreatedByUserId) REFERENCES dbo.Users(UserId),
    CONSTRAINT CK_PlacementDrives_CGPA CHECK (MinimumCGPA IS NULL OR MinimumCGPA BETWEEN 0 AND 10),
    CONSTRAINT CK_PlacementDrives_Window CHECK (ApplicationClosesAt IS NULL OR ApplicationOpensAt IS NULL OR ApplicationClosesAt > ApplicationOpensAt),
    CONSTRAINT CK_PlacementDrives_Status CHECK (Status IN ('Draft','Published','Closed','Cancelled','Completed'))
);
GO
CREATE TABLE dbo.DriveDepartments (
    PlacementDriveId BIGINT NOT NULL,
    DepartmentId BIGINT NOT NULL,
    CONSTRAINT PK_DriveDepartments PRIMARY KEY (PlacementDriveId, DepartmentId),
    CONSTRAINT FK_DriveDepartments_Drives FOREIGN KEY (PlacementDriveId) REFERENCES dbo.PlacementDrives(PlacementDriveId),
    CONSTRAINT FK_DriveDepartments_Departments FOREIGN KEY (DepartmentId) REFERENCES dbo.Departments(DepartmentId)
);
GO
CREATE TABLE dbo.DriveCohorts (
    PlacementDriveId BIGINT NOT NULL,
    CohortId BIGINT NOT NULL,
    CONSTRAINT PK_DriveCohorts PRIMARY KEY (PlacementDriveId, CohortId),
    CONSTRAINT FK_DriveCohorts_Drives FOREIGN KEY (PlacementDriveId) REFERENCES dbo.PlacementDrives(PlacementDriveId),
    CONSTRAINT FK_DriveCohorts_Cohorts FOREIGN KEY (CohortId) REFERENCES dbo.Cohorts(CohortId)
);
GO
CREATE TABLE dbo.DriveEligibilityRules (
    DriveEligibilityRuleId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_DriveEligibilityRules PRIMARY KEY,
    PlacementDriveId BIGINT NOT NULL,
    RuleType NVARCHAR(50) NOT NULL,
    Operator NVARCHAR(20) NULL,
    RuleValue NVARCHAR(500) NULL,
    IsMandatory BIT NOT NULL CONSTRAINT DF_DriveEligibilityRules_IsMandatory DEFAULT (1),
    CONSTRAINT FK_DriveEligibilityRules_Drives FOREIGN KEY (PlacementDriveId) REFERENCES dbo.PlacementDrives(PlacementDriveId)
);
GO
CREATE TABLE dbo.DriveApplications (
    DriveApplicationId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_DriveApplications PRIMARY KEY,
    PlacementDriveId BIGINT NOT NULL,
    UserId BIGINT NOT NULL,
    ResumeId BIGINT NULL,
    Status NVARCHAR(30) NOT NULL CONSTRAINT DF_DriveApplications_Status DEFAULT ('Applied'),
    AppliedAt DATETIME2(0) NOT NULL CONSTRAINT DF_DriveApplications_AppliedAt DEFAULT SYSUTCDATETIME(),
    UpdatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_DriveApplications_UpdatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_DriveApplications_Drives FOREIGN KEY (PlacementDriveId) REFERENCES dbo.PlacementDrives(PlacementDriveId),
    CONSTRAINT FK_DriveApplications_Students FOREIGN KEY (UserId) REFERENCES dbo.StudentProfiles(UserId),
    CONSTRAINT FK_DriveApplications_Resumes FOREIGN KEY (ResumeId) REFERENCES dbo.Resumes(ResumeId),
    CONSTRAINT UQ_DriveApplications_DriveUser UNIQUE (PlacementDriveId, UserId),
    CONSTRAINT CK_DriveApplications_Status CHECK (Status IN ('Applied','UnderReview','Shortlisted','Rejected','Withdrawn','Selected'))
);
GO
CREATE TABLE dbo.DriveStages (
    DriveStageId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_DriveStages PRIMARY KEY,
    PlacementDriveId BIGINT NOT NULL,
    StageName NVARCHAR(150) NOT NULL,
    StageType NVARCHAR(50) NOT NULL,
    StageOrder INT NOT NULL,
    IsEliminationStage BIT NOT NULL CONSTRAINT DF_DriveStages_IsElimination DEFAULT (1),
    CONSTRAINT FK_DriveStages_Drives FOREIGN KEY (PlacementDriveId) REFERENCES dbo.PlacementDrives(PlacementDriveId),
    CONSTRAINT UQ_DriveStages_Order UNIQUE (PlacementDriveId, StageOrder)
);
GO
CREATE TABLE dbo.ApplicationStageHistory (
    ApplicationStageHistoryId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_ApplicationStageHistory PRIMARY KEY,
    DriveApplicationId BIGINT NOT NULL,
    DriveStageId BIGINT NOT NULL,
    Status NVARCHAR(30) NOT NULL,
    Notes NVARCHAR(MAX) NULL,
    UpdatedByUserId BIGINT NULL,
    UpdatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_ApplicationStageHistory_UpdatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_ApplicationStageHistory_Applications FOREIGN KEY (DriveApplicationId) REFERENCES dbo.DriveApplications(DriveApplicationId),
    CONSTRAINT FK_ApplicationStageHistory_Stages FOREIGN KEY (DriveStageId) REFERENCES dbo.DriveStages(DriveStageId),
    CONSTRAINT FK_ApplicationStageHistory_UpdatedBy FOREIGN KEY (UpdatedByUserId) REFERENCES dbo.Users(UserId)
);
GO
CREATE TABLE dbo.RecruitmentInterviews (
    RecruitmentInterviewId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_RecruitmentInterviews PRIMARY KEY,
    DriveApplicationId BIGINT NOT NULL,
    DriveStageId BIGINT NOT NULL,
    ScheduledAt DATETIME2(0) NULL,
    MeetingUrl NVARCHAR(1000) NULL,
    InterviewerName NVARCHAR(150) NULL,
    Result NVARCHAR(30) NULL,
    Feedback NVARCHAR(MAX) NULL,
    CreatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_RecruitmentInterviews_CreatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_RecruitmentInterviews_Applications FOREIGN KEY (DriveApplicationId) REFERENCES dbo.DriveApplications(DriveApplicationId),
    CONSTRAINT FK_RecruitmentInterviews_Stages FOREIGN KEY (DriveStageId) REFERENCES dbo.DriveStages(DriveStageId)
);
GO
CREATE TABLE dbo.DriveAssessmentLinks (
    DriveAssessmentLinkId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_DriveAssessmentLinks PRIMARY KEY,
    PlacementDriveId BIGINT NOT NULL,
    DriveStageId BIGINT NULL,
    AssessmentId BIGINT NOT NULL,
    IsRequired BIT NOT NULL CONSTRAINT DF_DriveAssessmentLinks_IsRequired DEFAULT (1),
    CONSTRAINT FK_DriveAssessmentLinks_Drives FOREIGN KEY (PlacementDriveId) REFERENCES dbo.PlacementDrives(PlacementDriveId),
    CONSTRAINT FK_DriveAssessmentLinks_Stages FOREIGN KEY (DriveStageId) REFERENCES dbo.DriveStages(DriveStageId),
    CONSTRAINT FK_DriveAssessmentLinks_Assessments FOREIGN KEY (AssessmentId) REFERENCES dbo.Assessments(AssessmentId)
);
GO
CREATE UNIQUE INDEX UX_DriveAssessmentLinks_Stage ON dbo.DriveAssessmentLinks(PlacementDriveId, DriveStageId, AssessmentId) WHERE DriveStageId IS NOT NULL;
CREATE UNIQUE INDEX UX_DriveAssessmentLinks_NoStage ON dbo.DriveAssessmentLinks(PlacementDriveId, AssessmentId) WHERE DriveStageId IS NULL;
GO

/* 10. Curriculum and readiness */
CREATE TABLE dbo.CurriculumModules (
    CurriculumModuleId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_CurriculumModules PRIMARY KEY,
    ProgramId BIGINT NOT NULL,
    ModuleTitle NVARCHAR(200) NOT NULL,
    SemesterNumber TINYINT NULL,
    Description NVARCHAR(MAX) NULL,
    SortOrder INT NOT NULL CONSTRAINT DF_CurriculumModules_SortOrder DEFAULT (1),
    CONSTRAINT FK_CurriculumModules_Programs FOREIGN KEY (ProgramId) REFERENCES dbo.Programs(ProgramId),
    CONSTRAINT CK_CurriculumModules_Semester CHECK (SemesterNumber IS NULL OR SemesterNumber BETWEEN 1 AND 20)
);
GO
CREATE TABLE dbo.CurriculumModuleTopics (
    CurriculumModuleTopicId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_CurriculumModuleTopics PRIMARY KEY,
    CurriculumModuleId BIGINT NOT NULL,
    TopicTitle NVARCHAR(200) NOT NULL,
    SkillId BIGINT NULL,
    Importance TINYINT NOT NULL CONSTRAINT DF_CurriculumModuleTopics_Importance DEFAULT (3),
    SortOrder INT NOT NULL,
    CONSTRAINT FK_CurriculumModuleTopics_Modules FOREIGN KEY (CurriculumModuleId) REFERENCES dbo.CurriculumModules(CurriculumModuleId),
    CONSTRAINT FK_CurriculumModuleTopics_Skills FOREIGN KEY (SkillId) REFERENCES dbo.Skills(SkillId),
    CONSTRAINT UQ_CurriculumModuleTopics_Sort UNIQUE (CurriculumModuleId, SortOrder),
    CONSTRAINT CK_CurriculumModuleTopics_Importance CHECK (Importance BETWEEN 1 AND 5)
);
GO
CREATE TABLE dbo.CohortCurriculum (
    CohortId BIGINT NOT NULL,
    CurriculumModuleId BIGINT NOT NULL,
    AssignedAt DATETIME2(0) NOT NULL CONSTRAINT DF_CohortCurriculum_AssignedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT PK_CohortCurriculum PRIMARY KEY (CohortId, CurriculumModuleId),
    CONSTRAINT FK_CohortCurriculum_Cohorts FOREIGN KEY (CohortId) REFERENCES dbo.Cohorts(CohortId),
    CONSTRAINT FK_CohortCurriculum_Modules FOREIGN KEY (CurriculumModuleId) REFERENCES dbo.CurriculumModules(CurriculumModuleId)
);
GO
CREATE TABLE dbo.ReadinessSnapshots (
    ReadinessSnapshotId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_ReadinessSnapshots PRIMARY KEY,
    UserId BIGINT NOT NULL,
    OverallReadinessScore DECIMAL(5,2) NOT NULL,
    AssessmentScore DECIMAL(5,2) NULL,
    CodingScore DECIMAL(5,2) NULL,
    ResumeScore DECIMAL(5,2) NULL,
    InterviewScore DECIMAL(5,2) NULL,
    FormulaVersion NVARCHAR(30) NOT NULL,
    CapturedAt DATETIME2(0) NOT NULL CONSTRAINT DF_ReadinessSnapshots_CapturedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_ReadinessSnapshots_Students FOREIGN KEY (UserId) REFERENCES dbo.StudentProfiles(UserId),
    CONSTRAINT CK_ReadinessSnapshots_Scores CHECK (OverallReadinessScore BETWEEN 0 AND 100 AND (AssessmentScore IS NULL OR AssessmentScore BETWEEN 0 AND 100) AND (CodingScore IS NULL OR CodingScore BETWEEN 0 AND 100) AND (ResumeScore IS NULL OR ResumeScore BETWEEN 0 AND 100) AND (InterviewScore IS NULL OR InterviewScore BETWEEN 0 AND 100))
);
GO

/* 11. AI prompt versioning and system configuration */
CREATE TABLE dbo.AiPromptModules (
    AiPromptModuleId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_AiPromptModules PRIMARY KEY,
    ModuleCode NVARCHAR(100) NOT NULL,
    DisplayName NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX) NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_AiPromptModules_IsActive DEFAULT (1),
    CONSTRAINT UQ_AiPromptModules_Code UNIQUE (ModuleCode)
);
GO
CREATE TABLE dbo.AiPromptVersions (
    AiPromptVersionId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_AiPromptVersions PRIMARY KEY,
    AiPromptModuleId BIGINT NOT NULL,
    VersionNumber INT NOT NULL,
    PromptTemplate NVARCHAR(MAX) NOT NULL,
    IsPublished BIT NOT NULL CONSTRAINT DF_AiPromptVersions_IsPublished DEFAULT (0),
    CreatedByUserId BIGINT NULL,
    CreatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_AiPromptVersions_CreatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_AiPromptVersions_Modules FOREIGN KEY (AiPromptModuleId) REFERENCES dbo.AiPromptModules(AiPromptModuleId),
    CONSTRAINT FK_AiPromptVersions_CreatedBy FOREIGN KEY (CreatedByUserId) REFERENCES dbo.Users(UserId),
    CONSTRAINT UQ_AiPromptVersions_ModuleVersion UNIQUE (AiPromptModuleId, VersionNumber),
    CONSTRAINT CK_AiPromptVersions_Version CHECK (VersionNumber > 0)
);
GO
CREATE TABLE dbo.SystemSettings (
    SystemSettingId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_SystemSettings PRIMARY KEY,
    SettingKey NVARCHAR(150) NOT NULL,
    SettingValue NVARCHAR(MAX) NULL,
    ValueType NVARCHAR(30) NOT NULL CONSTRAINT DF_SystemSettings_ValueType DEFAULT ('String'),
    Description NVARCHAR(500) NULL,
    UpdatedByUserId BIGINT NULL,
    UpdatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_SystemSettings_UpdatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT UQ_SystemSettings_Key UNIQUE (SettingKey),
    CONSTRAINT FK_SystemSettings_UpdatedBy FOREIGN KEY (UpdatedByUserId) REFERENCES dbo.Users(UserId)
);
GO
CREATE TABLE dbo.ReportDefinitions (
    ReportDefinitionId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_ReportDefinitions PRIMARY KEY,
    ReportCode NVARCHAR(100) NOT NULL,
    ReportName NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX) NULL,
    ConfigurationJson NVARCHAR(MAX) NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_ReportDefinitions_IsActive DEFAULT (1),
    CONSTRAINT UQ_ReportDefinitions_Code UNIQUE (ReportCode),
    CONSTRAINT CK_ReportDefinitions_Json CHECK (ConfigurationJson IS NULL OR ISJSON(ConfigurationJson) = 1)
);
GO
CREATE TABLE dbo.GeneratedReports (
    GeneratedReportId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_GeneratedReports PRIMARY KEY,
    ReportDefinitionId BIGINT NOT NULL,
    RequestedByUserId BIGINT NOT NULL,
    StorageKey NVARCHAR(500) NULL,
    Status NVARCHAR(20) NOT NULL CONSTRAINT DF_GeneratedReports_Status DEFAULT ('Queued'),
    ParametersJson NVARCHAR(MAX) NULL,
    CreatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_GeneratedReports_CreatedAt DEFAULT SYSUTCDATETIME(),
    CompletedAt DATETIME2(0) NULL,
    CONSTRAINT FK_GeneratedReports_Definitions FOREIGN KEY (ReportDefinitionId) REFERENCES dbo.ReportDefinitions(ReportDefinitionId),
    CONSTRAINT FK_GeneratedReports_Users FOREIGN KEY (RequestedByUserId) REFERENCES dbo.Users(UserId),
    CONSTRAINT CK_GeneratedReports_Status CHECK (Status IN ('Queued','Running','Completed','Failed')),
    CONSTRAINT CK_GeneratedReports_ParametersJson CHECK (ParametersJson IS NULL OR ISJSON(ParametersJson) = 1)
);
GO

/* 12. Support, knowledge base and notifications */
CREATE TABLE dbo.SupportTickets (
    SupportTicketId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_SupportTickets PRIMARY KEY,
    UserId BIGINT NOT NULL,
    Subject NVARCHAR(200) NOT NULL,
    Category NVARCHAR(100) NULL,
    Priority NVARCHAR(20) NOT NULL CONSTRAINT DF_SupportTickets_Priority DEFAULT ('Normal'),
    Status NVARCHAR(20) NOT NULL CONSTRAINT DF_SupportTickets_Status DEFAULT ('Open'),
    AssignedToUserId BIGINT NULL,
    CreatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_SupportTickets_CreatedAt DEFAULT SYSUTCDATETIME(),
    UpdatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_SupportTickets_UpdatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_SupportTickets_Users FOREIGN KEY (UserId) REFERENCES dbo.Users(UserId),
    CONSTRAINT FK_SupportTickets_AssignedTo FOREIGN KEY (AssignedToUserId) REFERENCES dbo.Users(UserId),
    CONSTRAINT CK_SupportTickets_Priority CHECK (Priority IN ('Low','Normal','High','Urgent')),
    CONSTRAINT CK_SupportTickets_Status CHECK (Status IN ('Open','InProgress','WaitingForUser','Resolved','Closed'))
);
GO
CREATE TABLE dbo.SupportTicketMessages (
    SupportTicketMessageId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_SupportTicketMessages PRIMARY KEY,
    SupportTicketId BIGINT NOT NULL,
    SenderUserId BIGINT NOT NULL,
    MessageText NVARCHAR(MAX) NOT NULL,
    IsInternalNote BIT NOT NULL CONSTRAINT DF_SupportTicketMessages_IsInternalNote DEFAULT (0),
    CreatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_SupportTicketMessages_CreatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_SupportTicketMessages_Tickets FOREIGN KEY (SupportTicketId) REFERENCES dbo.SupportTickets(SupportTicketId),
    CONSTRAINT FK_SupportTicketMessages_Senders FOREIGN KEY (SenderUserId) REFERENCES dbo.Users(UserId)
);
GO
CREATE TABLE dbo.KnowledgeArticles (
    KnowledgeArticleId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_KnowledgeArticles PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    Slug NVARCHAR(220) NOT NULL,
    Category NVARCHAR(100) NULL,
    Body NVARCHAR(MAX) NOT NULL,
    Status NVARCHAR(20) NOT NULL CONSTRAINT DF_KnowledgeArticles_Status DEFAULT ('Draft'),
    CreatedByUserId BIGINT NULL,
    UpdatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_KnowledgeArticles_UpdatedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT UQ_KnowledgeArticles_Slug UNIQUE (Slug),
    CONSTRAINT FK_KnowledgeArticles_CreatedBy FOREIGN KEY (CreatedByUserId) REFERENCES dbo.Users(UserId),
    CONSTRAINT CK_KnowledgeArticles_Status CHECK (Status IN ('Draft','Published','Archived'))
);
GO
CREATE TABLE dbo.Notifications (
    NotificationId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Notifications PRIMARY KEY,
    UserId BIGINT NOT NULL,
    Title NVARCHAR(200) NOT NULL,
    MessageText NVARCHAR(MAX) NOT NULL,
    NotificationType NVARCHAR(50) NULL,
    RelatedEntityType NVARCHAR(100) NULL,
    RelatedEntityId NVARCHAR(100) NULL,
    IsRead BIT NOT NULL CONSTRAINT DF_Notifications_IsRead DEFAULT (0),
    CreatedAt DATETIME2(0) NOT NULL CONSTRAINT DF_Notifications_CreatedAt DEFAULT SYSUTCDATETIME(),
    ReadAt DATETIME2(0) NULL,
    CONSTRAINT FK_Notifications_Users FOREIGN KEY (UserId) REFERENCES dbo.Users(UserId)
);
GO

/* 13. Indexes for frequent filtering and joins */
CREATE INDEX IX_UserRoles_RoleId ON dbo.UserRoles(RoleId, UserId);
CREATE INDEX IX_StudentProfiles_Program_Cohort ON dbo.StudentProfiles(ProgramId, CohortId);
CREATE INDEX IX_AssessmentAttempts_User_Submitted ON dbo.AssessmentAttempts(UserId, SubmittedAt DESC);
CREATE INDEX IX_AssessmentAttempts_Assessment_Status ON dbo.AssessmentAttempts(AssessmentId, Status);
CREATE INDEX IX_CodeSubmissions_User_Submitted ON dbo.CodeSubmissions(UserId, SubmittedAt DESC);
CREATE INDEX IX_ResumeAnalysisRuns_Resume_Created ON dbo.ResumeAnalysisRuns(ResumeId, CreatedAt DESC);
CREATE INDEX IX_SkillGapAnalyses_User_Created ON dbo.SkillGapAnalyses(UserId, CreatedAt DESC);
CREATE INDEX IX_MockInterviewSessions_User_Created ON dbo.MockInterviewSessions(UserId, CreatedAt DESC);
CREATE INDEX IX_DriveApplications_User_Status ON dbo.DriveApplications(UserId, Status);
CREATE INDEX IX_DriveApplications_Drive_Status ON dbo.DriveApplications(PlacementDriveId, Status);
CREATE INDEX IX_Notifications_User_Read_Created ON dbo.Notifications(UserId, IsRead, CreatedAt DESC);
CREATE INDEX IX_AuditLogs_CreatedAt ON dbo.AuditLogs(CreatedAt DESC);
CREATE INDEX IX_SupportTickets_Status_Updated ON dbo.SupportTickets(Status, UpdatedAt DESC);
GO

/* 14. Seed core roles */
IF NOT EXISTS (SELECT 1 FROM dbo.Roles WHERE RoleName = N'Student')
    INSERT dbo.Roles (RoleName, Description) VALUES (N'Student', N'Student access');
IF NOT EXISTS (SELECT 1 FROM dbo.Roles WHERE RoleName = N'Faculty')
    INSERT dbo.Roles (RoleName, Description) VALUES (N'Faculty', N'Faculty and mentor access');
IF NOT EXISTS (SELECT 1 FROM dbo.Roles WHERE RoleName = N'Admin')
    INSERT dbo.Roles (RoleName, Description) VALUES (N'Admin', N'Administrative access');
GO

/* Important implementation notes:
   - PasswordHash, CodeHash and TokenHash must contain hashes generated by a secure library;
     never store plaintext passwords, OTPs or reset tokens.
   - Keep uploaded files outside the public web root; store opaque StorageKey values here.
   - Use parameterized SQL / stored procedures and server-side authorization on every request.
   - Validate that AttemptAnswers.SelectedQuestionOptionId belongs to the question assigned by
     AssessmentQuestions; simple foreign keys cannot enforce this cross-table rule.
   - Validate that DriveStages used by an application belong to that application's drive.
   - Validate that a Cohort's ProgramId matches a StudentProfile's ProgramId.
   - Validate that a CodingTestCase belongs to the CodingProblem submitted to the runner.
   - Use UTC for timestamps. Add retention policies for audit logs, transcripts, submissions and files.
   - SQL Server filtered indexes enforce one active academic year, one primary resume per student,
     and one current evaluation per mock interview session.
   - ASP.NET authorization must verify the user's role and corresponding StudentProfiles or
     FacultyProfiles record; a role assignment alone does not create a profile.
*/

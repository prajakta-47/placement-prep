# Placement Prep — AI-Powered Placement Preparation Platform

Placement Prep is an AI-powered placement preparation platform designed to help students become job-ready through structured practice, personalized feedback, and placement readiness tracking. It brings together student preparation, faculty monitoring, and administrative management in one platform.

The project is being developed as part of **Enterprise Computing Through .NET Framework (CE545)** using ASP.NET Web Forms and C#.

## Project Objectives

- Provide a centralized platform for placement preparation.
- Help students improve aptitude, reasoning, coding, and interview skills.
- Support resume analysis and identify skill gaps.
- Provide assessment results, performance insights, and personalized improvement recommendations.
- Enable faculty to monitor student progress and generate reports.
- Allow administrators to manage users, companies, question banks, assessments, and platform information.

## Platform Modules

### 1. Student Portal

Designed to help students prepare for placement opportunities through guided learning and practice.

- **Student Onboarding:** Academic background, target companies, and skill assessment.
- **Student Dashboard:** Preparation overview, scheduled tests, progress tracking, and upcoming deadlines.
- **Aptitude Practice:** Quantitative aptitude, logical reasoning, verbal ability, and data interpretation.
- **Coding Practice:** Coding problems, online coding environment, and submission feedback.
- **Resume Analyzer:** Resume upload, ATS-oriented evaluation, skill extraction, and improvement suggestions.
- **AI Mock Interviews:** Technical, behavioral, system design, and business case interview preparation.
- **Test Results and Review:** Scores, accuracy, question breakdown, and step-by-step explanations.
- **Feedback Hub:** Performance feedback, strengths, improvement areas, and review reports.
- **Placement Readiness:** Skill-gap identification and a structured improvement roadmap.

### 2. Faculty Portal

Designed to help faculty members and placement coordinators monitor student preparation and placement readiness.

- Faculty dashboard and batch-level overview.
- Student management and individual student profiles.
- Student performance and readiness tracking.
- Curriculum and assessment management.
- Company directory and placement-related information.
- Batch reports and analytics.
- Test scheduling and announcements.
- Report generation and export.
- System activity and administrative insights.

### 3. Admin Portal

Designed to provide centralized management and oversight of the platform.

- Admin dashboard and platform overview.
- User management.
- Student management.
- Question bank management, including aptitude, technical, and coding questions.
- Test and assessment management.
- Company management and placement drive information.
- Reports and analytics.
- AI configuration and prompt management.
- System logs and activity monitoring.

## Technology Stack

| Component | Technology |
|---|---|
| Frontend | HTML, CSS,|
| Backend | C# |
| Web Framework | ASP.NET Web Forms |
| Runtime | .NET Framework 4.7.2 |
| Database Design | SQL Server |
| Development Environment | Visual Studio |
| Build Tool | MSBuild |
| Version Control | Git and GitHub |

## Current .NET Implementation

The current implementation focuses on building the web application interface and implementing server-side functionality using C#.

The development scope includes:

- Reusable ASP.NET Web Forms master pages.
- Shared navigation and consistent page layouts.
- Separate portal layouts for relevant user roles.
- Server-side event handling and application logic.
- C# collections for managing in-memory data.
- SQL Server schema scripts for database design.
- UI styling and interactive behavior using CSS and JavaScript.

**Database Status:** The current development phase does not use a live database connection. Database-dependent functionality, ADO.NET integration, and persistent data storage are not yet part of this implementation.

**AI Status:** AI-powered resume analysis, mock interviews, and personalized feedback describe the intended platform capabilities. They should not be considered implemented unless the corresponding integrations are present in the codebase.

## Getting Started

### Prerequisites

- Windows operating system.
- Visual Studio with ASP.NET and .NET Framework development support.
- .NET Framework 4.7.2 Developer Pack.
- Git.

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/prajakta-47/placement-prep.git
   ```

2. Navigate to the cloned project directory.

3. Open the solution file (`.sln`) in Visual Studio.

4. Restore or verify the required project references.

5. Set the appropriate `.aspx` page as the startup page.

6. Build the application using **Build → Build Solution**.

7. Run the application using IIS Express.

## Learning Outcomes

- ASP.NET Web Forms application development.
- C# programming and server-side event handling.
- Generic collections such as `Dictionary<TKey, TValue>`.
- Master pages and reusable UI components.
- Multi-role application design.
- SQL Server schema design.
- Git-based version control and collaborative development.

## Future Enhancements

- Integrate SQL Server for persistent data storage.
- Implement authentication and role-based authorization.
- Connect student, faculty, and admin workflows.
- Implement assessment creation, test evaluation, and performance tracking.
- Integrate resume parsing and AI-based feedback services.
- Add coding evaluation and mock interview integrations.
- Develop comprehensive reporting and placement analytics.

## Project Information

- **Project Name:** Placement Prep
- **Course:** Enterprise Computing Through .NET Framework (CE545)
- **Framework:** ASP.NET Web Forms
- **.NET Version:** .NET Framework 4.7.2

## Contributors

Developed as an academic project focused on placement preparation, web application development, and .NET technologies.

## License

This project is intended for academic and educational purposes. A specific open-source license can be added if the project is distributed publicly.


## APIS USED 
Gemini API
Used for AI-generated resume suggestions, interview questions, and feedback. Availability and free usage limits depend on the model and current terms.

Judge0 API
Executes submitted code in a controlled environment and returns output, errors, and execution details. It can support your Coding Problems module.

Chart.js
Displays graphs for student progress and skill gap analysis. It is a JavaScript library, not an external API.

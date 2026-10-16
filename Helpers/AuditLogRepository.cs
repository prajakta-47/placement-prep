using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;

namespace PlacementPrep.Helpers
{
    public class AuditLogSearchResult
    {
        public List<AuditLogItem> Items { get; set; }
        public int TotalCount { get; set; }
        public int PageIndex { get; set; }
        public int PageSize { get; set; }
        public int TotalPages { get; set; }
    }

    public class AuditLogRepository
    {
        private static readonly object SyncLock = new object();
        private static List<AuditLogItem> _logs;
        private static int _nextId = 1000;

        static AuditLogRepository()
        {
            SeedSampleLogs();
        }

        public List<string> GetModules()
        {
            return new List<string>
            {
                "User Management",
                "Test Engine",
                "Proctoring",
                "Company Management",
                "Student Operations"
            };
        }

        public List<string> GetSeverities()
        {
            return new List<string>
            {
                "Info",
                "Warning",
                "Security Alert",
                "Error"
            };
        }

        public AuditLogSearchResult Search(string query, string module, string severity, DateTime? startDate, DateTime? endDate, int pageIndex, int pageSize)
        {
            lock (SyncLock)
            {
                var q = _logs.AsQueryable();

                if (!string.IsNullOrWhiteSpace(query))
                {
                    var term = query.Trim();
                    q = q.Where(l =>
                        (l.Message != null && l.Message.IndexOf(term, StringComparison.OrdinalIgnoreCase) >= 0) ||
                        (l.ActorName != null && l.ActorName.IndexOf(term, StringComparison.OrdinalIgnoreCase) >= 0) ||
                        (l.TargetEntity != null && l.TargetEntity.IndexOf(term, StringComparison.OrdinalIgnoreCase) >= 0) ||
                        (l.IpAddress != null && l.IpAddress.IndexOf(term, StringComparison.OrdinalIgnoreCase) >= 0) ||
                        (l.Action != null && l.Action.IndexOf(term, StringComparison.OrdinalIgnoreCase) >= 0));
                }

                if (!string.IsNullOrWhiteSpace(module) && !string.Equals(module, "All", StringComparison.OrdinalIgnoreCase))
                {
                    q = q.Where(l => string.Equals(l.Module, module.Trim(), StringComparison.OrdinalIgnoreCase));
                }

                if (!string.IsNullOrWhiteSpace(severity) && !string.Equals(severity, "All", StringComparison.OrdinalIgnoreCase))
                {
                    q = q.Where(l => string.Equals(l.Severity, severity.Trim(), StringComparison.OrdinalIgnoreCase));
                }

                if (startDate.HasValue)
                {
                    q = q.Where(l => l.Timestamp >= startDate.Value.Date);
                }

                if (endDate.HasValue)
                {
                    var endOfDay = endDate.Value.Date.AddDays(1).AddTicks(-1);
                    q = q.Where(l => l.Timestamp <= endOfDay);
                }

                var list = q.OrderByDescending(l => l.Timestamp).ToList();

                var total = list.Count;
                var totalPages = (int)Math.Ceiling((double)total / pageSize);
                if (totalPages == 0) totalPages = 1;
                if (pageIndex < 1) pageIndex = 1;
                if (pageIndex > totalPages) pageIndex = totalPages;

                var pageItems = list.Skip((pageIndex - 1) * pageSize).Take(pageSize).ToList();

                return new AuditLogSearchResult
                {
                    Items = pageItems,
                    TotalCount = total,
                    PageIndex = pageIndex,
                    PageSize = pageSize,
                    TotalPages = totalPages
                };
            }
        }

        public AuditLogItem GetById(int eventId)
        {
            lock (SyncLock)
            {
                var log = _logs.FirstOrDefault(l => l.EventId == eventId);
                return log == null ? null : CloneLog(log);
            }
        }

        public void AddLog(string actorName, string actorRole, string module, string action, string target, string severity, string ip, string message, string detailsJson = null)
        {
            lock (SyncLock)
            {
                var item = new AuditLogItem
                {
                    EventId = ++_nextId,
                    Timestamp = DateTime.UtcNow,
                    ActorName = actorName ?? "System",
                    ActorRole = actorRole ?? "Admin",
                    Module = module ?? "General",
                    Action = action ?? "AUDIT",
                    TargetEntity = target ?? "System",
                    Severity = severity ?? "Info",
                    IpAddress = ip ?? "127.0.0.1",
                    Message = message ?? string.Empty,
                    DetailsJson = detailsJson ?? "{}"
                };

                _logs.Insert(0, item);
            }
        }

        public void ClearLogs()
        {
            lock (SyncLock)
            {
                _logs.Clear();
                // Retain one system reboot notice
                AddLog("System Supervisor", "Root Admin", "System Operations", "LOGS_CLEARED", "AuditRepository", "Info", "127.0.0.1", "Audit trail logs cleared by administrator (In-Memory Demo Store).");
            }
        }

        public string ExportToCsv(string query, string module, string severity)
        {
            lock (SyncLock)
            {
                var result = Search(query, module, severity, null, null, 1, 10000);
                var sb = new StringBuilder();
                sb.AppendLine("EventId,Timestamp,ActorName,ActorRole,Module,Action,TargetEntity,Severity,IpAddress,Message");

                foreach (var l in result.Items)
                {
                    sb.AppendFormat(CultureInfo.InvariantCulture,
                        "\"{0}\",\"{1:yyyy-MM-dd HH:mm:ss}\",\"{2}\",\"{3}\",\"{4}\",\"{5}\",\"{6}\",\"{7}\",\"{8}\",\"{9}\"\r\n",
                        l.EventId,
                        l.Timestamp,
                        EscapeCsv(l.ActorName),
                        EscapeCsv(l.ActorRole),
                        EscapeCsv(l.Module),
                        EscapeCsv(l.Action),
                        EscapeCsv(l.TargetEntity),
                        EscapeCsv(l.Severity),
                        EscapeCsv(l.IpAddress),
                        EscapeCsv(l.Message));
                }

                return sb.ToString();
            }
        }

        private static string EscapeCsv(string s)
        {
            if (string.IsNullOrEmpty(s)) return string.Empty;
            return s.Replace("\"", "\"\"");
        }

        private static AuditLogItem CloneLog(AuditLogItem l)
        {
            return new AuditLogItem
            {
                EventId = l.EventId,
                Timestamp = l.Timestamp,
                ActorName = l.ActorName,
                ActorRole = l.ActorRole,
                Module = l.Module,
                Action = l.Action,
                TargetEntity = l.TargetEntity,
                Severity = l.Severity,
                IpAddress = l.IpAddress,
                Message = l.Message,
                DetailsJson = l.DetailsJson
            };
        }

        private static void SeedSampleLogs()
        {
            _logs = new List<AuditLogItem>
            {
                new AuditLogItem
                {
                    EventId = 1001,
                    Timestamp = DateTime.UtcNow.AddMinutes(-5),
                    ActorName = "Global Admin",
                    ActorRole = "Superuser",
                    Module = "Test Engine",
                    Action = "ASSESSMENT_PUBLISHED",
                    TargetEntity = "Amazon AWS SDE Assessment (Code: TEST-2025-003)",
                    Severity = "Info",
                    IpAddress = "192.168.1.104",
                    Message = "Online assessment published with 45 questions and full lockdown proctoring enabled.",
                    DetailsJson = "{\"testId\": 103, \"durationMinutes\": 90, \"proctoringLevel\": \"High\", \"totalMarks\": 100}"
                },
                new AuditLogItem
                {
                    EventId = 1002,
                    Timestamp = DateTime.UtcNow.AddMinutes(-18),
                    ActorName = "Proctoring Telemetry Agent",
                    ActorRole = "AI Sentinel",
                    Module = "Proctoring",
                    Action = "LOCKDOWN_VIOLATION",
                    TargetEntity = "Candidate EN-2022-CS082 (Rohan Verma)",
                    Severity = "Warning",
                    IpAddress = "10.0.4.52",
                    Message = "Dual monitor disconnection / secondary display focus change detected during assessment session.",
                    DetailsJson = "{\"testId\": 101, \"candidate\": \"EN-2022-CS082\", \"violationType\": \"Display_Focus_Loss\", \"durationSec\": 4}"
                },
                new AuditLogItem
                {
                    EventId = 1003,
                    Timestamp = DateTime.UtcNow.AddMinutes(-42),
                    ActorName = "Security Gateway",
                    ActorRole = "System Daemon",
                    Module = "User Management",
                    Action = "AUTH_BRUTE_FORCE_BLOCKED",
                    TargetEntity = "Account: faculty.ec@univ.edu",
                    Severity = "Security Alert",
                    IpAddress = "203.0.113.88",
                    Message = "Five consecutive invalid password attempts from unrecognized external IP address. Account temporarily throttled.",
                    DetailsJson = "{\"attemptCount\": 5, \"sourceIp\": \"203.0.113.88\", \"userAgent\": \"Mozilla/5.0 Unknown Automated Scanner\"}"
                },
                new AuditLogItem
                {
                    EventId = 1004,
                    Timestamp = DateTime.UtcNow.AddHours(-2),
                    ActorName = "Placement Coordinator",
                    ActorRole = "Admin",
                    Module = "Company Management",
                    Action = "DRIVE_SCHEDULED",
                    TargetEntity = "Google India (SDE-I Drive DRV-2025-001)",
                    Severity = "Info",
                    IpAddress = "192.168.1.112",
                    Message = "New campus placement drive scheduled for Batch 2025 with minimum CGPA cutoff set to 8.00.",
                    DetailsJson = "{\"driveCode\": \"DRV-2025-001\", \"company\": \"Google\", \"openings\": 12, \"minCgpa\": 8.0}"
                },
                new AuditLogItem
                {
                    EventId = 1005,
                    Timestamp = DateTime.UtcNow.AddHours(-3).AddMinutes(-12),
                    ActorName = "Placement Cell Admin",
                    ActorRole = "Admin",
                    Module = "Student Operations",
                    Action = "OFFER_EXTENDED_VERIFIED",
                    TargetEntity = "Student EN-2022-CS003 (Divya Nair)",
                    Severity = "Info",
                    IpAddress = "192.168.1.104",
                    Message = "Offer of 32.0 LPA from Google confirmed; placement status transitioned to 'Placed'.",
                    DetailsJson = "{\"studentId\": 9, \"company\": \"Google\", \"packageLpa\": 32.0, \"status\": \"Placed\"}"
                },
                new AuditLogItem
                {
                    EventId = 1006,
                    Timestamp = DateTime.UtcNow.AddHours(-5),
                    ActorName = "Global Admin",
                    ActorRole = "Superuser",
                    Module = "User Management",
                    Action = "ROLE_MODIFIED",
                    TargetEntity = "User: prof.arun@faculty.univ.edu",
                    Severity = "Info",
                    IpAddress = "192.168.1.104",
                    Message = "User permission role elevated from Student Advisor to Test Coordinator.",
                    DetailsJson = "{\"userId\": 205, \"oldRole\": \"Faculty Advisor\", \"newRole\": \"Test Coordinator\"}"
                },
                new AuditLogItem
                {
                    EventId = 1007,
                    Timestamp = DateTime.UtcNow.AddHours(-7),
                    ActorName = "Assessment Proctor Service",
                    ActorRole = "System Daemon",
                    Module = "Proctoring",
                    Action = "WEBCAM_OCCLUSION_ALERT",
                    TargetEntity = "Candidate EN-2022-IT088 (Arjun Das)",
                    Severity = "Warning",
                    IpAddress = "10.0.4.95",
                    Message = "Candidate facial verification confidence dropped below 60% threshold for >30 seconds.",
                    DetailsJson = "{\"testId\": 102, \"confidence\": 0.42, \"intervalSeconds\": 35, \"frameCapture\": \"simulated_frame_04.jpg\"}"
                },
                new AuditLogItem
                {
                    EventId = 1008,
                    Timestamp = DateTime.UtcNow.AddHours(-11),
                    ActorName = "Automated Backup Daemon",
                    ActorRole = "System Daemon",
                    Module = "System Operations",
                    Action = "SNAPSHOT_COMMITTED",
                    TargetEntity = "Repository State Snapshot",
                    Severity = "Info",
                    IpAddress = "127.0.0.1",
                    Message = "Automated in-memory cache state validated and committed to snapshot persistence.",
                    DetailsJson = "{\"recordsCached\": 8192, \"status\": \"OK\"}"
                },
                new AuditLogItem
                {
                    EventId = 1009,
                    Timestamp = DateTime.UtcNow.AddDays(-1),
                    ActorName = "Web Server Runtime",
                    ActorRole = "System Daemon",
                    Module = "Test Engine",
                    Action = "TEST_SESSION_TIMEOUT_EXCEPTION",
                    TargetEntity = "Session #49281",
                    Severity = "Error",
                    IpAddress = "192.168.1.1",
                    Message = "Candidate session heartbeat timed out before final submission payload acknowledgement.",
                    DetailsJson = "{\"sessionId\": 49281, \"cause\": \"NetworkDrop\", \"retryCount\": 3}"
                },
                new AuditLogItem
                {
                    EventId = 1010,
                    Timestamp = DateTime.UtcNow.AddDays(-2),
                    ActorName = "Global Admin",
                    ActorRole = "Superuser",
                    Module = "Company Management",
                    Action = "MOU_RENEWED",
                    TargetEntity = "Corporate Partner: Microsoft India",
                    Severity = "Info",
                    IpAddress = "192.168.1.104",
                    Message = "Campus recruitment MoU renewed for 2024-2026 cycle; Tier 1 (Dream) designation reaffirmed.",
                    DetailsJson = "{\"companyId\": 2, \"tier\": \"Tier 1 (Dream)\", \"renewalYears\": 2}"
                }
            };
        }
    }
}

using System;

namespace PlacementPrep.Helpers
{
    public class AuditLogItem
    {
        public int EventId { get; set; }
        public DateTime Timestamp { get; set; }
        public string ActorName { get; set; }
        public string ActorRole { get; set; }
        public string Module { get; set; } // User Management, Test Engine, Proctoring, Company Management, Student Operations
        public string Action { get; set; }
        public string TargetEntity { get; set; }
        public string Severity { get; set; } // Info, Warning, Security Alert, Error
        public string IpAddress { get; set; }
        public string Message { get; set; }
        public string DetailsJson { get; set; }

        public string SeverityBadgeClass
        {
            get
            {
                switch ((Severity ?? string.Empty).Trim().ToLowerInvariant())
                {
                    case "error":
                    case "security alert":
                        return "status-pill status-suspended";
                    case "warning":
                        return "status-pill status-process";
                    default:
                        return "status-pill status-active";
                }
            }
        }
    }
}

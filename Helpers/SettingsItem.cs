using System;

namespace PlacementPrep.Helpers
{
    public class PlatformSettingsItem
    {
        // Institutional profile
        public string UniversityName { get; set; } = "National Institute of Technology & Engineering";
        public string PlacementCellEmail { get; set; } = "placements@univ.edu";
        public string CampusAddress { get; set; } = "Technology Innovation Campus, Sector 4, Silicon Boulevard, Bangalore - 560100";
        public string AccreditationStatus { get; set; } = "NAAC A++ Accredited &middot; NIRF Top 25 Ranked";
        public string DirectorName { get; set; } = "Dr. S. K. Narayanan (Dean of Placements)";

        // Academic season
        public string ActivePlacementYear { get; set; } = "2024 - 2025";
        public int TargetGraduationBatch { get; set; } = 2025;
        public double DefaultMinCgpaThreshold { get; set; } = 7.00;

        // Assessment defaults
        public int DefaultTestDurationMinutes { get; set; } = 60;
        public double NegativeMarkingFactor { get; set; } = 0.25;
        public int TabSwitchLimit { get; set; } = 3;
        public string WebcamProctoringPreference { get; set; } = "AI Face & Audio Sentinel Verification";
        public bool FullscreenLockdownEnabled { get; set; } = true;

        // Notification preferences
        public bool NotifyDriveAnnouncements { get; set; } = true;
        public bool NotifyCandidateShortlists { get; set; } = true;
        public bool NotifyInterviewInvites { get; set; } = true;
        public bool NotifyDailyAdminDigest { get; set; } = true;

        public DateTime LastUpdated { get; set; } = DateTime.UtcNow;
    }
}

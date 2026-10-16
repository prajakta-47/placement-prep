using System;

namespace PlacementPrep.Helpers
{
    public class SettingsRepository
    {
        private static readonly object SyncLock = new object();
        private static PlatformSettingsItem _settings;

        static SettingsRepository()
        {
            _settings = new PlatformSettingsItem();
        }

        public PlatformSettingsItem GetSettings()
        {
            lock (SyncLock)
            {
                return CloneSettings(_settings);
            }
        }

        public void SaveSettings(PlatformSettingsItem item)
        {
            if (item == null) throw new ArgumentNullException(nameof(item));

            lock (SyncLock)
            {
                _settings = CloneSettings(item);
                _settings.LastUpdated = DateTime.UtcNow;
            }
        }

        private static PlatformSettingsItem CloneSettings(PlatformSettingsItem s)
        {
            return new PlatformSettingsItem
            {
                UniversityName = s.UniversityName,
                PlacementCellEmail = s.PlacementCellEmail,
                CampusAddress = s.CampusAddress,
                AccreditationStatus = s.AccreditationStatus,
                DirectorName = s.DirectorName,
                ActivePlacementYear = s.ActivePlacementYear,
                TargetGraduationBatch = s.TargetGraduationBatch,
                DefaultMinCgpaThreshold = s.DefaultMinCgpaThreshold,
                DefaultTestDurationMinutes = s.DefaultTestDurationMinutes,
                NegativeMarkingFactor = s.NegativeMarkingFactor,
                TabSwitchLimit = s.TabSwitchLimit,
                WebcamProctoringPreference = s.WebcamProctoringPreference,
                FullscreenLockdownEnabled = s.FullscreenLockdownEnabled,
                NotifyDriveAnnouncements = s.NotifyDriveAnnouncements,
                NotifyCandidateShortlists = s.NotifyCandidateShortlists,
                NotifyInterviewInvites = s.NotifyInterviewInvites,
                NotifyDailyAdminDigest = s.NotifyDailyAdminDigest,
                LastUpdated = s.LastUpdated
            };
        }
    }
}

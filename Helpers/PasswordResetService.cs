using System;
using System.Collections.Concurrent;
using System.Security.Cryptography;
using System.Text;

namespace PlacementPrep.Helpers
{
    /// <summary>
    /// Represents an issued password-reset token with cryptographic security,
    /// expiration timestamp, and single-use tracking.
    /// </summary>
    public class PasswordResetToken
    {
        public string Token { get; set; }
        public string Email { get; set; }
        public DateTime CreatedAtUtc { get; set; }
        public DateTime ExpiresAtUtc { get; set; }
        public bool IsUsed { get; set; }
    }

    /// <summary>
    /// Service managing password reset tokens, cryptographic randomness,
    /// validation, and password-reset orchestration.
    /// </summary>
    public static class PasswordResetService
    {
        private static readonly ConcurrentDictionary<string, PasswordResetToken> ActiveTokens =
            new ConcurrentDictionary<string, PasswordResetToken>(StringComparer.Ordinal);

        /// <summary>
        /// Indicates whether persistent SQL Server database authentication is connected.
        /// Currently false, adhering to the in-memory architecture constraint.
        /// </summary>
        public static bool IsDatabasePersistenceAvailable()
        {
            return false;
        }

        /// <summary>
        /// Generates a cryptographically secure, high-entropy, URL-safe random token.
        /// </summary>
        public static string GenerateCryptographicToken(int byteLength = 32)
        {
            var randomBytes = new byte[byteLength];
            using (var rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(randomBytes);
            }

            var sb = new StringBuilder(byteLength * 2);
            foreach (var b in randomBytes)
            {
                sb.Append(b.ToString("x2"));
            }

            return sb.ToString();
        }

        /// <summary>
        /// Issues a single-use, time-limited password reset token for the given email address.
        /// </summary>
        public static PasswordResetToken IssueResetToken(string email, int validityMinutes = 30)
        {
            if (string.IsNullOrWhiteSpace(email))
            {
                throw new ArgumentException("Email address is required.", nameof(email));
            }

            var cleanEmail = email.Trim().ToLowerInvariant();
            var tokenString = GenerateCryptographicToken(32);

            var resetToken = new PasswordResetToken
            {
                Token = tokenString,
                Email = cleanEmail,
                CreatedAtUtc = DateTime.UtcNow,
                ExpiresAtUtc = DateTime.UtcNow.AddMinutes(validityMinutes),
                IsUsed = false
            };

            ActiveTokens[tokenString] = resetToken;
            return resetToken;
        }

        /// <summary>
        /// Validates whether a token exists, has not expired, and has not already been used.
        /// </summary>
        public static bool ValidateToken(string token, out PasswordResetToken resetToken, out string validationError)
        {
            resetToken = null;
            validationError = null;

            if (string.IsNullOrWhiteSpace(token))
            {
                validationError = "Password reset token is missing. Please use the link provided in your reset email.";
                return false;
            }

            if (!ActiveTokens.TryGetValue(token.Trim(), out resetToken) || resetToken == null)
            {
                validationError = "This password reset token is invalid or has expired. Please submit a new request.";
                return false;
            }

            if (resetToken.IsUsed)
            {
                validationError = "This password reset token has already been used. Tokens are single-use only. Please submit a new request.";
                return false;
            }

            if (DateTime.UtcNow > resetToken.ExpiresAtUtc)
            {
                validationError = "This password reset token has expired. Password reset links are valid for 30 minutes. Please submit a new request.";
                return false;
            }

            return true;
        }

        /// <summary>
        /// Executes the password reset: validates token, enforces complexity, hashes the password,
        /// and marks the token as used.
        /// </summary>
        public static bool ExecutePasswordReset(string token, string newPassword, out string errorMessage)
        {
            errorMessage = null;

            PasswordResetToken resetToken;
            if (!ValidateToken(token, out resetToken, out errorMessage))
            {
                return false;
            }

            if (!PasswordHelper.MeetsComplexity(newPassword, out errorMessage))
            {
                return false;
            }

            // Securely hash the new password using the existing Crypto PBKDF2 implementation
            var passwordHash = PasswordHelper.HashPassword(newPassword);

            // Mark token as used immediately to prevent replay attacks
            resetToken.IsUsed = true;

            // In-memory update if the user exists in UserRepository
            var userRepo = new UserRepository();
            var user = userRepo.GetByEmail(resetToken.Email);
            if (user != null)
            {
                userRepo.ResetPasswordHash(user.UserId, passwordHash);
            }

            return true;
        }
    }
}

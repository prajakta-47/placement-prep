using System;
using System.Security.Cryptography;
using System.Text;
using System.Web.Helpers;

namespace PlacementPrep.Helpers
{
    /// <summary>
    /// Password hashing helpers. Never store or return plaintext passwords.
    /// </summary>
    public static class PasswordHelper
    {
        public const string DefaultTempPassword = "Welcome@123";

        public static string HashPassword(string plaintextPassword)
        {
            if (string.IsNullOrWhiteSpace(plaintextPassword))
            {
                throw new ArgumentException("Password is required.", nameof(plaintextPassword));
            }

            return Crypto.HashPassword(plaintextPassword);
        }

        public static bool VerifyPassword(string plaintextPassword, string passwordHash)
        {
            if (string.IsNullOrEmpty(plaintextPassword) || string.IsNullOrEmpty(passwordHash))
            {
                return false;
            }

            try
            {
                return Crypto.VerifyHashedPassword(passwordHash, plaintextPassword);
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// Generates a one-time temporary password for admin reset / CSV import.
        /// The caller must hash before persisting and may show the plaintext once.
        /// </summary>
        public static string GenerateTemporaryPassword(int length = 12)
        {
            const string alphabet = "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz23456789!@#$";
            var bytes = new byte[length];
            using (var rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(bytes);
            }

            var sb = new StringBuilder(length);
            for (var i = 0; i < length; i++)
            {
                sb.Append(alphabet[bytes[i] % alphabet.Length]);
            }

            return sb.ToString();
        }

        public static bool MeetsComplexity(string password, out string errorMessage)
        {
            errorMessage = null;
            if (string.IsNullOrEmpty(password) || password.Length < 8)
            {
                errorMessage = "Password must be at least 8 characters.";
                return false;
            }

            var hasUpper = false;
            var hasLower = false;
            var hasDigit = false;
            var hasSpecial = false;
            foreach (var ch in password)
            {
                if (char.IsUpper(ch)) hasUpper = true;
                else if (char.IsLower(ch)) hasLower = true;
                else if (char.IsDigit(ch)) hasDigit = true;
                else if (!char.IsLetterOrDigit(ch)) hasSpecial = true;
            }

            if (!hasUpper || !hasLower || !hasDigit || !hasSpecial)
            {
                errorMessage = "Password must be at least 8 characters and include an uppercase letter, a lowercase letter, a number, and a special character.";
                return false;
            }

            return true;
        }
    }
}

using System.Configuration;
using System.Data.SqlClient;

namespace PlacementPrep.Helpers
{
    /// <summary>
    /// Central ADO.NET connection factory. Connection string name: PlacementPrepDb.
    /// </summary>
    public static class DbHelper
    {
        public const string ConnectionStringName = "PlacementPrepDb";

        public static string GetConnectionString()
        {
            var settings = ConfigurationManager.ConnectionStrings[ConnectionStringName];
            if (settings == null || string.IsNullOrWhiteSpace(settings.ConnectionString))
            {
                throw new ConfigurationErrorsException(
                    "Connection string 'PlacementPrepDb' is missing from Web.config.");
            }

            return settings.ConnectionString;
        }

        public static SqlConnection CreateConnection()
        {
            return new SqlConnection(GetConnectionString());
        }
    }
}

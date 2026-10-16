using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace PlacementPrep.Models
{
    /// <summary>
    /// Centralized Database Helper for executing ADO.NET CRUD operations.
    /// Uses parameterized queries to prevent SQL Injection.
    /// </summary>
    public static class DbHelper
    {
        private static readonly string ConnectionStringName = "PlacementPrepDB";

        /// <summary>
        /// Retrieves the active connection string from Web.config.
        /// </summary>
        public static string GetConnectionString()
        {
            var connStr = ConfigurationManager.ConnectionStrings[ConnectionStringName];
            if (connStr == null || string.IsNullOrWhiteSpace(connStr.ConnectionString))
            {
                // Fallback default for Visual Studio LocalDB
                return @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=PlacementPrepDB;Integrated Security=True;Connect Timeout=30;";
            }
            return connStr.ConnectionString;
        }

        /// <summary>
        /// Creates and opens a new SqlConnection.
        /// </summary>
        public static SqlConnection GetOpenConnection()
        {
            var conn = new SqlConnection(GetConnectionString());
            conn.Open();
            return conn;
        }

        /// <summary>
        /// Tests the database connection and returns diagnostic status.
        /// </summary>
        public static bool TestConnection(out string message)
        {
            try
            {
                using (var conn = GetOpenConnection())
                {
                    message = "Connection successful to database: " + conn.Database;
                    return true;
                }
            }
            catch (Exception ex)
            {
                message = "Connection failed: " + ex.Message;
                return false;
            }
        }

        /// <summary>
        /// Executes a SELECT query (Read operation) and returns a DataTable.
        /// </summary>
        public static DataTable ExecuteQuery(string query, SqlParameter[] parameters = null, CommandType commandType = CommandType.Text)
        {
            var dt = new DataTable();
            using (var conn = new SqlConnection(GetConnectionString()))
            using (var cmd = new SqlCommand(query, conn))
            {
                cmd.CommandType = commandType;
                if (parameters != null && parameters.Length > 0)
                {
                    cmd.Parameters.AddRange(parameters);
                }

                using (var adapter = new SqlDataAdapter(cmd))
                {
                    adapter.Fill(dt);
                }
            }
            return dt;
        }

        /// <summary>
        /// Executes an INSERT, UPDATE, or DELETE command (Create, Update, Delete operation).
        /// Returns the number of affected rows.
        /// </summary>
        public static int ExecuteNonQuery(string commandText, SqlParameter[] parameters = null, CommandType commandType = CommandType.Text)
        {
            using (var conn = new SqlConnection(GetConnectionString()))
            using (var cmd = new SqlCommand(commandText, conn))
            {
                cmd.CommandType = commandType;
                if (parameters != null && parameters.Length > 0)
                {
                    cmd.Parameters.AddRange(parameters);
                }

                conn.Open();
                return cmd.ExecuteNonQuery();
            }
        }

        /// <summary>
        /// Executes a scalar command returning a single value (e.g. COUNT, SCOPE_IDENTITY()).
        /// </summary>
        public static object ExecuteScalar(string query, SqlParameter[] parameters = null, CommandType commandType = CommandType.Text)
        {
            using (var conn = new SqlConnection(GetConnectionString()))
            using (var cmd = new SqlCommand(query, conn))
            {
                cmd.CommandType = commandType;
                if (parameters != null && parameters.Length > 0)
                {
                    cmd.Parameters.AddRange(parameters);
                }

                conn.Open();
                return cmd.ExecuteScalar();
            }
        }
    }
}

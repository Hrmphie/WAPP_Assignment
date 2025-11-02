using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WAPP_Assignment.Pages.Global
{
    public partial class Login : Page
    {
        // ⚠️ DEBUG MODE FLAG - Set to FALSE for production/full system test
        private const bool DEBUG_MODE = true;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user is already logged in
                if (Session["UserID"] != null && Session["Role"] != null)
                {
                    RedirectToHomePage();
                    return;
                }

                // Show/hide debug bypass panel based on DEBUG_MODE
                pnlDebugBypass.Visible = DEBUG_MODE;
            }
        }

        /// <summary>
        /// Handles login button click - validates credentials and logs in user
        /// </summary>
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            try
            {
                string username = txtUsername.Text.Trim();
                string password = txtPassword.Text;

                // Validate credentials
                var user = ValidateUser(username, password);

                if (user != null)
                {
                    // Successful login - create session
                    CreateUserSession(user.UserID, user.Username, user.Role);

                    // Redirect to appropriate home page
                    RedirectToHomePage();
                }
                else
                {
                    // Invalid credentials
                    ShowError("Invalid username or password. Please try again.");
                }
            }
            catch (Exception ex)
            {
                ShowError("An error occurred during login. Please try again.");
                System.Diagnostics.Debug.WriteLine("Login error: " + ex.Message);
            }
        }

        /// <summary>
        /// Validates user credentials against the database
        /// </summary>
        /// <returns>User object if valid, null if invalid</returns>
        private UserInfo ValidateUser(string username, string password)
        {
            // TODO: Replace with actual database validation
            /*
            Example implementation with database:
            
            using (SqlConnection conn = DatabaseHelper.GetConnection())
            {
                string query = @"SELECT UserID, Username, PasswordHash, Role 
                               FROM Users 
                               WHERE Username = @Username";
                
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Username", username);
                
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                
                if (reader.Read())
                {
                    string storedHash = reader["PasswordHash"].ToString();
                    
                    // Verify password hash
                    if (PasswordHelper.VerifyPassword(password, storedHash))
                    {
                        UserInfo user = new UserInfo
                        {
                            UserID = Convert.ToInt32(reader["UserID"]),
                            Username = reader["Username"].ToString(),
                            Role = reader["Role"].ToString()
                        };
                        
                        reader.Close();
                        conn.Close();
                        return user;
                    }
                }
                
                reader.Close();
                conn.Close();
            }
            
            return null;
            */

            // Mock validation for testing
            // In real implementation, this would query the database
            if (username.ToLower() == "student" && password == "password")
            {
                return new UserInfo { UserID = 1, Username = "student", Role = "Student" };
            }
            else if (username.ToLower() == "admin" && password == "password")
            {
                return new UserInfo { UserID = 2, Username = "admin", Role = "Admin" };
            }

            return null;
        }

        /// <summary>
        /// Creates session variables for logged-in user
        /// </summary>
        private void CreateUserSession(int userID, string username, string role)
        {
            Session["UserID"] = userID;
            Session["Username"] = username;
            Session["Role"] = role;
            Session["LoginTime"] = DateTime.Now;
        }

        /// <summary>
        /// Redirects user to their home page based on role
        /// </summary>
        private void RedirectToHomePage()
        {
            if (Session["Role"] != null)
            {
                string role = Session["Role"].ToString();

                if (role == "Admin")
                {
                    Response.Redirect("~/Pages/Admin/AdminHome.aspx", false);
                }
                else if (role == "Student")
                {
                    Response.Redirect("~/Pages/Student/StudentHome.aspx", false);
                }
                else
                {
                    // Unknown role - clear session and show error
                    Session.Clear();
                    ShowError("Invalid user role. Please contact administrator.");
                }
            }
        }

        /// <summary>
        /// Displays error message to user
        /// </summary>
        private void ShowError(string message)
        {
            lblError.Text = message;
            pnlError.Visible = true;
        }

        #region DEBUG BYPASS METHODS - REMOVE FOR PRODUCTION

        /// <summary>
        /// ⚠️ DEBUG ONLY: Bypasses login as Student
        /// TO DISABLE: Set DEBUG_MODE = false at the top of this file
        /// </summary>
        protected void btnDebugStudent_Click(object sender, EventArgs e)
        {
            if (!DEBUG_MODE) return;

            // Create mock student session
            CreateUserSession(999, "DebugStudent", "Student");
            Response.Redirect("~/Pages/Student/StudentHome.aspx", false);
        }

        /// <summary>
        /// ⚠️ DEBUG ONLY: Bypasses login as Admin
        /// TO DISABLE: Set DEBUG_MODE = false at the top of this file
        /// </summary>
        protected void btnDebugAdmin_Click(object sender, EventArgs e)
        {
            if (!DEBUG_MODE) return;

            // Create mock admin session
            CreateUserSession(998, "DebugAdmin", "Admin");
            Response.Redirect("~/Pages/Admin/AdminHome.aspx", false);
        }

        #endregion

        /// <summary>
        /// Simple class to hold user information
        /// </summary>
        private class UserInfo
        {
            public int UserID { get; set; }
            public string Username { get; set; }
            public string Role { get; set; }
        }
    }
}
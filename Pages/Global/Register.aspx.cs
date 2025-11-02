using System;
using System.Web.UI;

namespace WAPP_Assignment.Pages.Global
{
    public partial class Register : Page
    {
        private bool isAdminRegistering = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if this registration is coming from admin's "Register New" button
                if (Request.QueryString["source"] == "admin")
                {
                    isAdminRegistering = true;
                    ViewState["AdminRegistering"] = true;
                }
            }
        }

        /// <summary>
        /// Handles register button click - validates and creates new user
        /// </summary>
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            try
            {
                // Get form values
                string email = txtEmail.Text.Trim();
                string username = txtUsername.Text.Trim();
                int age = Convert.ToInt32(txtAge.Text);
                string gender = rblGender.SelectedValue;
                string password = txtPassword.Text;

                // Check if username already exists
                if (UsernameExists(username))
                {
                    ShowError("Username already exists. Please choose a different username.");
                    return;
                }

                // Check if email already exists
                if (EmailExists(email))
                {
                    ShowError("Email already registered. Please use a different email or login.");
                    return;
                }

                // Hash the password
                string passwordHash = HashPassword(password);

                // Create new user
                bool success = CreateUser(email, username, age, gender, passwordHash);

                if (success)
                {
                    ShowSuccess("Registration successful! Redirecting to login...");

                    // Redirect after 2 seconds
                    if (ViewState["AdminRegistering"] != null && (bool)ViewState["AdminRegistering"])
                    {
                        // Admin registered a user - redirect back to Manage Users
                        Response.AddHeader("REFRESH", "2;URL=/Pages/Admin/ManageUsers.aspx");
                    }
                    else
                    {
                        // Regular registration - redirect to login
                        Response.AddHeader("REFRESH", "2;URL=/Pages/Global/Login.aspx");
                    }
                }
                else
                {
                    ShowError("Registration failed. Please try again.");
                }
            }
            catch (Exception ex)
            {
                ShowError("An error occurred during registration. Please try again.");
                System.Diagnostics.Debug.WriteLine("Registration error: " + ex.Message);
            }
        }

        /// <summary>
        /// Checks if username already exists in database
        /// </summary>
        private bool UsernameExists(string username)
        {
            // TODO: Replace with actual database query
            /*
            using (SqlConnection conn = DatabaseHelper.GetConnection())
            {
                string query = "SELECT COUNT(*) FROM Users WHERE Username = @Username";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Username", username);
                
                conn.Open();
                int count = Convert.ToInt32(cmd.ExecuteScalar());
                conn.Close();
                
                return count > 0;
            }
            */

            // Mock check - always returns false for now
            return false;
        }

        /// <summary>
        /// Checks if email already exists in database
        /// </summary>
        private bool EmailExists(string email)
        {
            // TODO: Replace with actual database query
            /*
            using (SqlConnection conn = DatabaseHelper.GetConnection())
            {
                string query = "SELECT COUNT(*) FROM Users WHERE Email = @Email";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);
                
                conn.Open();
                int count = Convert.ToInt32(cmd.ExecuteScalar());
                conn.Close();
                
                return count > 0;
            }
            */

            // Mock check - always returns false for now
            return false;
        }

        /// <summary>
        /// Hashes password using SHA256
        /// </summary>
        private string HashPassword(string password)
        {
            // TODO: Implement actual password hashing
            /*
            using (System.Security.Cryptography.SHA256 sha256 = System.Security.Cryptography.SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
                System.Text.StringBuilder builder = new System.Text.StringBuilder();
                foreach (byte b in bytes)
                {
                    builder.Append(b.ToString("x2"));
                }
                return builder.ToString();
            }
            */

            // Mock hash - in production, use proper hashing
            return "HASHED_" + password;
        }

        /// <summary>
        /// Creates new user in database
        /// </summary>
        private bool CreateUser(string email, string username, int age, string gender, string passwordHash)
        {
            try
            {
                // TODO: Replace with actual database insert
                /*
                using (SqlConnection conn = DatabaseHelper.GetConnection())
                {
                    string query = @"INSERT INTO Users (Email, Username, Age, Gender, PasswordHash, Role, DateRegistered)
                                   VALUES (@Email, @Username, @Age, @Gender, @PasswordHash, @Role, @DateRegistered)";
                    
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Age", age);
                    cmd.Parameters.AddWithValue("@Gender", gender);
                    cmd.Parameters.AddWithValue("@PasswordHash", passwordHash);
                    cmd.Parameters.AddWithValue("@Role", "Student");
                    cmd.Parameters.AddWithValue("@DateRegistered", DateTime.Now);
                    
                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    conn.Close();
                    
                    return rowsAffected > 0;
                }
                */

                // Mock success
                System.Diagnostics.Debug.WriteLine($"User registered: {username}, {email}, {age}, {gender}");
                return true;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error creating user: " + ex.Message);
                return false;
            }
        }

        /// <summary>
        /// Displays error message to user
        /// </summary>
        private void ShowError(string message)
        {
            lblError.Text = message;
            pnlError.Visible = true;
            pnlSuccess.Visible = false;
        }

        /// <summary>
        /// Displays success message to user
        /// </summary>
        private void ShowSuccess(string message)
        {
            lblSuccess.Text = message;
            pnlSuccess.Visible = true;
            pnlError.Visible = false;
        }
    }
}
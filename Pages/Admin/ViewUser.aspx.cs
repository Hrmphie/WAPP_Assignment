using System;
using System.Web.UI;

namespace WAPP_Assignment.Pages.Admin
{
    public partial class ViewUser : Page
    {
        private int currentUserID;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user is logged in and is admin
                if (Session["UserID"] == null || Session["Role"] == null)
                {
                    Response.Redirect("~/Pages/Global/Login.aspx");
                    return;
                }

                if (Session["Role"].ToString() != "Admin")
                {
                    Response.Redirect("~/Pages/Student/StudentHome.aspx");
                    return;
                }

                // Get userID from query string
                if (Request.QueryString["userID"] != null)
                {
                    if (int.TryParse(Request.QueryString["userID"], out currentUserID))
                    {
                        LoadUserDetails(currentUserID);
                    }
                    else
                    {
                        Response.Redirect("~/Pages/Admin/ManageUsers.aspx");
                    }
                }
                else
                {
                    Response.Redirect("~/Pages/Admin/ManageUsers.aspx");
                }
            }
        }

        /// <summary>
        /// Loads user details from database
        /// </summary>
        private void LoadUserDetails(int userID)
        {
            try
            {
                User user = GetUserByID(userID);

                if (user != null)
                {
                    // Display user information
                    lblUsername.Text = user.Username;
                    lblUsernameDetail.Text = user.Username;
                    lblEmail.Text = user.Email;
                    lblAge.Text = user.Age.ToString();
                    lblGender.Text = user.Gender;
                    lblUserID.Text = user.UserID.ToString();
                    lblDateRegistered.Text = user.DateRegistered.ToString("MMM dd, yyyy hh:mm tt");

                    // Set role badge styling
                    lblRole.Text = user.Role;
                    if (user.Role == "Admin")
                    {
                        lblRole.CssClass = "role-badge role-admin";
                    }
                    else
                    {
                        lblRole.CssClass = "role-badge role-student";
                    }

                    // Store userID in ViewState for delete operation
                    ViewState["CurrentUserID"] = userID;
                }
                else
                {
                    // User not found
                    Response.Redirect("~/Pages/Admin/ManageUsers.aspx");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error loading user details: " + ex.Message);
                Response.Redirect("~/Pages/Admin/ManageUsers.aspx");
            }
        }

        /// <summary>
        /// Gets user details from database by UserID
        /// </summary>
        private User GetUserByID(int userID)
        {
            // TODO: Replace with actual database query
            /*
            using (SqlConnection conn = DatabaseHelper.GetConnection())
            {
                string query = @"SELECT UserID, Email, Username, Age, Gender, Role, DateRegistered
                               FROM Users
                               WHERE UserID = @UserID";
                
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", userID);
                
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                
                if (reader.Read())
                {
                    User user = new User
                    {
                        UserID = Convert.ToInt32(reader["UserID"]),
                        Email = reader["Email"].ToString(),
                        Username = reader["Username"].ToString(),
                        Age = Convert.ToInt32(reader["Age"]),
                        Gender = reader["Gender"].ToString(),
                        Role = reader["Role"].ToString(),
                        DateRegistered = Convert.ToDateTime(reader["DateRegistered"])
                    };
                    
                    reader.Close();
                    conn.Close();
                    return user;
                }
                
                reader.Close();
                conn.Close();
            }
            
            return null;
            */

            // Mock data for testing
            return GetMockUser(userID);
        }

        /// <summary>
        /// Gets mock user data for testing
        /// </summary>
        private User GetMockUser(int userID)
        {
            // Mock data based on userID
            switch (userID)
            {
                case 1:
                    return new User
                    {
                        UserID = 1,
                        Email = "student1@example.com",
                        Username = "student1",
                        Age = 10,
                        Gender = "Male",
                        Role = "Student",
                        DateRegistered = DateTime.Now.AddDays(-15)
                    };
                case 2:
                    return new User
                    {
                        UserID = 2,
                        Email = "student2@example.com",
                        Username = "student2",
                        Age = 8,
                        Gender = "Female",
                        Role = "Student",
                        DateRegistered = DateTime.Now.AddDays(-10)
                    };
                case 3:
                    return new User
                    {
                        UserID = 3,
                        Email = "admin@mathventure.com",
                        Username = "admin",
                        Age = 30,
                        Gender = "Male",
                        Role = "Admin",
                        DateRegistered = DateTime.Now.AddDays(-30)
                    };
                default:
                    return new User
                    {
                        UserID = userID,
                        Email = $"user{userID}@example.com",
                        Username = $"user{userID}",
                        Age = 10,
                        Gender = "Male",
                        Role = "Student",
                        DateRegistered = DateTime.Now.AddDays(-5)
                    };
            }
        }

        /// <summary>
        /// Handles back button click - returns to Manage Users page
        /// </summary>
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/Admin/ManageUsers.aspx");
        }

        /// <summary>
        /// Handles delete button click - deletes user from database
        /// </summary>
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                if (ViewState["CurrentUserID"] != null)
                {
                    int userID = Convert.ToInt32(ViewState["CurrentUserID"]);

                    // Check if trying to delete the currently logged-in admin
                    if (Session["UserID"] != null && Convert.ToInt32(Session["UserID"]) == userID)
                    {
                        // Cannot delete yourself
                        Response.Write("<script>alert('You cannot delete your own account!');</script>");
                        return;
                    }

                    bool success = DeleteUser(userID);

                    if (success)
                    {
                        // Redirect back to manage users with success message
                        Response.Redirect("~/Pages/Admin/ManageUsers.aspx");
                    }
                    else
                    {
                        Response.Write("<script>alert('Failed to delete user. Please try again.');</script>");
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error deleting user: " + ex.Message);
                Response.Write("<script>alert('An error occurred while deleting the user.');</script>");
            }
        }

        /// <summary>
        /// Deletes user from database
        /// </summary>
        private bool DeleteUser(int userID)
        {
            try
            {
                // TODO: Replace with actual database delete
                /*
                using (SqlConnection conn = DatabaseHelper.GetConnection())
                {
                    // First, delete related records (quiz attempts, etc.)
                    string deleteAttemptsQuery = "DELETE FROM QuizAttempts WHERE UserID = @UserID";
                    SqlCommand cmdAttempts = new SqlCommand(deleteAttemptsQuery, conn);
                    cmdAttempts.Parameters.AddWithValue("@UserID", userID);
                    
                    // Then delete the user
                    string deleteUserQuery = "DELETE FROM Users WHERE UserID = @UserID";
                    SqlCommand cmdUser = new SqlCommand(deleteUserQuery, conn);
                    cmdUser.Parameters.AddWithValue("@UserID", userID);
                    
                    conn.Open();
                    cmdAttempts.ExecuteNonQuery();
                    int rowsAffected = cmdUser.ExecuteNonQuery();
                    conn.Close();
                    
                    return rowsAffected > 0;
                }
                */

                // Mock success
                System.Diagnostics.Debug.WriteLine($"User {userID} deleted successfully");
                return true;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error in DeleteUser: " + ex.Message);
                return false;
            }
        }

        /// <summary>
        /// User class to hold user data
        /// </summary>
        private class User
        {
            public int UserID { get; set; }
            public string Email { get; set; }
            public string Username { get; set; }
            public int Age { get; set; }
            public string Gender { get; set; }
            public string Role { get; set; }
            public DateTime DateRegistered { get; set; }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WAPP_Assignment.Pages.Admin
{
    public partial class ManageUsers : Page
    {
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

                // Load all users
                LoadUsers();
            }
        }

        /// <summary>
        /// Loads all users from database and displays them
        /// </summary>
        private void LoadUsers()
        {
            try
            {
                List<User> users = GetAllUsers();

                if (users.Count > 0)
                {
                    // Show users list
                    pnlUsersList.Visible = true;
                    pnlNoUsers.Visible = false;

                    // Bind to repeater
                    rptUsers.DataSource = users;
                    rptUsers.DataBind();

                    // Update total count
                    lblTotalUsers.Text = users.Count.ToString();
                }
                else
                {
                    // No users found
                    pnlUsersList.Visible = false;
                    pnlNoUsers.Visible = true;
                    lblTotalUsers.Text = "0";
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error loading users: " + ex.Message);
                pnlUsersList.Visible = false;
                pnlNoUsers.Visible = true;
            }
        }

        /// <summary>
        /// Gets all users from database
        /// </summary>
        private List<User> GetAllUsers()
        {
            // TODO: Replace with actual database query
            /*
            List<User> users = new List<User>();
            
            using (SqlConnection conn = DatabaseHelper.GetConnection())
            {
                string query = @"SELECT UserID, Email, Username, Age, Gender, Role, DateRegistered
                               FROM Users
                               ORDER BY DateRegistered DESC";
                
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                
                while (reader.Read())
                {
                    users.Add(new User
                    {
                        UserID = Convert.ToInt32(reader["UserID"]),
                        Email = reader["Email"].ToString(),
                        Username = reader["Username"].ToString(),
                        Age = Convert.ToInt32(reader["Age"]),
                        Gender = reader["Gender"].ToString(),
                        Role = reader["Role"].ToString(),
                        DateRegistered = Convert.ToDateTime(reader["DateRegistered"])
                    });
                }
                
                reader.Close();
                conn.Close();
            }
            
            return users;
            */

            // Mock data for testing
            return GetMockUsers();
        }

        /// <summary>
        /// Generates mock user data for testing
        /// </summary>
        private List<User> GetMockUsers()
        {
            List<User> users = new List<User>
            {
                new User
                {
                    UserID = 1,
                    Email = "student1@example.com",
                    Username = "student1",
                    Age = 10,
                    Gender = "Male",
                    Role = "Student",
                    DateRegistered = DateTime.Now.AddDays(-15)
                },
                new User
                {
                    UserID = 2,
                    Email = "student2@example.com",
                    Username = "student2",
                    Age = 8,
                    Gender = "Female",
                    Role = "Student",
                    DateRegistered = DateTime.Now.AddDays(-10)
                },
                new User
                {
                    UserID = 3,
                    Email = "admin@mathventure.com",
                    Username = "admin",
                    Age = 30,
                    Gender = "Male",
                    Role = "Admin",
                    DateRegistered = DateTime.Now.AddDays(-30)
                },
                new User
                {
                    UserID = 4,
                    Email = "student3@example.com",
                    Username = "student3",
                    Age = 11,
                    Gender = "Male",
                    Role = "Student",
                    DateRegistered = DateTime.Now.AddDays(-5)
                },
                new User
                {
                    UserID = 5,
                    Email = "student4@example.com",
                    Username = "student4",
                    Age = 7,
                    Gender = "Female",
                    Role = "Student",
                    DateRegistered = DateTime.Now.AddDays(-2)
                }
            };

            return users;
        }

        /// <summary>
        /// Handles user item click - redirects to view user details
        /// </summary>
        protected void rptUsers_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ViewUser")
            {
                int userID = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"~/Pages/Admin/ViewUser.aspx?userID={userID}");
            }
        }

        /// <summary>
        /// User class to hold user data
        /// </summary>
        public class User
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
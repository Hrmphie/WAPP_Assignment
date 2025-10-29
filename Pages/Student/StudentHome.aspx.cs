using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WAPP_Assignment.Pages.Student
{
    public partial class StudentHome : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user is logged in
                if (Session["UserID"] == null || Session["Role"] == null)
                {
                    Response.Redirect("~/Pages/Global/Login.aspx");
                    return;
                }

                // Check if user is actually a student
                if (Session["Role"].ToString() != "Student")
                {
                    Response.Redirect("~/Pages/Admin/AdminHome.aspx");
                    return;
                }

                // Load user information
                LoadUserInfo();

                // Load progress
                LoadProgress();
            }
        }

        /// <summary>
        /// Loads the current user's information and displays username
        /// </summary>
        private void LoadUserInfo()
        {
            if (Session["Username"] != null)
            {
                lblUsername.Text = Session["Username"].ToString();
            }
        }

        /// <summary>
        /// Loads the user's progress and calculates completion percentage
        /// </summary>
        private void LoadProgress()
        {
            try
            {
                int userID = Convert.ToInt32(Session["UserID"]);

                // TODO: Replace with actual database call
                // For now, using mock data
                double progressPercentage = CalculateProgress(userID);

                // Update progress bar
                lblProgressPercentage.Text = progressPercentage.ToString("0") + "%";
                progressBarFill.Style["width"] = progressPercentage.ToString("0") + "%";
            }
            catch (Exception ex)
            {
                // Log error (in production, use proper logging)
                System.Diagnostics.Debug.WriteLine("Error loading progress: " + ex.Message);
                lblProgressPercentage.Text = "0%";
                progressBarFill.Style["width"] = "0%";
            }
        }

        /// <summary>
        /// Calculates the user's progress based on completed quizzes
        /// </summary>
        /// <param name="userID">The user's ID</param>
        /// <returns>Progress percentage (0-100)</returns>
        private double CalculateProgress(int userID)
        {
            // TODO: Implement actual database logic
            // This should query QuizAttempts table and calculate:
            // - How many distinct levels have been completed
            // - Total levels = 3
            // - Progress = (completed levels / total levels) * 100

            /*
            Example implementation with database:
            
            using (SqlConnection conn = DatabaseHelper.GetConnection())
            {
                string query = @"SELECT COUNT(DISTINCT Level) 
                               FROM QuizAttempts 
                               WHERE UserID = @UserID";
                
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", userID);
                
                conn.Open();
                int completedLevels = Convert.ToInt32(cmd.ExecuteScalar());
                conn.Close();
                
                return (completedLevels / 3.0) * 100;
            }
            */

            // Mock data for now
            return 33.33; // Example: 1 out of 3 levels completed
        }

        /// <summary>
        /// Handles Lessons button click - navigates to Lessons Level page
        /// </summary>
        protected void btnLessons_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/Student/LessonsLevel.aspx");
        }

        /// <summary>
        /// Handles Quizzes button click - navigates to Quizzes Level page
        /// </summary>
        protected void btnQuizzes_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/Student/QuizzesLevel.aspx");
        }

        /// <summary>
        /// Handles Progress bar click - navigates to Progress page
        /// </summary>
        protected void lnkProgress_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/Student/Progress.aspx");
        }
    }
}
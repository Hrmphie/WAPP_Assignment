using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;

namespace WAPP_Assignment.Pages.Student
{
    public partial class Progress : Page
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

                // Check if user is a student
                if (Session["Role"].ToString() != "Student")
                {
                    Response.Redirect("~/Pages/Admin/AdminHome.aspx");
                    return;
                }

                // Load user's progress
                LoadProgressData();
            }
        }

        /// <summary>
        /// Loads all progress data including statistics and quiz history
        /// </summary>
        private void LoadProgressData()
        {
            try
            {
                int userID = Convert.ToInt32(Session["UserID"]);

                // Get all quiz attempts for the user
                List<QuizAttempt> attempts = GetUserAttempts(userID);

                if (attempts.Count > 0)
                {
                    // Show attempts list
                    pnlAttempts.Visible = true;
                    pnlNoAttempts.Visible = false;

                    // Bind attempts to repeater
                    rptAttempts.DataSource = attempts;
                    rptAttempts.DataBind();

                    // Calculate and display statistics
                    CalculateStatistics(attempts);
                }
                else
                {
                    // No attempts - show empty state
                    pnlAttempts.Visible = false;
                    pnlNoAttempts.Visible = true;

                    // Set statistics to 0
                    lblTotalAttempts.Text = "0";
                    lblAverageScore.Text = "0";
                    lblCompletionRate.Text = "0";
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error loading progress: " + ex.Message);
                pnlAttempts.Visible = false;
                pnlNoAttempts.Visible = true;
            }
        }

        /// <summary>
        /// Gets all quiz attempts for a user from the database
        /// </summary>
        private List<QuizAttempt> GetUserAttempts(int userID)
        {
            // TODO: Replace with actual database query
            /*
            List<QuizAttempt> attempts = new List<QuizAttempt>();
            
            using (SqlConnection conn = DatabaseHelper.GetConnection())
            {
                string query = @"SELECT AttemptID, UserID, Level, Score, TotalQuestions, DateCompleted
                               FROM QuizAttempts
                               WHERE UserID = @UserID
                               ORDER BY DateCompleted DESC";
                
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", userID);
                
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                
                while (reader.Read())
                {
                    attempts.Add(new QuizAttempt
                    {
                        AttemptID = Convert.ToInt32(reader["AttemptID"]),
                        UserID = Convert.ToInt32(reader["UserID"]),
                        Level = Convert.ToInt32(reader["Level"]),
                        Score = Convert.ToInt32(reader["Score"]),
                        TotalQuestions = Convert.ToInt32(reader["TotalQuestions"]),
                        DateCompleted = Convert.ToDateTime(reader["DateCompleted"])
                    });
                }
                
                reader.Close();
                conn.Close();
            }
            
            return attempts;
            */

            // Mock data for now
            return GetMockAttempts(userID);
        }

        /// <summary>
        /// Generates mock quiz attempts (temporary - will be replaced with database)
        /// </summary>
        private List<QuizAttempt> GetMockAttempts(int userID)
        {
            List<QuizAttempt> attempts = new List<QuizAttempt>
            {
                new QuizAttempt
                {
                    AttemptID = 1,
                    UserID = userID,
                    Level = 1,
                    Score = 3,
                    TotalQuestions = 3,
                    DateCompleted = DateTime.Now.AddDays(-5)
                },
                new QuizAttempt
                {
                    AttemptID = 2,
                    UserID = userID,
                    Level = 1,
                    Score = 2,
                    TotalQuestions = 3,
                    DateCompleted = DateTime.Now.AddDays(-3)
                },
                new QuizAttempt
                {
                    AttemptID = 3,
                    UserID = userID,
                    Level = 2,
                    Score = 2,
                    TotalQuestions = 3,
                    DateCompleted = DateTime.Now.AddDays(-1)
                }
            };

            return attempts;
        }

        /// <summary>
        /// Calculates statistics based on quiz attempts
        /// </summary>
        private void CalculateStatistics(List<QuizAttempt> attempts)
        {
            // Total attempts
            lblTotalAttempts.Text = attempts.Count.ToString();

            // Average score percentage
            double totalPercentage = 0;
            foreach (var attempt in attempts)
            {
                double percentage = (attempt.Score / (double)attempt.TotalQuestions) * 100;
                totalPercentage += percentage;
            }
            double averageScore = totalPercentage / attempts.Count;
            lblAverageScore.Text = Math.Round(averageScore, 0).ToString();

            // Completion rate (how many distinct levels completed out of 3)
            var completedLevels = attempts.Select(a => a.Level).Distinct().Count();
            int totalLevels = 3;
            double completionRate = (completedLevels / (double)totalLevels) * 100;
            lblCompletionRate.Text = Math.Round(completionRate, 0).ToString();
        }

        /// <summary>
        /// Helper method to get level name from level number (for use in Repeater)
        /// </summary>
        protected string GetLevelName(object levelObj)
        {
            if (levelObj == null) return "Unknown";

            int level = Convert.ToInt32(levelObj);
            switch (level)
            {
                case 1: return "Beginner";
                case 2: return "Intermediate";
                case 3: return "Advanced";
                default: return "Unknown";
            }
        }

        /// <summary>
        /// Handles back button click - returns to student home
        /// </summary>
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/Student/StudentHome.aspx");
        }

        /// <summary>
        /// QuizAttempt class to hold quiz attempt data
        /// </summary>
        public class QuizAttempt
        {
            public int AttemptID { get; set; }
            public int UserID { get; set; }
            public int Level { get; set; }
            public int Score { get; set; }
            public int TotalQuestions { get; set; }
            public DateTime DateCompleted { get; set; }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace WAPP_Assignment.Pages.Student
{
    public partial class QuizzesPage : Page
    {
        private int currentLevel;
        private List<Quiz> currentQuizzes;

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

                // Get level from query string
                if (Request.QueryString["level"] != null)
                {
                    if (int.TryParse(Request.QueryString["level"], out currentLevel))
                    {
                        if (currentLevel >= 1 && currentLevel <= 3)
                        {
                            LoadQuizContent(currentLevel);
                        }
                        else
                        {
                            Response.Redirect("~/Pages/Student/QuizzesLevel.aspx");
                        }
                    }
                    else
                    {
                        Response.Redirect("~/Pages/Student/QuizzesLevel.aspx");
                    }
                }
                else
                {
                    Response.Redirect("~/Pages/Student/QuizzesLevel.aspx");
                }
            }
        }

        /// <summary>
        /// Loads quiz content for the specified level
        /// </summary>
        private void LoadQuizContent(int level)
        {
            // Set title and subtitle
            lblLevelTitle.Text = "Level " + level + " Quiz";

            switch (level)
            {
                case 1:
                    lblLevelSubtitle.Text = "Beginner Quiz";
                    break;
                case 2:
                    lblLevelSubtitle.Text = "Intermediate Quiz";
                    break;
                case 3:
                    lblLevelSubtitle.Text = "Advanced Quiz";
                    break;
            }

            // Load quiz questions from database
            currentQuizzes = GetQuizzesForLevel(level);

            // Store in ViewState for later validation
            ViewState["CurrentLevel"] = level;
            ViewState["QuizData"] = currentQuizzes;

            // Populate questions on the page
            if (currentQuizzes.Count >= 3)
            {
                // Question 1
                imgQuestion1.Src = currentQuizzes[0].ImagePath;
                lblQuestion1.Text = currentQuizzes[0].QuestionText;
                rblQuestion1.Items[0].Text = "A. " + currentQuizzes[0].OptionA;
                rblQuestion1.Items[1].Text = "B. " + currentQuizzes[0].OptionB;
                rblQuestion1.Items[2].Text = "C. " + currentQuizzes[0].OptionC;
                rblQuestion1.Items[3].Text = "D. " + currentQuizzes[0].OptionD;

                // Question 2
                imgQuestion2.Src = currentQuizzes[1].ImagePath;
                lblQuestion2.Text = currentQuizzes[1].QuestionText;
                rblQuestion2.Items[0].Text = "A. " + currentQuizzes[1].OptionA;
                rblQuestion2.Items[1].Text = "B. " + currentQuizzes[1].OptionB;
                rblQuestion2.Items[2].Text = "C. " + currentQuizzes[1].OptionC;
                rblQuestion2.Items[3].Text = "D. " + currentQuizzes[1].OptionD;

                // Question 3
                imgQuestion3.Src = currentQuizzes[2].ImagePath;
                lblQuestion3.Text = currentQuizzes[2].QuestionText;
                rblQuestion3.Items[0].Text = "A. " + currentQuizzes[2].OptionA;
                rblQuestion3.Items[1].Text = "B. " + currentQuizzes[2].OptionB;
                rblQuestion3.Items[2].Text = "C. " + currentQuizzes[2].OptionC;
                rblQuestion3.Items[3].Text = "D. " + currentQuizzes[2].OptionD;
            }
        }

        /// <summary>
        /// Gets quiz questions for a specific level from database
        /// </summary>
        private List<Quiz> GetQuizzesForLevel(int level)
        {
            // TODO: Replace with actual database query
            /*
            List<Quiz> quizzes = new List<Quiz>();
            
            using (SqlConnection conn = DatabaseHelper.GetConnection())
            {
                string query = @"SELECT QuizID, Level, QuestionNumber, QuestionText, 
                               ImagePath, OptionA, OptionB, OptionC, OptionD, CorrectAnswer
                               FROM Quizzes 
                               WHERE Level = @Level AND IsActive = 1
                               ORDER BY QuestionNumber";
                
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Level", level);
                
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                
                while (reader.Read())
                {
                    quizzes.Add(new Quiz
                    {
                        QuizID = Convert.ToInt32(reader["QuizID"]),
                        Level = Convert.ToInt32(reader["Level"]),
                        QuestionNumber = Convert.ToInt32(reader["QuestionNumber"]),
                        QuestionText = reader["QuestionText"].ToString(),
                        ImagePath = reader["ImagePath"].ToString(),
                        OptionA = reader["OptionA"].ToString(),
                        OptionB = reader["OptionB"].ToString(),
                        OptionC = reader["OptionC"].ToString(),
                        OptionD = reader["OptionD"].ToString(),
                        CorrectAnswer = reader["CorrectAnswer"].ToString()[0]
                    });
                }
                
                reader.Close();
                conn.Close();
            }
            
            return quizzes;
            */

            // Mock data
            return GetMockQuizzes(level);
        }

        /// <summary>
        /// Generates mock quiz data (temporary - will be replaced with database)
        /// </summary>
        private List<Quiz> GetMockQuizzes(int level)
        {
            List<Quiz> quizzes = new List<Quiz>();

            switch (level)
            {
                case 1: // Beginner
                    quizzes.Add(new Quiz
                    {
                        QuizID = 1,
                        Level = 1,
                        QuestionNumber = 1,
                        QuestionText = "What is 2 + 2?",
                        ImagePath = "../../Content/images/quiz-easy-1.png",
                        OptionA = "2",
                        OptionB = "3",
                        OptionC = "4",
                        OptionD = "5",
                        CorrectAnswer = 'C'
                    });
                    quizzes.Add(new Quiz
                    {
                        QuizID = 2,
                        Level = 1,
                        QuestionNumber = 2,
                        QuestionText = "What is 5 - 3?",
                        ImagePath = "../../Content/images/quiz-easy-2.png",
                        OptionA = "1",
                        OptionB = "2",
                        OptionC = "3",
                        OptionD = "4",
                        CorrectAnswer = 'B'
                    });
                    quizzes.Add(new Quiz
                    {
                        QuizID = 3,
                        Level = 1,
                        QuestionNumber = 3,
                        QuestionText = "How many sides does a triangle have?",
                        ImagePath = "../../Content/images/quiz-easy-3.png",
                        OptionA = "2",
                        OptionB = "3",
                        OptionC = "4",
                        OptionD = "5",
                        CorrectAnswer = 'B'
                    });
                    break;

                case 2: // Intermediate
                    quizzes.Add(new Quiz
                    {
                        QuizID = 4,
                        Level = 2,
                        QuestionNumber = 1,
                        QuestionText = "What is 3 × 3?",
                        ImagePath = "../../Content/images/quiz-medium-1.png",
                        OptionA = "9",
                        OptionB = "11",
                        OptionC = "18",
                        OptionD = "21",
                        CorrectAnswer = 'A'
                    });
                    quizzes.Add(new Quiz
                    {
                        QuizID = 5,
                        Level = 2,
                        QuestionNumber = 2,
                        QuestionText = "What is 20 ÷ 4?",
                        ImagePath = "../../Content/images/quiz-medium-2.png",
                        OptionA = "4",
                        OptionB = "5",
                        OptionC = "6",
                        OptionD = "7",
                        CorrectAnswer = 'B'
                    });
                    quizzes.Add(new Quiz
                    {
                        QuizID = 6,
                        Level = 2,
                        QuestionNumber = 3,
                        QuestionText = "What is half of 16?",
                        ImagePath = "../../Content/images/quiz-medium-3.png",
                        OptionA = "6",
                        OptionB = "7",
                        OptionC = "8",
                        OptionD = "9",
                        CorrectAnswer = 'C'
                    });
                    break;

                case 3: // Advanced
                    quizzes.Add(new Quiz
                    {
                        QuizID = 7,
                        Level = 3,
                        QuestionNumber = 1,
                        QuestionText = "What is 15% of 100?",
                        ImagePath = "../../Content/images/quiz-hard-1.png",
                        OptionA = "10",
                        OptionB = "15",
                        OptionC = "20",
                        OptionD = "25",
                        CorrectAnswer = 'B'
                    });
                    quizzes.Add(new Quiz
                    {
                        QuizID = 8,
                        Level = 3,
                        QuestionNumber = 2,
                        QuestionText = "What is 2.5 + 3.5?",
                        ImagePath = "../../Content/images/quiz-hard-2.png",
                        OptionA = "5.0",
                        OptionB = "6.0",
                        OptionC = "6.5",
                        OptionD = "7.0",
                        CorrectAnswer = 'B'
                    });
                    quizzes.Add(new Quiz
                    {
                        QuizID = 9,
                        Level = 3,
                        QuestionNumber = 3,
                        QuestionText = "If 3x = 15, what is x?",
                        ImagePath = "../../Content/images/quiz-hard-3.png",
                        OptionA = "3",
                        OptionB = "4",
                        OptionC = "5",
                        OptionD = "6",
                        CorrectAnswer = 'C'
                    });
                    break;
            }

            return quizzes;
        }

        /// <summary>
        /// Handles submit button click - validates answers and calculates score
        /// </summary>
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // Validate that all questions are answered
            if (string.IsNullOrEmpty(rblQuestion1.SelectedValue) ||
                string.IsNullOrEmpty(rblQuestion2.SelectedValue) ||
                string.IsNullOrEmpty(rblQuestion3.SelectedValue))
            {
                lblError.Text = "Please answer all questions before submitting!";
                lblError.Visible = true;
                return;
            }

            lblError.Visible = false;

            // Get quiz data from ViewState
            List<Quiz> quizzes = ViewState["QuizData"] as List<Quiz>;
            int level = (int)ViewState["CurrentLevel"];

            if (quizzes == null || quizzes.Count < 3)
            {
                Response.Redirect("~/Pages/Student/QuizzesLevel.aspx");
                return;
            }

            // Calculate score
            int score = 0;
            if (rblQuestion1.SelectedValue == quizzes[0].CorrectAnswer.ToString()) score++;
            if (rblQuestion2.SelectedValue == quizzes[1].CorrectAnswer.ToString()) score++;
            if (rblQuestion3.SelectedValue == quizzes[2].CorrectAnswer.ToString()) score++;

            // Save quiz attempt to database
            SaveQuizAttempt(level, score, 3);

            // Store score in session and redirect to submitted page
            Session["LastQuizScore"] = score;
            Session["LastQuizTotal"] = 3;
            Response.Redirect("~/Pages/Student/Submitted.aspx");
        }

        /// <summary>
        /// Saves the quiz attempt to the database
        /// </summary>
        private void SaveQuizAttempt(int level, int score, int totalQuestions)
        {
            try
            {
                int userID = Convert.ToInt32(Session["UserID"]);

                // TODO: Replace with actual database insert
                /*
                using (SqlConnection conn = DatabaseHelper.GetConnection())
                {
                    string query = @"INSERT INTO QuizAttempts (UserID, Level, Score, TotalQuestions, DateCompleted)
                                   VALUES (@UserID, @Level, @Score, @TotalQuestions, @DateCompleted)";
                    
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@UserID", userID);
                    cmd.Parameters.AddWithValue("@Level", level);
                    cmd.Parameters.AddWithValue("@Score", score);
                    cmd.Parameters.AddWithValue("@TotalQuestions", totalQuestions);
                    cmd.Parameters.AddWithValue("@DateCompleted", DateTime.Now);
                    
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
                */

                // For now, just log it
                System.Diagnostics.Debug.WriteLine($"Quiz Attempt Saved: UserID={userID}, Level={level}, Score={score}/{totalQuestions}");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error saving quiz attempt: " + ex.Message);
            }
        }

        /// <summary>
        /// Quiz class to hold question data
        /// </summary>
        [Serializable]
        public class Quiz
        {
            public int QuizID { get; set; }
            public int Level { get; set; }
            public int QuestionNumber { get; set; }
            public string QuestionText { get; set; }
            public string ImagePath { get; set; }
            public string OptionA { get; set; }
            public string OptionB { get; set; }
            public string OptionC { get; set; }
            public string OptionD { get; set; }
            public char CorrectAnswer { get; set; }
        }
    }
}
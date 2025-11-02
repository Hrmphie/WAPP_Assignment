using System;
using System.Collections.Generic;
using System.Web.UI;

namespace WAPP_Assignment.Pages.Student
{
    public partial class LessonsPage : Page
    {
        private int currentLevel;

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
                            LoadLessonContent(currentLevel);
                        }
                        else
                        {
                            // Invalid level, redirect back
                            Response.Redirect("~/Pages/Student/LessonsLevel.aspx");
                        }
                    }
                    else
                    {
                        Response.Redirect("~/Pages/Student/LessonsLevel.aspx");
                    }
                }
                else
                {
                    // No level specified, redirect back
                    Response.Redirect("~/Pages/Student/LessonsLevel.aspx");
                }
            }
        }

        /// <summary>
        /// Loads lesson content for the specified level
        /// </summary>
        /// <param name="level">The lesson level (1-3)</param>
        private void LoadLessonContent(int level)
        {
            // Set title and subtitle based on level
            lblLevelTitle.Text = "Level " + level;

            switch (level)
            {
                case 1:
                    lblLevelSubtitle.Text = "Beginner";
                    break;
                case 2:
                    lblLevelSubtitle.Text = "Intermediate";
                    break;
                case 3:
                    lblLevelSubtitle.Text = "Advanced";
                    break;
            }

            // Load lessons from database
            List<Lesson> lessons = GetLessonsForLevel(level);

            // Bind to repeater
            rptLessons.DataSource = lessons;
            rptLessons.DataBind();
        }

        /// <summary>
        /// Gets lessons for a specific level from the database
        /// </summary>
        /// <param name="level">The lesson level</param>
        /// <returns>List of lessons</returns>
        private List<Lesson> GetLessonsForLevel(int level)
        {
            // TODO: Replace with actual database query
            /*
            Example implementation with database:
            
            List<Lesson> lessons = new List<Lesson>();
            
            using (SqlConnection conn = DatabaseHelper.GetConnection())
            {
                string query = @"SELECT LessonID, Level, LevelName, SectionNumber, 
                               ImagePath, ContentText 
                               FROM Lessons 
                               WHERE Level = @Level AND IsActive = 1
                               ORDER BY SectionNumber";
                
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Level", level);
                
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                
                while (reader.Read())
                {
                    lessons.Add(new Lesson
                    {
                        LessonID = Convert.ToInt32(reader["LessonID"]),
                        Level = Convert.ToInt32(reader["Level"]),
                        LevelName = reader["LevelName"].ToString(),
                        SectionNumber = Convert.ToInt32(reader["SectionNumber"]),
                        ImagePath = reader["ImagePath"].ToString(),
                        ContentText = reader["ContentText"].ToString()
                    });
                }
                
                reader.Close();
                conn.Close();
            }
            
            return lessons;
            */

            // Mock data for now
            List<Lesson> mockLessons = new List<Lesson>();

            for (int i = 1; i <= 4; i++)
            {
                mockLessons.Add(new Lesson
                {
                    LessonID = i,
                    Level = level,
                    LevelName = GetLevelName(level),
                    SectionNumber = i,
                    ImagePath = GetMockImagePath(level, i),
                    ContentText = GetMockLessonText(level, i)
                });
            }

            return mockLessons;
        }

        /// <summary>
        /// Gets the level name based on level number
        /// </summary>
        private string GetLevelName(int level)
        {
            switch (level)
            {
                case 1: return "Beginner";
                case 2: return "Intermediate";
                case 3: return "Advanced";
                default: return "Unknown";
            }
        }

        private string GetMockImagePath(int level, int section)
        {
            switch (level)
            {
                case 1: // Beginner
                    switch (section)
                    {
                        case 1:
                            return "../../Content/images/lessons-easy-1.png";
                        case 2:
                            return "../../Content/images/lessons-easy-2.png";
                        case 3:
                            return "../../Content/images/lessons-easy-3.png";
                        case 4:
                            return "../../Content/images/lessons-easy-4.png";
                        default:
                            return "";
                    }
                case 2: // Intermediate
                    switch (section)
                    {
                        case 1:
                            return "../../Content/images/lessons-medium-1.png";
                        case 2:
                            return "../../Content/images/lessons-medium-2.png";
                        case 3:
                            return "../../Content/images/lessons-medium-3.png";
                        case 4:
                            return "../../Content/images/lessons-medium-4.png";
                        default:
                            return "";
                    }
                case 3: // Advanced
                    switch (section)
                    {
                        case 1:
                            return "../../Content/images/lessons-hard-1.png";
                        case 2:
                            return "../../Content/images/lessons-hard-2.png";
                        case 3:
                            return "../../Content/images/lessons-hard-3.png";
                        case 4:
                            return "../../Content/images/lessons-hard-4.png";
                        default:
                            return "";
                    }
                default:
                    return "Lesson content goes here.";
            }
        }

        /// <summary>
        /// Generates mock lesson text (will be replaced with database content)
        /// </summary>
        private string GetMockLessonText(int level, int section)
        {
            // Mock content - will be replaced with database content
            switch (level)
            {
                case 1: // Beginner
                    switch (section)
                    {
                        case 1:
                            return "Welcome to basic counting! Numbers help us count things around us. Let's start with numbers 1 to 10. Practice counting your fingers, toys, or anything you can see!";
                        case 2:
                            return "Let's learn about shapes! A circle is round like a ball. A square has four equal sides. A triangle has three corners. Can you find these shapes in your room?";
                        case 3:
                            return "Addition means putting things together! If you have 2 apples and get 1 more, you now have 3 apples. We write this as 2 + 1 = 3. Try adding small numbers!";
                        case 4:
                            return "Subtraction means taking things away! If you have 5 candies and eat 2, you have 3 left. We write this as 5 - 2 = 3. Practice with your toys!";
                        default:
                            return "Lesson content goes here.";
                    }
                case 2: // Intermediate
                    switch (section)
                    {
                        case 1:
                            return "Let's explore bigger numbers! We can count up to 100. Notice how numbers have patterns: 10, 20, 30, 40... Each group of ten makes counting easier!";
                        case 2:
                            return "Multiplication is repeated addition! Instead of adding 3 + 3 + 3 + 3, we can say 3 × 4 = 12. This means 3 added together 4 times equals 12!";
                        case 3:
                            return "Division means sharing equally! If you have 9 cookies and want to share with 3 friends, each person gets 3 cookies. We write this as 9 ÷ 3 = 3.";
                        case 4:
                            return "Time to learn fractions! When you cut a pizza into equal pieces, each piece is a fraction. Half means 1 out of 2 pieces. Quarter means 1 out of 4 pieces!";
                        default:
                            return "Lesson content goes here.";
                    }
                case 3: // Advanced
                    switch (section)
                    {
                        case 1:
                            return "Welcome to decimals! Decimals help us show parts of whole numbers. For example, 2.5 means 2 and a half. Money uses decimals too: $1.50 means 1 dollar and 50 cents!";
                        case 2:
                            return "Percentages show parts out of 100! If you answered 80 out of 100 questions correctly, that's 80%. Percentages help us compare scores and amounts easily!";
                        case 3:
                            return "Let's solve word problems! Read carefully, find the numbers, and decide if you need to add, subtract, multiply, or divide. Draw pictures to help visualize the problem!";
                        case 4:
                            return "Advanced patterns and sequences! Look at this: 2, 4, 6, 8... each number increases by 2. Can you predict the next numbers? Patterns help us understand mathematics better!";
                        default:
                            return "Lesson content goes here.";
                    }
                default:
                    return "Lesson content goes here.";
            }
        }

        /// <summary>
        /// Handles back button click - returns to lessons level page
        /// </summary>
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/Student/LessonsLevel.aspx");
        }

        /// <summary>
        /// Simple Lesson class to hold lesson data
        /// </summary>
        public class Lesson
        {
            public int LessonID { get; set; }
            public int Level { get; set; }
            public string LevelName { get; set; }
            public int SectionNumber { get; set; }
            public string ImagePath { get; set; }
            public string ContentText { get; set; }
        }
    }
}
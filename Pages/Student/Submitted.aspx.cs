using System;
using System.Web.UI;

namespace WAPP_Assignment.Pages.Student
{
    public partial class Submitted : Page
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

                // Load score from session
                LoadScore();
            }
        }

        /// <summary>
        /// Loads the quiz score from session and displays it
        /// </summary>
        private void LoadScore()
        {
            // Check if score exists in session
            if (Session["LastQuizScore"] != null && Session["LastQuizTotal"] != null)
            {
                int score = Convert.ToInt32(Session["LastQuizScore"]);
                int total = Convert.ToInt32(Session["LastQuizTotal"]);

                lblScore.Text = score.ToString();
                lblTotal.Text = total.ToString();

                // Clear session variables after displaying
                Session.Remove("LastQuizScore");
                Session.Remove("LastQuizTotal");
            }
            else
            {
                // No score in session - redirect back to home
                Response.Redirect("~/Pages/Student/StudentHome.aspx");
            }
        }

        /// <summary>
        /// Handles return home button click
        /// </summary>
        protected void btnReturnHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/Student/StudentHome.aspx");
        }
    }
}
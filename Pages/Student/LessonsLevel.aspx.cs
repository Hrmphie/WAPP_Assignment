using System;
using System.Web.UI;

namespace WAPP_Assignment.Pages.Student
{
    public partial class LessonsLevel : Page
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
            }
        }

        /// <summary>
        /// Handles Level 1 (Beginner) button click
        /// </summary>
        protected void btnLevel1_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/Student/LessonsPage.aspx?level=1");
        }

        /// <summary>
        /// Handles Level 2 (Intermediate) button click
        /// </summary>
        protected void btnLevel2_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/Student/LessonsPage.aspx?level=2");
        }

        /// <summary>
        /// Handles Level 3 (Advanced) button click
        /// </summary>
        protected void btnLevel3_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/Student/LessonsPage.aspx?level=3");
        }
    }
}
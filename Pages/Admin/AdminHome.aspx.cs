using System;
using System.Web.UI;

namespace WAPP_Assignment.Pages.Admin
{
    public partial class AdminHome : Page
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

                // Check if user is actually an admin
                if (Session["Role"].ToString() != "Admin")
                {
                    Response.Redirect("~/Pages/Student/StudentHome.aspx");
                    return;
                }

                // Load admin information
                LoadAdminInfo();
            }
        }

        /// <summary>
        /// Loads the current admin's information and displays username
        /// </summary>
        private void LoadAdminInfo()
        {
            if (Session["Username"] != null)
            {
                lblUsername.Text = Session["Username"].ToString();
            }
        }

        /// <summary>
        /// Handles Manage Users button click - navigates to Manage Users page
        /// </summary>
        protected void btnManageUsers_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/Admin/ManageUsers.aspx");
        }

        /// <summary>
        /// Handles View Lessons/Quizzes button click - navigates to ViewQuizzesAndLessons page
        /// </summary>
        protected void btnViewContent_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/Admin/ViewQuizzesAndLessons.aspx");
        }

        /// <summary>
        /// Handles Manage Messages button click - navigates to Manage Messages page
        /// </summary>
        protected void btnManageMessages_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/Admin/ManageMessages.aspx");
        }
    }
}
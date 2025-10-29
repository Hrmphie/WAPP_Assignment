using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WAPP_Assignment
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ConfigureNavigation();
            }
        }

        /// <summary>
        /// Configures the navigation links based on user's login status and role
        /// </summary>
        private void ConfigureNavigation()
        {
            // Check if user is logged in
            if (Session["UserID"] != null && Session["Role"] != null)
            {
                // User is logged in - show logout button
                btnLogout.Visible = true;

                // Configure Home link based on user role
                string role = Session["Role"].ToString();

                if (role == "Admin")
                {
                    lnkHome.NavigateUrl = "~/Pages/Admin/AdminHome.aspx";
                }
                else if (role == "Student")
                {
                    lnkHome.NavigateUrl = "~/Pages/Student/StudentHome.aspx";
                }
                else
                {
                    // Default fallback
                    lnkHome.NavigateUrl = "~/Pages/Global/Login.aspx";
                }
            }
            else
            {
                // User is not logged in - hide logout button
                btnLogout.Visible = false;

                // Home link goes to login page for non-authenticated users
                lnkHome.NavigateUrl = "~/Pages/Global/Login.aspx";
            }
        }

        /// <summary>
        /// Handles the logout button click event
        /// Clears session and redirects to login page
        /// </summary>
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Clear all session variables
            Session.Clear();

            // Abandon the session
            Session.Abandon();

            // Optional: Clear authentication cookie if using FormsAuthentication
            if (Request.Cookies[".ASPXAUTH"] != null)
            {
                HttpCookie authCookie = new HttpCookie(".ASPXAUTH")
                {
                    Expires = DateTime.Now.AddDays(-1)
                };
                Response.Cookies.Add(authCookie);
            }

            // Redirect to login page
            Response.Redirect("~/Pages/Global/Login.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }

        /// <summary>
        /// Gets the currently logged in username (for display purposes)
        /// </summary>
        public string GetCurrentUsername()
        {
            if (Session["Username"] != null)
            {
                return Session["Username"].ToString();
            }
            return "Guest";
        }

        /// <summary>
        /// Gets the current user's role
        /// </summary>
        public string GetCurrentUserRole()
        {
            if (Session["Role"] != null)
            {
                return Session["Role"].ToString();
            }
            return "None";
        }

        /// <summary>
        /// Checks if the current user is authenticated
        /// </summary>
        public bool IsUserAuthenticated()
        {
            return Session["UserID"] != null;
        }

        /// <summary>
        /// Checks if the current user is an admin
        /// </summary>
        public bool IsUserAdmin()
        {
            return Session["Role"] != null && Session["Role"].ToString() == "Admin";
        }

        /// <summary>
        /// Checks if the current user is a student
        /// </summary>
        public bool IsUserStudent()
        {
            return Session["Role"] != null && Session["Role"].ToString() == "Student";
        }
    }
}
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WAPP_Assignment.Pages.Admin
{
    public partial class ManageMessages : Page
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

                // Load all messages
                LoadMessages();
            }
        }

        /// <summary>
        /// Loads all contact messages from database and displays them
        /// </summary>
        private void LoadMessages()
        {
            try
            {
                List<ContactMessage> messages = GetAllMessages();

                if (messages.Count > 0)
                {
                    // Show messages list
                    pnlMessagesList.Visible = true;
                    pnlNoMessages.Visible = false;

                    // Bind to repeater
                    rptMessages.DataSource = messages;
                    rptMessages.DataBind();

                    // Update total count
                    lblTotalMessages.Text = messages.Count.ToString();
                }
                else
                {
                    // No messages found
                    pnlMessagesList.Visible = false;
                    pnlNoMessages.Visible = true;
                    lblTotalMessages.Text = "0";
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error loading messages: " + ex.Message);
                pnlMessagesList.Visible = false;
                pnlNoMessages.Visible = true;
            }
        }

        /// <summary>
        /// Gets all contact messages from database
        /// </summary>
        private List<ContactMessage> GetAllMessages()
        {
            // TODO: Replace with actual database query
            /*
            List<ContactMessage> messages = new List<ContactMessage>();
            
            using (SqlConnection conn = DatabaseHelper.GetConnection())
            {
                string query = @"SELECT MessageID, Name, Email, Subject, Message, DateSubmitted
                               FROM ContactMessages
                               ORDER BY DateSubmitted DESC";
                
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                
                while (reader.Read())
                {
                    messages.Add(new ContactMessage
                    {
                        MessageID = Convert.ToInt32(reader["MessageID"]),
                        Name = reader["Name"].ToString(),
                        Email = reader["Email"].ToString(),
                        Subject = reader["Subject"].ToString(),
                        Message = reader["Message"].ToString(),
                        DateSubmitted = Convert.ToDateTime(reader["DateSubmitted"])
                    });
                }
                
                reader.Close();
                conn.Close();
            }
            
            return messages;
            */

            // Mock data for testing
            return GetMockMessages();
        }

        /// <summary>
        /// Generates mock contact messages for testing
        /// </summary>
        private List<ContactMessage> GetMockMessages()
        {
            List<ContactMessage> messages = new List<ContactMessage>
            {
                new ContactMessage
                {
                    MessageID = 1,
                    Name = "John Smith",
                    Email = "john.smith@example.com",
                    Subject = "Question about registration",
                    Message = "Hello,\n\nI'm trying to register my child but I'm having some issues with the age verification. Can you please help?\n\nThank you,\nJohn",
                    DateSubmitted = DateTime.Now.AddHours(-2)
                },
                new ContactMessage
                {
                    MessageID = 2,
                    Name = "Sarah Johnson",
                    Email = "sarah.j@example.com",
                    Subject = "Feature request",
                    Message = "Hi MathVenture team,\n\nI love your platform! My daughter has been using it for a week now and she's really enjoying the quizzes. I was wondering if you could add more advanced topics like basic algebra?\n\nKeep up the great work!",
                    DateSubmitted = DateTime.Now.AddHours(-5)
                },
                new ContactMessage
                {
                    MessageID = 3,
                    Name = "Michael Brown",
                    Email = "m.brown@example.com",
                    Subject = "Technical support needed",
                    Message = "The progress bar on my son's account seems to be stuck at 0% even though he's completed several quizzes. Could you please look into this?\n\nUsername: student1\n\nThanks!",
                    DateSubmitted = DateTime.Now.AddDays(-1)
                },
                new ContactMessage
                {
                    MessageID = 4,
                    Name = "Emily Davis",
                    Email = "emily.davis@school.com",
                    Subject = "School partnership inquiry",
                    Message = "Dear MathVenture,\n\nI'm a teacher at Springfield Elementary and I'm very impressed with your platform. I would like to discuss the possibility of using MathVenture for our entire 3rd grade class.\n\nPlease contact me at your earliest convenience.\n\nBest regards,\nEmily Davis",
                    DateSubmitted = DateTime.Now.AddDays(-2)
                },
                new ContactMessage
                {
                    MessageID = 5,
                    Name = "David Wilson",
                    Email = "d.wilson@parent.com",
                    Subject = "Password reset request",
                    Message = "Hi,\n\nI forgot my password and can't log in. I've tried the forgot password link but I'm not receiving any emails. Can you help me reset my account?\n\nAccount email: d.wilson@parent.com",
                    DateSubmitted = DateTime.Now.AddDays(-3)
                }
            };

            return messages;
        }

        /// <summary>
        /// Handles message deletion
        /// </summary>
        protected void rptMessages_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteMessage")
            {
                try
                {
                    int messageID = Convert.ToInt32(e.CommandArgument);
                    bool success = DeleteMessage(messageID);

                    if (success)
                    {
                        // Reload messages after deletion
                        LoadMessages();
                    }
                    else
                    {
                        Response.Write("<script>alert('Failed to delete message. Please try again.');</script>");
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("Error deleting message: " + ex.Message);
                    Response.Write("<script>alert('An error occurred while deleting the message.');</script>");
                }
            }
        }

        /// <summary>
        /// Deletes a contact message from database
        /// </summary>
        private bool DeleteMessage(int messageID)
        {
            try
            {
                // TODO: Replace with actual database delete
                /*
                using (SqlConnection conn = DatabaseHelper.GetConnection())
                {
                    string query = "DELETE FROM ContactMessages WHERE MessageID = @MessageID";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@MessageID", messageID);
                    
                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    conn.Close();
                    
                    return rowsAffected > 0;
                }
                */

                // Mock success
                System.Diagnostics.Debug.WriteLine($"Message {messageID} deleted successfully");
                return true;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error in DeleteMessage: " + ex.Message);
                return false;
            }
        }

        /// <summary>
        /// ContactMessage class to hold message data
        /// </summary>
        public class ContactMessage
        {
            public int MessageID { get; set; }
            public string Name { get; set; }
            public string Email { get; set; }
            public string Subject { get; set; }
            public string Message { get; set; }
            public DateTime DateSubmitted { get; set; }
        }
    }
}
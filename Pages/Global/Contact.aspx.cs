using System;
using System.Web.UI;

namespace WAPP_Assignment.Pages.Global
{
    public partial class Contact : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // No specific logic needed on page load
        }

        /// <summary>
        /// Handles contact form submission
        /// </summary>
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            try
            {
                // Get form values
                string name = txtName.Text.Trim();
                string email = txtEmail.Text.Trim();
                string subject = txtSubject.Text.Trim();
                string message = txtMessage.Text.Trim();

                // Save contact message to database or send email
                bool success = SaveContactMessage(name, email, subject, message);

                if (success)
                {
                    ShowSuccess("Thank you for contacting us! We'll get back to you soon.");

                    // Clear form fields
                    ClearForm();
                }
                else
                {
                    ShowError("Failed to send message. Please try again.");
                }
            }
            catch (Exception ex)
            {
                ShowError("An error occurred while sending your message. Please try again.");
                System.Diagnostics.Debug.WriteLine("Contact form error: " + ex.Message);
            }
        }

        /// <summary>
        /// Saves contact message to database or sends email
        /// </summary>
        private bool SaveContactMessage(string name, string email, string subject, string message)
        {
            try
            {
                // TODO: Implement one of the following:
                // Option 1: Save to database
                /*
                using (SqlConnection conn = DatabaseHelper.GetConnection())
                {
                    string query = @"INSERT INTO ContactMessages (Name, Email, Subject, Message, DateSubmitted)
                                   VALUES (@Name, @Email, @Subject, @Message, @DateSubmitted)";
                    
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Subject", subject);
                    cmd.Parameters.AddWithValue("@Message", message);
                    cmd.Parameters.AddWithValue("@DateSubmitted", DateTime.Now);
                    
                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    conn.Close();
                    
                    return rowsAffected > 0;
                }
                */

                // Option 2: Send email notification
                /*
                using (System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient())
                {
                    System.Net.Mail.MailMessage mail = new System.Net.Mail.MailMessage();
                    mail.From = new System.Net.Mail.MailAddress(email);
                    mail.To.Add("support@mathventure.com");
                    mail.Subject = $"Contact Form: {subject}";
                    mail.Body = $"Name: {name}\nEmail: {email}\n\nMessage:\n{message}";
                    
                    smtp.Send(mail);
                    return true;
                }
                */

                // Mock success for now
                System.Diagnostics.Debug.WriteLine($"Contact message from {name} ({email}): {subject}");
                System.Diagnostics.Debug.WriteLine($"Message: {message}");

                return true;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error saving contact message: " + ex.Message);
                return false;
            }
        }

        /// <summary>
        /// Clears all form fields after successful submission
        /// </summary>
        private void ClearForm()
        {
            txtName.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtSubject.Text = string.Empty;
            txtMessage.Text = string.Empty;
        }

        /// <summary>
        /// Shows success message to user
        /// </summary>
        private void ShowSuccess(string message)
        {
            lblSuccess.Text = message;
            pnlSuccess.Visible = true;
            pnlError.Visible = false;
        }

        /// <summary>
        /// Shows error message to user
        /// </summary>
        private void ShowError(string message)
        {
            lblError.Text = message;
            pnlError.Visible = true;
            pnlSuccess.Visible = false;
        }
    }
}
<%@ Page Title="Contact Us" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="WAPP_Assignment.Pages.Global.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .contact-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        .contact-header {
            text-align: center;
            margin-bottom: 50px;
        }

        .contact-title {
            font-size: 56px;
            color: #667eea;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .contact-subtitle {
            font-size: 24px;
            color: #666;
        }

        .contact-content {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
            margin-top: 40px;
        }

        .contact-form-section {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .contact-info-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 40px;
            border-radius: 20px;
            color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .section-title {
            font-size: 32px;
            font-weight: bold;
            margin-bottom: 25px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            font-size: 16px;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }

        .form-input,
        .form-textarea {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            border: 2px solid #ddd;
            border-radius: 10px;
            box-sizing: border-box;
            font-family: 'Comic Sans MS', 'Arial', sans-serif;
            transition: border-color 0.3s;
        }

        .form-input:focus,
        .form-textarea:focus {
            outline: none;
            border-color: #667eea;
        }

        .form-textarea {
            resize: vertical;
            min-height: 120px;
        }

        .btn-submit {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: 'Comic Sans MS', 'Arial', sans-serif;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }

        .contact-info-item {
            display: flex;
            align-items: flex-start;
            gap: 15px;
            margin-bottom: 30px;
        }

        .info-icon {
            font-size: 32px;
            margin-top: 5px;
        }

        .info-content {
            flex: 1;
        }

        .info-title {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 8px;
        }

        .info-text {
            font-size: 16px;
            line-height: 1.6;
            opacity: 0.95;
        }

        .social-links {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .social-icon {
            width: 50px;
            height: 50px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            cursor: pointer;
            transition: background 0.3s;
        }

        .social-icon:hover {
            background: rgba(255, 255, 255, 0.4);
        }

        .success-message {
            background: #e8f5e9;
            color: #2e7d32;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
            font-weight: 600;
        }

        .error-message {
            background: #ffebee;
            color: #c62828;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
            font-weight: 600;
        }

        .validator-text {
            color: #c62828;
            font-size: 13px;
            margin-top: 4px;
            display: block;
        }

        @media (max-width: 768px) {
            .contact-content {
                grid-template-columns: 1fr;
            }
        }
    </style>

    <div class="contact-container">
        <!-- Header -->
        <div class="contact-header">
            <h1 class="contact-title">Contact Us</h1>
            <p class="contact-subtitle">We'd love to hear from you!</p>
        </div>

        <div class="contact-content">
            <!-- Contact Form Section -->
            <div class="contact-form-section">
                <h2 class="section-title" style="color: #667eea;">Send us a Message</h2>

                <!-- Success Message -->
                <asp:Panel ID="pnlSuccess" runat="server" CssClass="success-message" Visible="false">
                    <asp:Label ID="lblSuccess" runat="server"></asp:Label>
                </asp:Panel>

                <!-- Error Message -->
                <asp:Panel ID="pnlError" runat="server" CssClass="error-message" Visible="false">
                    <asp:Label ID="lblError" runat="server"></asp:Label>
                </asp:Panel>

                <!-- Name -->
                <div class="form-group">
                    <label class="form-label">Your Name</label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-input" placeholder="Enter your name"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvName" runat="server" 
                        ControlToValidate="txtName" 
                        ErrorMessage="Name is required" 
                        CssClass="validator-text"
                        Display="Dynamic">
                    </asp:RequiredFieldValidator>
                </div>

                <!-- Email -->
                <div class="form-group">
                    <label class="form-label">Your Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input" placeholder="your.email@example.com"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                        ControlToValidate="txtEmail" 
                        ErrorMessage="Email is required" 
                        CssClass="validator-text"
                        Display="Dynamic">
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revEmail" runat="server" 
                        ControlToValidate="txtEmail"
                        ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"
                        ErrorMessage="Please enter a valid email address"
                        CssClass="validator-text"
                        Display="Dynamic">
                    </asp:RegularExpressionValidator>
                </div>

                <!-- Subject -->
                <div class="form-group">
                    <label class="form-label">Subject</label>
                    <asp:TextBox ID="txtSubject" runat="server" CssClass="form-input" placeholder="What is this about?"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvSubject" runat="server" 
                        ControlToValidate="txtSubject" 
                        ErrorMessage="Subject is required" 
                        CssClass="validator-text"
                        Display="Dynamic">
                    </asp:RequiredFieldValidator>
                </div>

                <!-- Message -->
                <div class="form-group">
                    <label class="form-label">Message</label>
                    <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" CssClass="form-textarea" placeholder="Write your message here..."></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvMessage" runat="server" 
                        ControlToValidate="txtMessage" 
                        ErrorMessage="Message is required" 
                        CssClass="validator-text"
                        Display="Dynamic">
                    </asp:RequiredFieldValidator>
                </div>

                <!-- Submit Button -->
                <asp:Button ID="btnSubmit" runat="server" Text="Send Message" CssClass="btn-submit" OnClick="btnSubmit_Click" />
            </div>

            <!-- Contact Information Section -->
            <div class="contact-info-section">
                <h2 class="section-title">Get in Touch</h2>

                <!-- Email -->
                <div class="contact-info-item">
                    <div class="info-icon">📧</div>
                    <div class="info-content">
                        <div class="info-title">Email Us</div>
                        <div class="info-text">
                            General: info@mathventure.com<br />
                            Support: support@mathventure.com
                        </div>
                    </div>
                </div>

                <!-- Phone -->
                <div class="contact-info-item">
                    <div class="info-icon">📱</div>
                    <div class="info-content">
                        <div class="info-title">Call Us</div>
                        <div class="info-text">
                            +1 (555) 123-4567<br />
                            Mon-Fri: 9:00 AM - 5:00 PM
                        </div>
                    </div>
                </div>

                <!-- Address -->
                <div class="contact-info-item">
                    <div class="info-icon">📍</div>
                    <div class="info-content">
                        <div class="info-title">Visit Us</div>
                        <div class="info-text">
                            123 Learning Street<br />
                            Education City, EC 12345<br />
                            Malaysia
                        </div>
                    </div>
                </div>

                <!-- Working Hours -->
                <div class="contact-info-item">
                    <div class="info-icon">🕐</div>
                    <div class="info-content">
                        <div class="info-title">Working Hours</div>
                        <div class="info-text">
                            Monday - Friday: 9:00 AM - 6:00 PM<br />
                            Saturday: 10:00 AM - 4:00 PM<br />
                            Sunday: Closed
                        </div>
                    </div>
                </div>

                <!-- Social Media -->
                <div style="margin-top: 40px;">
                    <div class="info-title" style="margin-bottom: 15px;">Follow Us</div>
                    <div class="social-links">
                        <div class="social-icon" title="Facebook">📘</div>
                        <div class="social-icon" title="Twitter">🐦</div>
                        <div class="social-icon" title="Instagram">📷</div>
                        <div class="social-icon" title="YouTube">📺</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
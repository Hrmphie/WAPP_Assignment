<%@ Page Title="Lessons" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LessonsPage.aspx.cs" Inherits="WAPP_Assignment.Pages.Student.LessonsPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .lessons-container {
            padding: 30px 20px;
            max-width: 1000px;
            margin: 0 auto;
        }

        .lessons-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .lesson-level-title {
            font-size: 42px;
            color: #667eea;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .lesson-level-subtitle {
            font-size: 24px;
            color: #999;
        }

        .lesson-section {
            display: flex;
            align-items: center;
            gap: 40px;
            margin-bottom: 60px;
            padding: 30px;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            border-radius: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            min-height: 400px;
        }

        .lesson-image-container {
            flex: 0 0 400px;
        }

        .lesson-image {
            width: 100%;
            height: auto;
            aspect-ratio: 3/2;
            object-fit: cover;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            background: white;
            padding: 20px;
        }

        .lesson-content {
            flex: 1;
            padding: 20px;
        }   

        .lesson-number {
            font-size: 20px;
            color: #667eea;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .lesson-text {
            font-size: 20px;
            line-height: 1.8;
            color: #333;
            text-align: justify;
        }

        .back-button {
            display: inline-block;
            padding: 15px 40px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-size: 18px;
            font-weight: 600;
            margin-top: 30px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border: none;
            cursor: pointer;
        }

        .back-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
        }

        @media (max-width: 768px) {
            .lesson-section {
                flex-direction: column;
                gap: 20px;
                padding: 20px;
                min-height: auto;
            }

            .lesson-image-container {
                flex: 0 0 auto;
                width: 100%;
            }

            .lesson-image {
                height: 250px;
            }

            .lesson-text {
                font-size: 18px;
            }
        }
    </style>

    <div class="lessons-container">
        <!-- Header -->
        <div class="lessons-header">
            <h1 class="lesson-level-title">
                <asp:Label ID="lblLevelTitle" runat="server" Text="Level 1"></asp:Label>
            </h1>
            <p class="lesson-level-subtitle">
                <asp:Label ID="lblLevelSubtitle" runat="server" Text="Beginner"></asp:Label>
            </p>
        </div>

        <!-- Lessons Content - Repeater for dynamic lesson sections -->
        <asp:Repeater ID="rptLessons" runat="server">
            <ItemTemplate>
                <div class="lesson-section">
                    <div class="lesson-image-container">
                        <img src='<%# Eval("ImagePath") %>' alt="Lesson Image" class="lesson-image" />
                    </div>
                    <div class="lesson-content">
                        <div class="lesson-number">Lesson <%# Eval("SectionNumber") %></div>
                        <p class="lesson-text"><%# Eval("ContentText") %></p>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <!-- Back Button -->
        <div style="text-align: center;">
            <asp:Button ID="btnBack" runat="server" Text="← Back to Levels" CssClass="back-button" OnClick="btnBack_Click" />
        </div>
    </div>
</asp:Content>
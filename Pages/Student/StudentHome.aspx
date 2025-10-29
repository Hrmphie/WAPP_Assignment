<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StudentHome.aspx.cs" Inherits="WAPP_Assignment.Pages.Student.StudentHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .student-home-container {
            text-align: center;
            padding: 20px;
        }

        .welcome-text {
            font-size: 36px;
            color: #667eea;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .subtitle-text {
            font-size: 20px;
            color: #666;
            margin-bottom: 30px;
        }

        .progress-section {
            margin: 30px auto;
            max-width: 600px;
        }

        .progress-title {
            font-size: 22px;
            color: #333;
            margin-bottom: 15px;
            font-weight: 600;
        }

        .progress-bar-container {
            background: #e0e0e0;
            border-radius: 25px;
            height: 40px;
            overflow: hidden;
            box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1);
            cursor: pointer;
            transition: transform 0.2s;
            position: relative;
        }

        .progress-bar-container:hover {
            transform: scale(1.02);
        }

        .progress-bar-fill {
            background: linear-gradient(90deg, #4facfe 0%, #00f2fe 100%);
            height: 100%;
            border-radius: 25px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 18px;
            transition: width 0.5s ease;
            min-width: 50px;
        }

        .progress-percentage {
            position: absolute;
            width: 100%;
            text-align: center;
            line-height: 40px;
            font-weight: bold;
            color: #333;
            z-index: 1;
        }

        .buttons-container {
            display: flex;
            gap: 40px;
            justify-content: center;
            margin-top: 50px;
            flex-wrap: wrap;
        }

        .nav-button {
            width: 400px;
            height: 350px;
            border-radius: 20px;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 30px;
            text-decoration: none;
        }

        .nav-button:hover {
            transform: translateY(-10px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.3);
        }

        .btn-lessons {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        }

        .btn-quizzes {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        }

        .button-label {
            font-size: 42px;
            font-weight: bold;
            color: white;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }

        .button-image {
            width: 200px;
            height: 200px;
            border-radius: 15px;
            background: white;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        @media (max-width: 968px) {
            .buttons-container {
                flex-direction: column;
                align-items: center;
            }

            .nav-button {
                width: 100%;
                max-width: 400px;
            }
        }
    </style>

    <div class="student-home-container">
        <h1 class="welcome-text">Welcome, <asp:Label ID="lblUsername" runat="server" Text="Student"></asp:Label>!</h1>
        <p class="subtitle-text">Let's continue your math adventure!</p>

        <!-- Progress Section -->
        <div class="progress-section">
            <h2 class="progress-title">Your Learning Progress</h2>
            <asp:LinkButton ID="lnkProgress" runat="server" CssClass="progress-bar-container" OnClick="lnkProgress_Click">
                <div class="progress-percentage">
                    <asp:Label ID="lblProgressPercentage" runat="server" Text="0%"></asp:Label>
                </div>
                <div class="progress-bar-fill" id="progressBarFill" runat="server" style="width: 0%;">
                </div>
            </asp:LinkButton>
        </div>

        <!-- Main Navigation Buttons -->
        <div class="buttons-container">
            <!-- Lessons Button -->
            <asp:LinkButton ID="btnLessons" runat="server" CssClass="nav-button btn-lessons" OnClick="btnLessons_Click">
                <span class="button-label">Lessons</span>
                <img src="https://via.placeholder.com/200/f5576c/ffffff?text=📚" alt="Lessons" class="button-image" />
            </asp:LinkButton>

            <!-- Quizzes Button -->
            <asp:LinkButton ID="btnQuizzes" runat="server" CssClass="nav-button btn-quizzes" OnClick="btnQuizzes_Click">
                <span class="button-label">Quizzes</span>
                <img src="https://via.placeholder.com/200/00f2fe/ffffff?text=✏️" alt="Quizzes" class="button-image" />
            </asp:LinkButton>
        </div>
    </div>
</asp:Content>
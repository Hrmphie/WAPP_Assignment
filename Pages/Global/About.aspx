<%@ Page Title="About Us" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="WAPP_Assignment.Pages.Global.About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .about-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        .about-header {
            text-align: center;
            margin-bottom: 50px;
        }

        .about-title {
            font-size: 56px;
            color: #667eea;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .about-subtitle {
            font-size: 24px;
            color: #666;
            margin-bottom: 30px;
        }

        .about-logo {
            width: 150px;
            height: 150px;
            margin: 20px auto;
            border-radius: 50%;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .about-section {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            padding: 40px;
            border-radius: 20px;
            margin-bottom: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .section-title {
            font-size: 32px;
            color: #667eea;
            font-weight: bold;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .section-icon {
            font-size: 40px;
        }

        .section-content {
            font-size: 18px;
            line-height: 1.8;
            color: #333;
            text-align: justify;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }

        .feature-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .feature-icon {
            font-size: 48px;
            margin-bottom: 15px;
        }

        .feature-title {
            font-size: 20px;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 10px;
        }

        .feature-description {
            font-size: 16px;
            color: #666;
            line-height: 1.6;
        }

        .team-section {
            text-align: center;
            margin-top: 40px;
        }

        .team-members {
            display: flex;
            justify-content: center;
            gap: 30px;
            flex-wrap: wrap;
            margin-top: 30px;
        }

        .team-member {
            background: white;
            padding: 25px;
            border-radius: 15px;
            width: 200px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .member-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            margin: 0 auto 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
            color: white;
        }

        .member-name {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
        }

        .member-role {
            font-size: 14px;
            color: #999;
        }
    </style>

    <div class="about-container">
        <!-- Header -->
        <div class="about-header">
            <h1 class="about-title">About MathVenture</h1>
            <img src="../../Content/images/MathVenture.png" alt="MathVenture Logo" class="about-logo" />
            <p class="about-subtitle">Making Math Fun and Engaging for Young Learners!</p>
        </div>

        <!-- Mission Section -->
        <div class="about-section">
            <h2 class="section-title">
                <span class="section-icon">🎯</span>
                Our Mission
            </h2>
            <p class="section-content">
                MathVenture is dedicated to transforming the way children learn mathematics. We believe that every child 
                can excel in math when learning is fun, interactive, and tailored to their pace. Our platform provides 
                an engaging, gamified learning experience designed specifically for young students aged 5-11, helping 
                them build confidence and develop a love for mathematics.
            </p>
        </div>

        <!-- What We Offer Section -->
        <div class="about-section">
            <h2 class="section-title">
                <span class="section-icon">✨</span>
                What We Offer
            </h2>
            <p class="section-content">
                MathVenture provides a comprehensive learning platform that combines interactive lessons with 
                engaging quizzes across three difficulty levels. Students can learn at their own pace, track their 
                progress, and celebrate their achievements along the way.
            </p>
            
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">📚</div>
                    <div class="feature-title">Interactive Lessons</div>
                    <p class="feature-description">
                        Colorful, engaging lessons with visuals and clear explanations for every concept.
                    </p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">✏️</div>
                    <div class="feature-title">Fun Quizzes</div>
                    <p class="feature-description">
                        Test your knowledge with interactive quizzes designed to reinforce learning.
                    </p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">📊</div>
                    <div class="feature-title">Progress Tracking</div>
                    <p class="feature-description">
                        Monitor your learning journey and see how much you've improved over time.
                    </p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">🎮</div>
                    <div class="feature-title">Gamified Learning</div>
                    <p class="feature-description">
                        Earn scores and complete levels to make learning feel like an adventure!
                    </p>
                </div>
            </div>
        </div>

        <!-- Why Choose Us Section -->
        <div class="about-section">
            <h2 class="section-title">
                <span class="section-icon">🌟</span>
                Why Choose MathVenture?
            </h2>
            <p class="section-content">
                <strong>Child-Friendly Design:</strong> Our interface is colorful, intuitive, and designed specifically 
                for young learners.<br /><br />
                
                <strong>Age-Appropriate Content:</strong> All lessons and quizzes are tailored for children ages 5-11, 
                ensuring content is both challenging and achievable.<br /><br />
                
                <strong>Safe Environment:</strong> MathVenture provides a secure, ad-free platform where children can 
                learn without distractions.<br /><br />
                
                <strong>Self-Paced Learning:</strong> Students can progress at their own speed, building confidence 
                before moving to more advanced topics.<br /><br />
                
                <strong>Parental Insight:</strong> Parents and teachers can monitor student progress and identify 
                areas that need extra attention.
            </p>
        </div>

        <!-- Team Section -->
        <div class="about-section team-section">
            <h2 class="section-title" style="justify-content: center;">
                <span class="section-icon">👥</span>
                Our Team
            </h2>
            <p class="section-content">
                MathVenture was created by a dedicated team of educators and developers passionate about making 
                education accessible and enjoyable for all children.
            </p>
            
            <div class="team-members">
                <div class="team-member">
                    <div class="member-avatar">👨‍💻</div>
                    <div class="member-name">Development Team</div>
                    <div class="member-role">Building the Platform</div>
                </div>
                
                <div class="team-member">
                    <div class="member-avatar">👩‍🏫</div>
                    <div class="member-name">Education Team</div>
                    <div class="member-role">Curriculum Design</div>
                </div>
                
                <div class="team-member">
                    <div class="member-avatar">🎨</div>
                    <div class="member-name">Design Team</div>
                    <div class="member-role">User Experience</div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
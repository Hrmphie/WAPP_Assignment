# MathVenture System - Detailed Workflow Documentation

## Table of Contents

1. [System Overview](#system-overview)
2. [Authentication & Registration](#authentication--registration)
3. [Admin Workflow](#admin-workflow)
4. [Teacher Workflow](#teacher-workflow)
5. [Student Workflow](#student-workflow)
6. [Guest User Workflow](#guest-user-workflow)
7. [Database Schema Overview](#database-schema-overview)
8. [Security Features](#security-features)

---

## System Overview

**MathVenture** is an educational web application built with ASP.NET Web Forms that provides a comprehensive learning management system for mathematics. The system supports three main user roles: **Admin**, **Teacher**, and **Student**, plus a **Guest** mode for limited access.

### Key Features

- **Lessons**: Three-level structured learning content (Beginner, Intermediate, Advanced)
- **Quizzes**: Interactive assessments tied to lesson levels
- **Assignments**: Teacher-created tasks with age-based targeting and grading
- **Progress Tracking**: Comprehensive student progress monitoring
- **Email Notifications**: Automated assignment notifications and OTP verification
- **User Management**: Complete CRUD operations for all user types

---

## Authentication & Registration

### Login Process

**Location**: `Pages/Global/Login.aspx`

#### Standard Login Flow:

1. **User Access**: User navigates to login page (default page)
2. **Input Validation**:
   - Username and password fields are validated
   - Form validation ensures required fields are filled
3. **Authentication**:
   - System queries `Users` table for matching username
   - Password is verified using `PasswordHelper.VerifyPassword()` (SHA256 with salt)
   - Password comparison uses secure constant-time comparison to prevent timing attacks
4. **Session Creation**:
   - Upon successful authentication, session variables are set:
     - `Session["UserID"]` - User's unique identifier
     - `Session["Username"]` - User's display name
     - `Session["Role"]` - User's role (Admin/Teacher/Student)
     - `Session["LoginTime"]` - Timestamp of login
5. **Role-Based Redirect**:
   - **Admin** → `~/Pages/Admin/AdminHome.aspx`
   - **Teacher** → `~/Pages/Teacher/TeacherHome.aspx`
   - **Student** → `~/Pages/Student/StudentHome.aspx`
   - **Guest** → `~/Pages/Student/LessonsLevel.aspx`

#### Guest Login Flow:

1. User clicks "Guest Login" button
2. System creates a guest session with:
   - `Session["UserID"] = -1` (special identifier)
   - `Session["Username"] = "Guest"`
   - `Session["Role"] = "Guest"`
3. Guest is redirected to Lessons Level page (read-only access to lessons)

### Registration Process

**Location**: `Pages/Global/Register.aspx`

#### Student Registration (Email Verification Required):

1. **Email Entry Phase**:
   - Student enters email address
   - System checks if email already exists in database
   - If unique, proceeds to OTP generation
2. **OTP Generation & Sending**:
   - System generates 6-digit OTP using `OTPHelper.GenerateOTP()`
   - OTP is stored in session with timestamp (10-minute expiry)
   - Email is sent via `EmailService.SendOTPEmail()` using SMTP (Gmail configured)
   - HTML email template includes verification code
3. **OTP Verification Phase**:
   - Student enters OTP code received via email
   - System validates:
     - OTP matches stored value
     - Email matches stored email
     - OTP hasn't expired (10 minutes)
   - If valid, proceeds to registration form
4. **Registration Form Completion**:
   - Student fills in:
     - Username (must be unique)
     - Email (pre-filled, read-only, must match verified email)
     - Password (hashed with salt using SHA256)
     - Age (integer)
     - Gender (selection)
   - System validates all fields
   - Password is hashed using `PasswordHelper.HashPassword()`:
     - Generates random 16-byte salt
     - Creates SHA256 hash of password + salt
     - Stores as `salt:hash` format
   - User record is inserted into `Users` table
   - Session verification email is cleared
   - Redirect to login page with success message

#### Admin/Teacher Registration (No Email Verification):

1. **Direct Registration**:
   - Admin/Teacher registration can be accessed via query parameter: `?role=Admin` or `?role=Teacher`
   - No email verification required
   - Form includes same fields as student registration
   - Password hashing follows same process
   - After registration, redirects to Admin's Manage Users page

#### Registration Access Points:

- **Students**: Public registration page
- **Admins**: Accessed via Admin's Manage Users page (`?source=admin&role=Admin`)
- **Teachers**: Accessed via Admin's Manage Users page (`?source=admin&role=Teacher`)

---

## Admin Workflow

### Admin Home Page

**Location**: `Pages/Admin/AdminHome.aspx`

#### Access Control:

- Requires valid session with `Role = "Admin"`
- Redirects to login if not authenticated
- Redirects to Student Home if wrong role

#### Dashboard Features:

1. **Welcome Display**: Shows admin's username
2. **Navigation Options**:
   - **Manage Users** → User management interface
   - **View Content** → View quizzes and lessons (redirects to `ViewQuizzesAndLessons.aspx`)
   - **Manage Messages** → Contact message management

### Manage Users

**Location**: `Pages/Admin/ManageUsers.aspx`

#### User Management Features:

1. **Filter System**:

   - **All Users**: Shows all registered users (default hidden)
   - **Students**: Filters to show only students
   - **Admins**: Filters to show only admins
   - **Teachers**: Filters to show only teachers
   - Filter state persists via ViewState

2. **User List Display**:

   - Shows user information:
     - Username
     - Email
     - Age
     - Gender
     - Role (with color-coded badges)
     - Date Registered
   - Total user count displayed
   - Users sorted by registration date (newest first)

3. **User Actions**:

   - **View User**: Clicking on a user redirects to `ViewUser.aspx?userID={id}&filter={currentFilter}`
   - **Register New User**: Link changes based on filter:
     - Students: `~/Pages/Global/Register.aspx?source=admin`
     - Admins: `~/Pages/Global/Register.aspx?source=admin&role=Admin`
     - Teachers: `~/Pages/Global/Register.aspx?source=admin&role=Teacher`

4. **Navigation**:
   - Back button returns to Admin Home

### View User Details

**Location**: `Pages/Admin/ViewUser.aspx`

#### User Detail View:

1. **User Information Display**:

   - UserID
   - Username
   - Email
   - Age
   - Gender
   - Role (with styled badge)
   - Date Registered (formatted)

2. **User Actions**:
   - **Delete User**:
     - Cannot delete own account (validation check)
     - Deletion process:
       1. Deletes all `Progress` records for user
       2. Attempts to delete `ContactMessages` (if UserID column exists)
       3. Deletes user from `Users` table
     - Uses database transaction for atomicity
     - Redirects back to Manage Users with filter preserved
   - **Back Button**: Returns to Manage Users with filter state

### Manage Messages

**Location**: `Pages/Admin/ManageMessages.aspx`

#### Contact Message Management:

1. **Message List**:

   - Displays all contact messages from `ContactMessages` table
   - Shows:
     - Message ID
     - Name
     - Email
     - Subject
     - Message content
     - Date Submitted (sorted newest first)
   - Total message count displayed

2. **Message Actions**:

   - **Delete Message**:
     - Removes message from database
     - Refreshes list after deletion
     - Shows error alert if deletion fails

3. **Navigation**:
   - Back button returns to Admin Home

### View Content (Quizzes and Lessons)

**Location**: `Pages/Admin/ViewQuizzesAndLessons.aspx` (referenced but file may not exist)

**Note**: This page is referenced in AdminHome but the actual implementation file may be missing from the codebase.

---

## Teacher Workflow

### Teacher Home Page

**Location**: `Pages/Teacher/TeacherHome.aspx`

#### Access Control:

- Requires valid session with `Role = "Teacher"`
- Redirects to login if not authenticated
- Redirects to Student Home if wrong role

#### Dashboard Features:

1. **Welcome Display**: Shows teacher's username with teacher badge emoji
2. **Navigation Options**:
   - **Manage Assignments** → Assignment management interface
   - **Grade Assignments** → Grading interface for student submissions

### Manage Assignments

**Location**: `Pages/Teacher/ManageAssignments.aspx`

#### Assignment Management:

1. **Assignment List**:

   - Displays all assignments created by the logged-in teacher
   - Shows for each assignment:
     - Assignment ID
     - Question text
     - Due date
     - Age range (min-max)
     - Created date
     - Submission count (number of students who submitted)
   - Sorted by creation date (newest first)
   - Shows "No assignments" message if empty

2. **Assignment Actions**:

   - **View Assignment**: Clicking on assignment redirects to `AssignmentDetails.aspx?assignmentID={id}`
   - **Create New Assignment**: Link to `CreateAssignment.aspx`

3. **Navigation**:
   - Back button returns to Teacher Home

### Create Assignment

**Location**: `Pages/Teacher/CreateAssignment.aspx`

#### Assignment Creation Process:

1. **Form Fields**:

   - **Question**: Text input for assignment question (required)
   - **Due Date**: Date/time picker (required, must be future date)
   - **Age Minimum**: Integer input (required)
   - **Age Maximum**: Integer input (required)
   - Validation: Age min must be ≤ age max

2. **Validation**:

   - All fields required
   - Due date must be in future
   - Age range must be valid (min ≤ max)
   - Age values must be valid integers

3. **Assignment Creation**:

   - Assignment saved to `Assignments` table with:
     - `TeacherID` (from session)
     - `Question`
     - `DueDate`
     - `AgeMin`
     - `AgeMax`
     - `CreatedDate` (current timestamp)

4. **Email Notification System**:

   - After assignment creation, system:
     1. Queries `Users` table for students matching age range:
        - `Role = 'Student'`
        - `Age >= AgeMin AND Age <= AgeMax`
        - Has valid email address
     2. For each eligible student:
        - Sends email notification via `EmailService.SendAssignmentNotification()`
        - Email includes:
          - Student's name
          - Assignment question
          - Due date (formatted)
          - Age range
          - Direct link to assignment submission page
        - HTML email template with styled design
     3. Logs success/failure counts for debugging

5. **Post-Creation**:
   - Redirects to `ManageAssignments.aspx?created=true`
   - Assignment appears in teacher's assignment list

### Assignment Details

**Location**: `Pages/Teacher/AssignmentDetails.aspx`

#### Assignment Detail View:

1. **Assignment Information Display**:

   - Assignment ID
   - Question text
   - Due date (formatted)
   - Age range (min - max)
   - Submission count (total submissions received)

2. **Assignment Actions**:
   - **Edit Assignment**: Redirects to `EditAssignment.aspx?assignmentID={id}`
   - **Delete Assignment**:
     - Verifies teacher ownership before deletion
     - Deletes assignment from database
     - Note: Submissions may remain (depending on database constraints)
     - Redirects to Manage Assignments with success message
   - **Back Button**: Returns to Manage Assignments

### Edit Assignment

**Location**: `Pages/Teacher/EditAssignment.aspx`

#### Assignment Editing Process:

1. **Load Assignment**:

   - Retrieves assignment by ID
   - Verifies teacher ownership
   - Pre-fills question field with current question
   - Redirects if assignment not found or not owned

2. **Edit Form**:

   - Only question text can be edited
   - Due date and age range are not editable (by design)

3. **Update Process**:

   - Validates question is not empty
   - Verifies ownership again before update
   - Updates `Assignments` table
   - Redirects to Assignment Details with success message

4. **Navigation**:
   - Back button returns to Assignment Details

### Grade Assignments

**Location**: `Pages/Teacher/GradeAssignments.aspx`

#### Grading Interface:

1. **Submission List**:

   - Displays all ungraded submissions for assignments created by the teacher
   - Shows for each submission:
     - Submission ID
     - Assignment ID
     - Student name (from Users table)
     - Answer text
     - Submitted date
   - Sorted by submission date (newest first)
   - Only shows submissions where `Grade IS NULL`

2. **Submission Actions**:

   - **Grade Submission**: Clicking redirects to `GradeSubmission.aspx?submissionID={id}`

3. **Navigation**:
   - Back button returns to Teacher Home

### Grade Submission

**Location**: `Pages/Teacher/GradeSubmission.aspx`

#### Grading Process:

1. **Submission Display**:

   - Shows submission details:
     - Student name
     - Assignment ID
     - Submitted date (formatted)
     - Assignment question
     - Student's answer

2. **Grading Form**:

   - **Grade Dropdown**: Select grade (typically 0-100 scale)
   - **Feedback Textbox**: Required text feedback for student
   - Both fields required before submission

3. **Grading Submission**:

   - Validates feedback is not empty
   - Verifies submission exists and belongs to teacher's assignment
   - Updates `AssignmentSubmissions` table:
     - Sets `Grade`
     - Sets `Feedback`
     - Sets `GradedDate` (current timestamp)
     - Sets `GradedBy` (teacher's UserID)
   - Redirects to Grade Assignments with success message

4. **Navigation**:
   - Back button returns to Grade Assignments

---

## Student Workflow

### Student Home Page

**Location**: `Pages/Student/StudentHome.aspx`

#### Access Control:

- Requires valid session with `Role = "Student"`
- Redirects to login if not authenticated
- Redirects to Admin Home if wrong role

#### Dashboard Features:

1. **Welcome Display**: Shows student's username

2. **Progress Overview**:

   - **Progress Percentage**: Calculated progress bar
   - Calculation method:
     - Retrieves all completed quiz attempts from `Progress` table
     - Groups by level and takes best score per level
     - Formula: `(total correct questions / total possible questions) × 100`
     - Total possible = (number of levels) × (questions per quiz, currently 3)
     - Uses best attempt per level to handle retakes

3. **Navigation Options**:
   - **Lessons Button** → `LessonsLevel.aspx`
   - **Quizzes Button** → `QuizzesLevel.aspx`
   - **Progress Link** → `Progress.aspx`

### Lessons System

#### Lessons Level Selection

**Location**: `Pages/Student/LessonsLevel.aspx`

**Access**: Available to both Students and Guests

1. **Level Selection**:

   - **Level 1 (Beginner)**: Redirects to `LessonsPage.aspx?level=1`
   - **Level 2 (Intermediate)**: Redirects to `LessonsPage.aspx?level=2`
   - **Level 3 (Advanced)**: Redirects to `LessonsPage.aspx?level=3`

2. **Navigation**:
   - **Back Button**:
     - Students → Returns to Student Home
     - Guests → Clears session and returns to Login

#### Lessons Page

**Location**: `Pages/Student/LessonsPage.aspx`

**Access**: Available to both Students and Guests

1. **Lesson Content Display**:

   - **Level Header**: Shows level number and name (Beginner/Intermediate/Advanced)
   - **YouTube Video**: Embedded video based on level:
     - Level 1: Video ID `mKSNQuQrsm0`
     - Level 2: Video ID `362JVVvgYPE`
     - Level 3: Video ID `Js45cR_7wFE`
   - **Lesson Sections**:
     - Retrieves lessons from `Lessons` table filtered by level
     - Displays:
       - Lesson images (if available)
       - Lesson content/description
       - Section numbers

2. **Navigation**:
   - **Back Button**: Returns to Lessons Level selection

### Quizzes System

#### Quizzes Level Selection

**Location**: `Pages/Student/QuizzesLevel.aspx`

**Access**: Students only (Guests cannot access quizzes)

1. **Level Selection**:

   - **Level 1 (Beginner)**: Redirects to `QuizzesPage.aspx?level=1`
   - **Level 2 (Intermediate)**: Redirects to `QuizzesPage.aspx?level=2`
   - **Level 3 (Advanced)**: Redirects to `QuizzesPage.aspx?level=3`

2. **Additional Navigation**:
   - **Assignments Button**: Redirects to `AssignmentsHome.aspx`
   - **Back Button**: Returns to Student Home

#### Quizzes Page

**Location**: `Pages/Student/QuizzesPage.aspx`

**Access**: Students only

1. **Quiz Loading**:

   - Retrieves top 3 quizzes from database for selected level
   - Queries `Quizzes` table joined with `Lessons` table
   - Filters by level and orders by QuizID

2. **Quiz Display**:

   - Each question shows:
     - Question image (if available, placeholder otherwise)
     - Question text
     - Four multiple-choice options (A, B, C, D)
     - Radio button selection for each option

3. **Quiz Submission**:

   - **Validation**: All three questions must be answered
   - **Scoring**:
     - Compares student answers with correct answers
     - Calculates score (number of correct answers)
     - Stores in session:
       - `Session["LastQuizScore"]`
       - `Session["LastQuizTotal"]` (always 3)
       - `Session["LastLessonID"]` (from first quiz's lesson)

4. **Results Display**:

   - Shows score (e.g., "2 out of 3")
   - Displays detailed results for each question:
     - Question text
     - Student's answer
     - Correct answer
     - Correct/Incorrect indicator
   - Hides quiz questions and submit button
   - Disables radio buttons (read-only)

5. **Continue Action**:

   - **Continue Button**: Redirects to `Submitted.aspx` to save progress

6. **Navigation**:
   - **Back Button**: Returns to Quizzes Level selection

#### Submitted Page

**Location**: `Pages/Student/Submitted.aspx`

**Access**: Students only

1. **Score Display**:

   - Shows quiz score from session (e.g., "2 out of 3")
   - Displays score and total questions

2. **Progress Saving**:

   - Saves quiz attempt to `Progress` table:
     - `UserID` (from session)
     - `LessonID` (from session)
     - `Score` (number of correct answers)
     - `IsCompleted = 1`
     - `LastAccessed` (current timestamp)
   - **Important**: Always inserts new record (allows retakes/history)
   - Does not update existing records

3. **Session Cleanup**:

   - Clears quiz-related session variables after display

4. **Navigation**:
   - **Return Home Button**: Returns to Student Home

### Progress Tracking

#### Progress Page

**Location**: `Pages/Student/Progress.aspx`

**Access**: Students only

1. **Progress Data Loading**:

   - Retrieves all completed quiz attempts from `Progress` table
   - Joins with `Lessons` table to get level information
   - Filters by `IsCompleted = 1`
   - Orders by `LastAccessed` (newest first)

2. **Best Attempts Display**:

   - Groups attempts by level
   - Shows best (highest) score for each level
   - If multiple attempts have same best score, shows most recent
   - Displays for each level:
     - Level number and name
     - Best score (e.g., "2/3")
     - Date completed
     - "View All Attempts" button

3. **Statistics Calculation**:

   - **Total Attempts**: Count of all quiz attempts
   - **Average Score**: Average percentage across all attempts
   - **Completion Rate**:
     - Formula: `(total correct questions / total possible questions) × 100`
     - Uses best score per level (handles retakes)
     - Total possible = (number of levels) × (questions per quiz)

4. **Level Attempts View**:

   - Clicking "View All Attempts" redirects to `LevelAttempts.aspx?level={level}`

5. **Navigation**:
   - **Back Button**: Returns to Student Home

#### Level Attempts Page

**Location**: `Pages/Student/LevelAttempts.aspx`

**Access**: Students only

1. **Attempt History**:

   - Shows all quiz attempts for a specific level
   - Displays:
     - Attempt ID
     - Score (e.g., "2/3")
     - Date completed (formatted)
   - Sorted by date (newest first)

2. **Navigation**:
   - **Back Button**: Returns to Progress page

### Assignments System

#### Assignments Home

**Location**: `Pages/Student/AssignmentsHome.aspx`

**Access**: Students only

1. **Navigation Options**:

   - **Pending Assignments**: Redirects to `PendingAssignments.aspx`
   - **Past Assignments**: Redirects to `PastAssignments.aspx`

2. **Navigation**:
   - **Back Button**: Returns to Quizzes Level page

#### Pending Assignments

**Location**: `Pages/Student/PendingAssignments.aspx`

**Access**: Students only

1. **Assignment Filtering**:

   - Retrieves assignments that:
     - Match student's age (`AgeMin <= studentAge <= AgeMax`)
     - Due date hasn't passed (`DueDate > current date`)
     - Student hasn't submitted yet (no record in `AssignmentSubmissions`)
   - Sorted by due date (earliest first)

2. **Assignment List Display**:

   - Shows for each assignment:
     - Assignment ID
     - Question text
     - Due date (formatted)
   - Shows "No assignments" message if empty

3. **Assignment Actions**:

   - **Answer Assignment**: Clicking redirects to `AssignmentSubmission.aspx?assignmentID={id}`

4. **Navigation**:
   - **Back Button**: Returns to Assignments Home

#### Assignment Submission

**Location**: `Pages/Student/AssignmentSubmission.aspx`

**Access**: Students only

1. **Assignment Display**:

   - Shows assignment details:
     - Assignment ID
     - Question text
     - Due date (formatted)
   - Validates assignment exists
   - Checks if due date has passed (disables submission if expired)

2. **Submission Validation**:

   - Checks if student already submitted (prevents duplicate submissions)
   - Validates due date hasn't passed
   - Validates assignment still exists

3. **Answer Submission**:

   - Student enters answer in text area
   - **Submit Button**:
     - Validates answer is not empty
     - Saves to `AssignmentSubmissions` table:
       - `AssignmentID`
       - `UserID` (from session)
       - `Answer` (text)
       - `SubmittedDate` (current timestamp)
     - Redirects to Pending Assignments with success message

4. **Navigation**:
   - **Back Button**: Returns to Pending Assignments

#### Past Assignments

**Location**: `Pages/Student/PastAssignments.aspx`

**Access**: Students only

1. **Filter System**:

   - **All**: Shows all submitted assignments
   - **Graded**: Shows only graded assignments
   - **Ungraded**: Shows only ungraded assignments
   - Filter state managed via ViewState

2. **Submission List**:

   - Shows all assignments submitted by student
   - Displays for each submission:
     - Assignment ID
     - Question text
     - Student's answer
     - Submitted date
     - Grade (if graded)
     - Feedback (if graded)
     - Graded date (if graded)
     - Status indicator (Graded/Ungraded)
   - Sorted by submission date (newest first)

3. **Navigation**:
   - **Back Button**: Returns to Assignments Home

---

## Guest User Workflow

### Guest Access

**Access Level**: Limited read-only access to lessons only

### Guest Login

1. **Login Process**:
   - User clicks "Guest Login" on login page
   - System creates guest session:
     - `Session["UserID"] = -1`
     - `Session["Username"] = "Guest"`
     - `Session["Role"] = "Guest"`
   - Redirects to `LessonsLevel.aspx`

### Guest Capabilities

1. **Lessons Access**:

   - Can view all three lesson levels
   - Can access lesson content with videos
   - Same interface as students for lessons

2. **Restrictions**:
   - **Cannot access quizzes** (redirected if attempted)
   - **Cannot access assignments** (redirected if attempted)
   - **Cannot view progress** (redirected if attempted)
   - **Cannot submit quiz answers** (no progress saved)
   - **No user account** (no registration data)

### Guest Navigation

1. **Lessons Level Page**:

   - Can select any level (1, 2, or 3)
   - Back button clears session and returns to login

2. **Lessons Page**:
   - Can view lesson content
   - Back button returns to level selection

---

## Database Schema Overview

### Core Tables

#### Users

- `UserID` (Primary Key)
- `Username` (Unique)
- `Email` (Unique)
- `Password` (Hashed: salt:hash format)
- `Age` (Integer)
- `Gender` (String)
- `Role` (Admin/Teacher/Student)
- `CreatedAt` (DateTime)

#### Lessons

- `LessonID` (Primary Key)
- `Level` (1, 2, or 3)
- `Title` (String)
- `Description` (String)
- `Content` (Text)
- `ImagePath` (String, nullable)

#### Quizzes

- `QuizID` (Primary Key)
- `LessonID` (Foreign Key to Lessons)
- `QuestionText` (Text)
- `OptionA`, `OptionB`, `OptionC`, `OptionD` (Strings)
- `CorrectOption` (Char: A, B, C, or D)
- `ImagePath` (String, nullable)

#### Progress

- `ProgressID` (Primary Key)
- `UserID` (Foreign Key to Users)
- `LessonID` (Foreign Key to Lessons)
- `Score` (Integer: number of correct answers)
- `IsCompleted` (Bit: 1 = completed)
- `LastAccessed` (DateTime)

#### Assignments

- `AssignmentID` (Primary Key)
- `TeacherID` (Foreign Key to Users)
- `Question` (Text)
- `DueDate` (DateTime)
- `AgeMin` (Integer)
- `AgeMax` (Integer)
- `CreatedDate` (DateTime)

#### AssignmentSubmissions

- `SubmissionID` (Primary Key)
- `AssignmentID` (Foreign Key to Assignments)
- `UserID` (Foreign Key to Users)
- `Answer` (Text)
- `SubmittedDate` (DateTime)
- `Grade` (Integer, nullable)
- `Feedback` (Text, nullable)
- `GradedDate` (DateTime, nullable)
- `GradedBy` (Foreign Key to Users, nullable)

#### ContactMessages

- `MessageID` (Primary Key)
- `Name` (String)
- `Email` (String)
- `Subject` (String)
- `Message` (Text)
- `DateSubmitted` (DateTime)

---

## Security Features

### Password Security

1. **Hashing Algorithm**:

   - Uses SHA256 with random salt
   - Salt: 16 random bytes generated per password
   - Storage format: `{base64Salt}:{hexHash}`
   - Implemented in `PasswordHelper` class

2. **Password Verification**:
   - Constant-time comparison to prevent timing attacks
   - Secure comparison function checks length and uses XOR

### Session Management

1. **Session Variables**:

   - `UserID`: User identification
   - `Username`: Display name
   - `Role`: Access control
   - `LoginTime`: Session tracking

2. **Session Validation**:
   - Every protected page checks for valid session
   - Role-based access control on all pages
   - Automatic redirect to login if session invalid

### Access Control

1. **Role-Based Redirects**:

   - Each page validates user role
   - Wrong role redirects to appropriate home page
   - Guest role has limited access

2. **Ownership Verification**:
   - Teachers can only edit/delete their own assignments
   - Teachers can only grade submissions for their assignments
   - Admins cannot delete their own account

### Email Security

1. **OTP System**:

   - 6-digit random OTP
   - 10-minute expiry
   - Stored in session (not database)
   - Email verification required for student registration

2. **SMTP Configuration**:
   - Gmail SMTP server
   - SSL/TLS enabled
   - Credentials stored in Web.config (should be in secure storage for production)

### Data Validation

1. **Input Validation**:

   - Required field validators on forms
   - Email format validation
   - Age range validation
   - Date validation (future dates for assignments)

2. **SQL Injection Prevention**:
   - All database queries use parameterized statements
   - No string concatenation in SQL queries

### Transaction Safety

1. **Database Transactions**:
   - User deletion uses transactions
   - Ensures atomicity of related record deletions

---

## Additional Features

### Contact Form

**Location**: `Pages/Global/Contact.aspx`

1. **Public Access**: Available to all users (no login required)
2. **Form Fields**:
   - Name
   - Email
   - Subject
   - Message
3. **Submission**:
   - Saves to `ContactMessages` table
   - Admin can view and delete messages
   - Success/error messages displayed

### Email Notifications

1. **Assignment Notifications**:

   - Sent automatically when teacher creates assignment
   - HTML email template with styling
   - Includes direct link to assignment
   - Sent to all eligible students (age range match)

2. **OTP Emails**:
   - Sent during student registration
   - HTML email template
   - 10-minute expiry notice

---

## System Flow Summary

### Complete Student Learning Flow

1. **Registration** → Email verification → Account creation
2. **Login** → Student Home → View progress overview
3. **Lessons** → Select level → View lesson content with video
4. **Quizzes** → Select level → Take quiz (3 questions) → View results → Save progress
5. **Progress** → View statistics → View best attempts per level → View all attempts for level
6. **Assignments** → View pending assignments → Submit answer → View graded feedback

### Complete Teacher Workflow

1. **Login** → Teacher Home
2. **Create Assignment** → Fill form → System sends emails to eligible students
3. **Manage Assignments** → View all assignments → View details → Edit/Delete
4. **Grade Assignments** → View ungraded submissions → Grade with feedback → Student receives grade

### Complete Admin Workflow

1. **Login** → Admin Home
2. **Manage Users** → Filter by role → View users → Register new users → View/Delete users
3. **Manage Messages** → View contact messages → Delete messages
4. **View Content** → View quizzes and lessons (if implemented)

---

## Technical Implementation Notes

### Progress Calculation Logic

The system uses a sophisticated progress calculation that:

- Handles quiz retakes by using best score per level
- Calculates: `(best scores per level / total possible questions) × 100`
- Total possible = `(number of levels) × (questions per quiz)`
- Currently: 3 levels × 3 questions = 9 total possible
- Modular design allows easy adjustment of questions per quiz

### Email System

- Uses SMTP with Gmail
- HTML email templates with inline CSS
- Responsive email design
- Error handling and logging

### Session Management

- Session-based authentication
- No persistent cookies for authentication
- Session timeout handled by ASP.NET
- Guest sessions use special UserID (-1)

---

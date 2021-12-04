**Name of Project**

OSU CSE Grader Application and Assignment System.

**Application Context**

Every semester, the Ohio State University CSE department hires about 60 undergraduate students as graders for various courses. Currently, the process of matching qualified students with specific course sections is somewhat ad hoc. Department office staff receive emails (i) from students indicating their interest in grading, and (ii) from faculty indicating their need for graders or with recommendations of students to hire. Unfortunately, there is no uniform workflow for the hiring of these graders. This application was designed to streamline the process and ensure consistency in the system.


**Description of the OSU CSE Grader Application and Assignment System.**

The OSU CSE Grader Application and Assignment System is divided into three separate smaller applications based on the type of user signed into the system: a (prospective) Grader/TA, Staff (an instructor), or an Admin (system administrator). Each of these smaller applications are similar in nature, but have distinct differences worth mentioning.

Each of the smaller applications allow the user to view all CSE course information for the upcoming semester, which can be found below in the bulleted list. Additionally, the user can search for a course by title or filter the courses based on the "thousand-level" of the course (i.e. 1000-level course, 2000-level course, 3000-level course, etc.). The user also has the ability to edit their profile, should they wish to do so. The user is able to update their email and password as well as cancel their account completely.

Viewable Information:
- Courses
  - Course Number
  - Course Name
  - Course Description
  - Grade Requirement
- Sections
  - Section Number 
  - Class Number
  - Component (Lecture, Lab, etc.)
  - Start Date
  - End Date
- Meetings
  - Start Time
  - End Time
  - Class Days
  - Location
  - Instructor Name
  - Instructor Email

As mentioned before, there are distinct differences in functionality between the three different user types, and these differences are explained below.
- Grader/TA
  - This user has ability to edit and submit a Grader Application Form, which can be accessed via the "Grader Application Form" button in the top left portion of the screen. This form acts as the potential grader's application to grade and will be used by the system and eventually the admin to assign graders to grade for specific courses and sections. This application includes the users name, email, OSU name.#, Major, and the semester for which the user is applying to grade. The Application Form also allows for the user to input the times that they are available to grade (day of the week, start time, and end time) as well as editing and deleting these availabilities as their schedule changes from semester to semester. The user also specifies the courses they are interested in grading for. *The user is required to specify at least one course and only select courses they have received a final grade of an A in.* The user may continually login in and edit their application as they please.
- Staff
  - This user has to ability to edit and submit and Instructor Recommendation Form, which can be accessed via the "Instructor Recommendation Form" in the top left portion of the screen. This form may either act as an instructor's general recommendation for a student to grade a course, or a specific request for a grader to be assigned to a particular section (typically the instructor's own section). This form includes the instructor's name, the grader's name, the graders id (OSU name.#), and the course title. The instructor can specify the section number as well, *only if they are requesting a grader to grade for a specific section*. Otherwise, they should leave it blank. There is also a comments box if the instructor wishes to write any personal messages. The instructors can login and view, edit, and delete their recommendations as they see fit.
- Admin
  - This user has the ability to refresh the site's course information. This can be done using the "Rescrape" button the top left hand portion of the screen. The user must select the campus, academic career (undergraduate vs. graduate), and the term for which they would like to pull the course information for.
  - This user has the ability to add a new course and edit/delete existing courses within the database. Adding a course can be done using the "Add a new Course" button in the top left hand portion of the screen and filling out all three applicable fields. Editing and deleting a course can be done using the "Edit Course" and "Delete Course" links found on the right hand side of the page next to each course's information.
  - This user has the ability to assign graders to specific sections. By navigating to a specific section's information page (Show Sections -> Show More Info), the user can see an "Assign a Grader" link within the first dialog box. Clicking on this link will open a page displaying each grader that is available and qualified to grade the course. The user may also view instructor recommendations for that potential grader, if they would like to. Once the user has selected a grader to assign, they can click the "Submit" button to officially assign that grader to the course.

**Design Decisions**

It must be noted that the team was faced with an unfortunate lack of information regarding certain key topics. As such, the team had to make certain decisions/assumptions that guided the design of this application. These decisions can be found below.
- There is no set standard for how many graders are required for a section, so the team decided that for this application, each section required at most 2 graders.
- The team had no access to the student's grades, so it had no ability to check if a possible grader is qualified to grade a course. As such, the application assumes that if a grader specifies a course they are interested in grading, they are qualified to do so. There is a note on the application reminding potential graders of this.
- Based on the team's experience with actually grading for CSE courses, it determined that a grader can only grade for one section attached to one course. In other words, in terms of this application, a grader cannot grade for more than one section or more than one course.
- The team had no access to validation or verification tools, so it was forced to trust that any user who happened to choose "TA" or "Staff" when creating an account for the application did, in fact, belong to one of those two categories. To maintain some measure of security, however, the team designed the application such that there is only one *pre-existing* administrator account and users cannot choose to create an administrator account. The login information can be found at the bottom of the README. The team is fully aware that this presents very little in terms of security. This is just an example account, and should the application be used in production, the real admin account should and would be more secure, implement a more sophisticated password, and make use of the DuoMobile two-factor authentication used by Ohio State (this also applies generally to all accounts created in the system as well).


**Installation Requirements**

This application was developed using Ruby v2.7.4 and Rails v6.1.4. Therefore, a command line interface running those versions (or higher) of Ruby and Rails is required. Additionally, a web-browser capable of reaching localhost websites (Google Chrome, Safari, Microsoft Edge, Firefox all will work). 

**Installation Instructions**

The code for the application is located at https://github.com/cse-3901-sharkey/CASH-D.git inside the "lab-4" folder. To install it, either clone the repository to your directory using the link above with the appropriate git command (below) or download the zip file and unzip it to a desired location.

git clone https://github.com/cse-3901-sharkey/CASH-D.git

**How to Run/Navigate**

To run the application, type the command <bin/rails server> onto the command line. Some text will appear on the screen. The server has been completely configured when the last line is "Use Ctrl+C to stop". At that point, just above that line will be another line that looks something like tcp://[::1]:3000. The final four digits are the port number for the server. To access the server, go to "http://localhost:<port number>". Once the application loads, either create an or log in based on what type of account it will be and then navigate the page accordingly.

Additionally, should an output file of the courses and their information be needed, a command called "scrapeData.rb" can be run. This scrape the data and print it out to the command line or to a file that the user specifies. It requires three command line arguments: the campus, the career, and the term.
  
Possible Campus Arguments:
- Columbus -> "col"
- Wooster -> "wst"
- Mansfield -> "mns"
- Marion -> "mrn"
- Newark -> "nwk"
- Lima -> "lma"
  
Possible Career Arguments:
- Undergraduate -> "ugrd"
- Graduate -> "grad"
  
Possible Term Arguments
- The term argument is a four digit number calculated by a formula. The first digit is always 1. The second two digits are the last two digits of the year. The third digit is the month, and is usually 8, 2, or 4 to signify the fall, spring, or summer semester, respectively.

 **Tools and Ruby Gems Utilized**
- Ruby v2.7.4
- Devise (https://rubygems.org/gems/devise/versions/4.8.0)
- Rest-Client (https://rubygems.org/gems/rest-client/versions/1.8.0)
- ActiveRecord-Import (https://rubygems.org/gems/activerecord-import/versions/0.15.0)
- SQLite
- Ruby on Rails and Pre-Installed Gems
  
**Acknowledgements:**

1. Code for filtering courses below was obtained from: https://www.justinweiss.com/articles/search-and-filter-rails-models-without-bloating-your-controller/

  scope :filter_by_course_number, -> (course_number) { where("course_number like ?", "#{course_number}%")}
  scope :filter_by_course_title, -> (course_title) { where("course_title like ?", "%#{course_title}%")}

2. Code for putting hidden fields below was obtained from https://stackoverflow.com/questions/17916316/is-there-a-way-to-pass-params-when-clicking-submit-button-in-simple-form-view-in

  hidden_field_tag(:prev_course_id, @course)
  
  
**Administrator Login Information**
  - Email: theadmin@admin.com
  - Password: topsecret


Name of Project
OSU CSE Course Scraper

Description of the OSU Course Scraper
The OSU Course Scraper is a website that scrapes information from the Ohio State's course listings for the Computer Science and Engineering (CSE) major. It's designed to display information in a manner befitting a TA wishing to sign up to
grade for certain courses. Additionally, the information can be displayed for a member of the CSE staff or the administrator of the site. This view is determined by how the user specifies themself upon logging in or creating an account.
The user is also able to search for specific courses by course description as well as filter all available courses by course title number.

For a course, the user can view the following information:
- Course Number
- Course Title
- Course Description
- Grade Requirement 

The user can also view specific sections for a class and the following section information:
- Section Number
- Class Number
- Component (such as lecture, lab, or online)
- Start Date
- End Date

Finally, the user can also view the following meeting information for specific sections:
- Start Time
- End Time
- Class Meeting Days
- Location
- Instructor

Installation Requirements
This application was developed using Ruby v2.7.4 and Rails v6.1.4. Therefore, a command line interface running those versions (or higher) of Ruby and Rails is required. Additionally, a web-browser capable of reaching localhost websites
(Google Chrome, Safari, Microsoft Edge, Firefox all will work). 

Installation Instructions
The code for the application is located at https://github.com/cse-3901-sharkey/CASH-D.git inside the "lab-3" folder. To install it, either clone the repository to your directory using the link above with the appropriate git command (below)
or download the zip file and unzip it to a desired location.
 - git clone https://github.com/cse-3901-sharkey/CASH-D.git

How to Run/Navigate
To run the application, type the command <bin/rails server> onto the command line. Some text will appear on the screen. The server has been completely configured when the last line is "Use Ctrl+C to stop". At that point, just above that line will be another line that looks something like <tcp://[::1]:3000>. 
The final four digits are the port number for the server. To access the server, go to "http://localhost:<port>". 
Once the application loads, either create an or log in based on what type of account it will be and then navigate the page accordingly.

Additionally, should an output file of the courses and their information be needed, a command called "scrapeData.rb" can be run. This scrape the data and print it out to the command line or to a file that the user specifies. It requires three command line arguments: the campus, the career, and the term.
 - Possible Campus Arguments:
   - Columbus -> "col"
   - Wooster -> "wst"
   - Mansfield -> "mns"
   - Marion -> "mrn"
   - Newark -> "nwk"
   - Lima -> "lma"
 - Possible Career Arguments:
   - Undergraduate -> "ugrd"
   - Graduate -> "grad"
 - Possible Term Arguments
   - The term argument is a four digit number calculated by a formula. The first digit is always 1. The second two digits are the last two digits of the year. The third digit is the month, and is usually 8, 2, or 4 to signify the fall, spring, or summer semester, respectively.

Some example calls are:
 - Undergraduate courses at Columbus in the fall of 2021: <$ ruby scrapeData.rb col ugrd 1218>
 - Graduate courses at Mansfield in the spring of 2022: <$ ruby scrapeData.rb msn grad 1222>

 Acknowledgements:

1. Code for filtering courses below was obtained from: https://www.justinweiss.com/articles/search-and-filter-rails-models-without-bloating-your-controller/

  scope :filter_by_course_number, -> (course_number) { where("course_number like ?", "#{course_number}%")}
  scope :filter_by_course_title, -> (course_title) { where("course_title like ?", "%#{course_title}%")}

2. Code for putting hidden fields below was obtained from https://stackoverflow.com/questions/17916316/is-there-a-way-to-pass-params-when-clicking-submit-button-in-simple-form-view-in

  hidden_field_tag(:prev_course_id, @course)


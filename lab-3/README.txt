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

Installation Requirements
This application was developed using Ruby v2.7.4 and Rails v6.1.4. Therefore, a command line interface running those versions (or higher) of Ruby and Rails is required. Additionally, a web-browser capable of reaching localhost websites
(Google Chrome, Safari, Microsoft Edge, Firefox all will work). 

Installation Instructions
The code for the application is located at https://github.com/cse-3901-sharkey/CASH-D.git inside the "lab-3" folder. To install it, either clone the repository to your directory using the link above with the appropriate git command (below)
or download the zip file and unzip it to a desired location.
 - git clone https://github.com/cse-3901-sharkey/CASH-D.git

How to Run/Navigate
To run the application, type the command <bin/rails server> onto the command line. Some text will appear on the screen. The server has been completely configured when the last line is "Use Ctrl+C to stop". At that point, just above that
line will be another line that looks something like <tcp://[::1]:3000>. The final four digits are the port number for the server. To access the server, go to "http://localhost:<port>". Once the application loads, either create an or log in
based on what type of account it will be and then navigate the page accordingly.

Acknowledgements:

HERE'S WHERE WE PUT CODE WE SNATCHED FROM SOMEWHERE ELSE


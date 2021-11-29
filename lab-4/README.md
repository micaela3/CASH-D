**Name of Project**

OSU CSE Grader Application and Assignment System.

**Description of the OSU CSE Grader Application and Assignment System.**

It must be noted that the team was faced with an unfortunate lack of information regarding certain key topics. As such, the team had to make certain decisions/assumptions that guided the design of this application. These decisions can be found below.
- There is no set standard for how many graders are required for a section, so the team decided that for this application, each section required at most 2 graders.
- The team had no access to the student's grades, so it had no ability to check if a possible grader is qualified to grade a course. As such, the application assumes that if a grader specifies a course they are interested in grading, they are qualified to do so. There is a note on the application reminding potential graders of this.
- Based on the team's experience with actually grading for CSE courses, it determined that a grader can only grade for one section attached to one course. In other words, in terms of this application, a grader cannot grade for more than one section or more than one course.


**Installation Requirements**


**Installation Instructions**


**How to Run/Navigate**


 **Acknowledgements:**

1. Code for filtering courses below was obtained from: https://www.justinweiss.com/articles/search-and-filter-rails-models-without-bloating-your-controller/

  scope :filter_by_course_number, -> (course_number) { where("course_number like ?", "#{course_number}%")}
  scope :filter_by_course_title, -> (course_title) { where("course_title like ?", "%#{course_title}%")}

2. Code for putting hidden fields below was obtained from https://stackoverflow.com/questions/17916316/is-there-a-way-to-pass-params-when-clicking-submit-button-in-simple-form-view-in

  hidden_field_tag(:prev_course_id, @course)


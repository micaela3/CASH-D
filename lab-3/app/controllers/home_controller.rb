class HomeController < ApplicationController
  def index
    @courses = Course.where(nil);
    @courses = @courses.filter_by_starts_with(params[:starts_with]) if params[:starts_with].present?
  end

  def rescrape
    clear_courses
    update_course_data
    respond_to do |format|
      format.html { redirect_to home_index_url, notice: "Succesfully rescraped" }
      format.json { head :no_content }
    end
  end
  
  private
    # Set the base endpoint for the API
    #?q=cse&campus=col&p=2&subject=cse&academic-career=ugrd&term=1222
    BASE_URL = "https://content.osu.edu/v2/classes/search"
    # Search for 'CSE'
    SEARCH_QUERY = 'cse'
    # Set campus to Columbus
    CAMPUS = 'col'
    # Set subject to CSE
    SUBJECT = 'cse'
    # Set career to Undergraduate
    CAREER = 'ugrd'
    # Set term to Spring 2022
    TERM = '1222'

    # Clear existing courses and sections
    def clear_courses
      Course.delete_all
      Section.delete_all
      Instructor.delete_all
      Meeting.delete_all
    end

    # Return whether a Meeting record matches a meeting_entry

    def meeting_matches_entry?(meeting, meeting_entry)
      # Check if they have the same days and places
      location = "TBA"
      if meeting_entry["room"] != nil
        location = meeting_entry["facilityDescription"] + " - Room: " + meeting_entry["room"]
      elsif meeting_entry["facilityDescription"] != nil
        location = meeting_entry["facilityDescription"]
      end
      return (meeting.location == location \
      && meeting.monday == meeting_entry["monday"] \
      && meeting.tuesday == meeting_entry["tuesday"] \
      && meeting.wednesday == meeting_entry["wednesday"] \
      && meeting.thursday == meeting_entry["thursday"] \
      && meeting.friday == meeting_entry["friday"] \
      && meeting.saturday == meeting_entry["saturday"] \
      && meeting.sunday == meeting_entry["sunday"] )
    end

    # Pull/Update Course and Section data
    def update_course_data
      # Start from page 1
      page = 1
      # There is at least one page
      total_pages = 1

      while page <= total_pages
        # Make request
        response = RestClient.get(BASE_URL, { params: {
          q: SEARCH_QUERY,
          campus: CAMPUS,
          p: page,
          subject: SUBJECT,
          'academic_career': CAREER,
          term: TERM
        }})

        # Parse response and get data
        json_response = JSON.parse(response)
        data = json_response['data']

        # Get total pages (Shouldn't change from iteration to iteration, but we need it the first time)
        total_pages = data['totalPages']

        courses = []

        data["courses"].each { |course_entry|
          # Create course
          course = course_entry["course"]
          new_course = Course.find_by course_number: course["catalogNumber"]
          if new_course == nil && courses.find { |c| c.course_number == course["catalogNumber"] } == nil
            new_course = Course.new(
              course_description: course["description"],
              course_title: course["title"],
              course_number: course["catalogNumber"]
            )
            courses << new_course
          end
        }

        # Import every course in one query using activerecord-import
        Course.import courses
        # Get an array of courses & their IDs (we'll need all of them)
        courses = Course.all.to_a

        sections = []
        data["courses"].each { |course_entry|
          course = courses.find { |c| c.course_number == course_entry["course"]["catalogNumber"] }
          course_entry["sections"].each { |section|
            new_section = Section.new(
              course: course,
              section_number: section["section"],
              class_number: section["classNumber"],
              component: section["component"],
              start_date: Date.parse(section["startDate"]),
              end_date: Date.parse(section["endDate"])
            )
            sections << new_section
          }
        }
        # Import every section in one query
        Section.import sections
        # Get an array of sections & their IDs (we'll need all of them for meetings)
        sections = Section.all.to_a

        meetings = []
        data["courses"].each { |course_entry|
          course = courses.find { |c| c.course_number == course_entry["course"]["catalogNumber"] }
          course_entry["sections"].each { |section_entry|
            section = sections.find { |s| s.course_id == course.id && s.section_number == section_entry["section"].to_i }
            section_entry["meetings"].each { |meeting|
              new_meeting = Meeting.new(
                section: section,
                start_time: meeting["startTime"],
                end_time: meeting["endTime"],
                monday: meeting["monday"],
                tuesday: meeting["tuesday"],
                wednesday: meeting["wednesday"],
                thursday: meeting["thursday"],
                friday: meeting["friday"],
                saturday: meeting["saturday"],
                sunday: meeting["sunday"]
              )
              if meeting["room"] != nil
                new_meeting.location = meeting["facilityDescription"] + " - Room: " + meeting["room"]
              elsif meeting["facilityDescription"] != nil
                new_meeting.location = meeting["facilityDescription"]
              else
                new_meeting.location = "TBA"
              end
              meetings << new_meeting
            }
          }
        }
        # Import every meeting in one query
        Meeting.import meetings
        # Get an array of meetings & their IDs (we'll need all of them for instructors)
        meetings = Meeting.all.to_a

        instructors = []
        data["courses"].each { |course_entry|
          course = courses.find { |c| c.course_number == course_entry["course"]["catalogNumber"] }
          course_entry["sections"].each { |section_entry|
            section = sections.find { |s| s.course_id == course.id && s.section_number == section_entry["section"].to_i }
            section_entry["meetings"].each { |meeting_entry|
              meeting = meetings.find { |m| m.section_id == section.id && meeting_matches_entry?(m, meeting_entry) }
              meeting_entry["instructors"].each { |instructor|
                # This will cause duplicates if an instructor teaches multiple sections
                # However this allows us to do a belongs_to relation and gives us the same output
                newInstructor = Instructor.new(
                  meeting: meeting
                )

                if instructor["displayName"] != nil
                  newInstructor.instructor_name = instructor["displayName"]
                else
                  newInstructor.instructor_name = "TBA"
                end

                # In case the instructor has a name, but not an email
                if instructor["email"] != nil
                  newInstructor.instructor_email = instructor["email"]
                else
                  newInstructor.instructor_email = "TBA"
                end

                # Append to instructors array for importing
                instructors << newInstructor
              }
            }
          }
        }

        # Import every instructor in one query
        Instructor.import instructors
        
        # Increment page and continue after sleeping
        page += 1
        sleep 1
      end
    end
end

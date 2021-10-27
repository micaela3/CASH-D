class CoursesController < ApplicationController
  before_action :set_course, only: %i[ show edit update destroy ]

  # GET /courses or /courses.json
  def index
    @courses = Course.all
    clear_courses
    update_course_data
  end

  # GET /courses/1 or /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: "Course was successfully destroyed." }
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

    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:course_description, :course_title, :course_id)
    end

    # Clear existing courses and sections
    def clear_courses
      Course.delete_all
      Section.delete_all
      Instructor.delete_all
      Meeting.delete_all
    end

    # Pull/Update Course and Section data
    def update_course_data
      # Start from page 1
      page = 1
      # There is at least one page
      totalPages = 1

      while page <= totalPages
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
        jsonResponse = JSON.parse(response)
        data = jsonResponse['data']

        # Get total pages (Shouldn't change from iteration to iteration, but we need it the first time)
        totalPages = data['totalPages']

        courses = []

        data["courses"].each { |courseEntry|
          # Create course
          course = courseEntry["course"]
          newCourse = Course.find_by course_id: course["catalogNumber"]
          if newCourse == nil
            newCourse = Course.new(
              course_description: course["description"],
              course_title: course["title"],
              course_id: course["catalogNumber"]
            )
            courses << newCourse
          end

          newCourse.save

          # Create sections
          sections = courseEntry["sections"]
          sections.each { |section|
            if section["meetings"].length > 1
                puts "Found CSE " + course["catalogNumber"] + " with multiple meetings"
            end
            newSection = Section.new
            # Add relation
            newSection.course = newCourse
            
            # Add columns
            newSection.section_number = section["section"]
            newSection.class_number = section["classNumber"]
            newSection.component = section["component"]
            newSection.start_date = Date.parse(section["startDate"])
            newSection.end_date = Date.parse(section["endDate"])
            # Save
            newSection.save

            section["meetings"].each { |meeting|
              newMeeting = Meeting.new
              # Add relation
              newMeeting.section = newSection
              newMeeting.start_time = meeting["startTime"]
              newMeeting.end_time = meeting["endTime"]
              newMeeting.monday = meeting["monday"]
              newMeeting.tuesday = meeting["tuesday"]
              newMeeting.wednesday = meeting["wednesday"]
              newMeeting.thursday = meeting["thursday"]
              newMeeting.friday = meeting["friday"]
              newMeeting.saturday = meeting["saturday"]
              newMeeting.sunday = meeting["sunday"]
              if meeting["room"] != nil
                newMeeting.location = meeting["facilityDescription"] + " - Room: " + meeting["room"]
              elsif meeting["facilityDescription"] != nil
                newMeeting.location = meeting["facilityDescription"]
              else
                newMeeting.location = "TBA"
              end
              # Save
              newMeeting.save

              meeting["instructors"].each { |instructor|
                # This will cause duplicates if an instructor teaches multiple sections
                # However this allows us to do a belongs_to relation and gives us the same output
                newInstructor = Instructor.new
                # Add relation
                newInstructor.meeting = newMeeting
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

                # Save
                newInstructor.save
              }
            }
          }
        }

        # Use activerecord-import for speedup
        #Course.import courses

        # Increment page and continue after sleeping
        page += 1
        sleep 1
      end
    end
end

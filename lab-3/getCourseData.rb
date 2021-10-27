
require 'rest-client'
require 'json'






# Clear existing courses and sections
def clear_courses
    # Thanks to Philip on stackoverflow for this way of destroying all records
    # https://stackoverflow.com/a/16737953
    Course.find_each(&:destroy)
    Section.find_each(&:destroy)
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

        data["courses"].each { |courseEntry|
            # Create course
            course = courseEntry["course"]
=begin
            newCourse = Course.create(
                course_description: course["description"]
                course_title: course["title"]
                course_id: course["catalogNumber"]
            )
=end

            # Create sections
            sections = courseEntry["sections"]
            sections.each { |section|
                if section["meeting"].length > 1
                    puts "Found CSE " + course["catalogNumber"] + " with multiple meetings"
                end
=begin
                newSection = Section.new
                # Add relation
                newSection.course = newCourse
                
                # Add columns
                newSection.section_number = section["section"]
                newSection.class_number = section["classNumber"]
                newSection.component = section["component"]
                newSection.course_id = section["catalogNumber"]
                newSection.start_date = Date.parse(section["startDate"])
                newSection.end_date = Date.parse(section["endDate"])
                # Save
                #newSection.save
=end 
            }
        }

        puts data

        # Increment page and continue after sleeping
        page += 1
        sleep 1
    end
end

clear_courses
update_course_data
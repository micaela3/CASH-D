require 'json'
require 'rest-client'

# Set the base endpoint for the API
#?q=cse&campus=col&p=2&subject=cse&academic-career=ugrd&term=1222
BASE_URL = "https://content.osu.edu/v2/classes/search"
# Search for 'CSE'
SEARCH_QUERY = 'cse'
# Set campus to Columbus
CAMPUS = ARGV[0]
# Set subject to CSE
SUBJECT = 'cse'
# Set career to Undergraduate
CAREER = ARGV[1]
# Set term to Spring 2022
TERM = ARGV[2]


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
  academic_career: CAREER,
  term: TERM
}})

  # Parse response and get data
  json_response = JSON.parse(response)

  # access actual data and set totalPages
  data = json_response['data']
  total_pages = data['totalPages']

  # loop over all the courses on the page
  data["courses"].each { |course_entry|

    # initialize course variable for accessing properties
    course = course_entry["course"]

    # initialize needed course information
    catalogNumber = course["catalogNumber"]
    title = course["title"]
    description = course["description"]
  
    # print out course information
    puts "CSE #{catalogNumber}: #{title}"
    puts "Description: #{description}"

    # loop over all the sections
    course_entry["sections"].each { |section_entry|
      
      # because of how scope works in ruby, these variables need to be initialized in the section loop...they will be set in later nested loops
      startTime = ""
      endTime = ""
      days = "" # construct a string of the meeting days (i.e. MonWedFri)
      location = ""
      instructorName = "" 


      # initialize needed section information
      startDate = section_entry["startDate"]
      endDate = section_entry["endDate"]
      component = section_entry["component"]
      sectionNumber = section_entry["section"]
      classNumber = section_entry["classNumber"]

      # loop over all the meetings
      section_entry["meetings"].each { |meeting_entry|

        # initialize needed meeting information
        startTime = meeting_entry["startTime"]
        endTime = meeting_entry["endTime"]

        # construct the string of days the class meets
        if (meeting_entry["monday"])
          days = "#{days}Mon"
        end
        if (meeting_entry["tuesday"])
          days = "#{days}Tue"
        end
        if (meeting_entry["wednesday"])
          days = "#{days}Wed"
        end
        if (meeting_entry["thursday"])
          days = "#{days}Thurs"
        end
        if (meeting_entry["friday"])
          days = "#{days}Fri"
        end
        if (meeting_entry["saturday"])
          days = "#{days}Sat"
        end
        if (meeting_entry["sunday"])
          days = "#{days}Sun"
        end

        # construct the location of where the class meets
        if (meeting_entry["room"] != nil) # i.e. Baker Systems Building - Room: 140
          location = "in #{meeting_entry["facilityDescription"]} - Room #{meeting_entry["room"]}"
        elsif (meeting_entry["facilityDescription"] != nil)
          location = "#{meeting_entry["facilityDescription"]}" # ONLINE
        else
          location = "TBA"
        end

        
        # loop over all the possible instructors
        meeting_entry["instructors"].each { |instructor_entry|

          # initialize needed information
          if (instructor_entry["displayName"] != nil) 
            instructorName = "#{instructor_entry["displayName"]}"
            
            if (instructor_entry["email"] != nil) # add instructor email if present
              instructorName = "#{instructorName} (#{instructor_entry["email"]})"
            end
          else 
            instructorName = "TBA"
          end
          
        } # end instructor loop
      } # end meeting loop
      
      puts "Class #{classNumber}, Section #{sectionNumber}: #{component} taught by #{instructorName} on #{days} (#{startTime} - #{endTime}) #{location} from #{startDate} - #{endDate}."

    } # end section loop

    puts "\n\n" # formatting

  } # end course loop

  # Increment page and continue after sleeping
  page += 1
  sleep 1
end


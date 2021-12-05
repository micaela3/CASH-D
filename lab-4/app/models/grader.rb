class Grader < ApplicationRecord
  belongs_to :user
  belongs_to :section, optional: true
  validates_associated :section
  has_many :availabilities, dependent: :delete_all
  has_many :courses_graders, dependent: :delete_all
    
  def self.get_graders(section)
      # get meetings for this section which have a valid start and end time
      meetings = section.meetings.where.not(start_time: nil).where.not(end_time: nil)
    
      # Get date, month, and year for the section
      date = section.start_date
      month = date.month
      year = date.strftime("%y")
        
      # Code to get the correct semester integer in the model of the rest api semester code
      semester = 0
      # if spring semester
      if month < 5
        semester = '1' + year + "2"
      # if summer semester
      elsif month < 8
        semester = '1' + year + "4"
      # if autumn semester
      else
        semester = '1' + year + "8"
      end
      # turn string to an int
      semester = semester.to_i

     # empty grader array
     graders = []
    
     # get initial graders who have the correct course_number, assigned status and semester
     initial_graders = self.joins(:courses_graders).where(courses_graders: {course_id: section.course_id}, assigned: nil, semester: semester)
     
     # if there are meetings
     if meetings.count > 0
        # boolean to know if the constraints are matched
        match_found = true
        
        # For each grader
        initial_graders.each do |grader|
            # For each meeting
            meetings.each do |meeting|
                    # if match has been found
                    if match_found
                        # if the meeting meets on sunday
                        if meeting.sunday
                            # Get a list of all the availabilities for this grader that matches the correct weekday, start and end times
                            availabilities = grader.availabilities.where("weekday = (?) and start_time <= (?) and end_time >= (?)", 0, meeting.start_time, meeting.end_time)
                            # if the availabilities are empty set the match found to false
                            if availabilities.empty?
                                match_found = false
                            end
                        end
                        # if the meeting meets on monday
                        if meeting.monday
                            # Get a list of all the availabilities for this grader that matches the correct weekday, start and end times
                            availabilities = grader.availabilities.where("weekday = (?) and start_time <= (?) and end_time >= (?)", 1, meeting.start_time, meeting.end_time)
                            # if the availabilities are empty set the match found to false
                            if availabilities.empty?
                                match_found = false
                            end
                        end
                        # if the meeting meets on tuesday
                        if meeting.tuesday
                            # Get a list of all the availabilities for this grader that matches the correct weekday, start and end times
                            availabilities = grader.availabilities.where("weekday = (?) and start_time <= (?) and end_time >= (?)", 2, meeting.start_time, meeting.end_time)
                            # if the availabilities are empty set the match found to false
                            if availabilities.empty?
                                match_found = false
                            end
                        end
                        # if the meeting meets on wednesday
                        if meeting.wednesday
                            # Get a list of all the availabilities for this grader that matches the correct weekday, start and end times
                            availabilities = grader.availabilities.where("weekday = (?) and start_time <= (?) and end_time >= (?)", 3, meeting.start_time, meeting.end_time)
                            # if the availabilities are empty set the match found to false
                            if availabilities.empty?
                                match_found = false
                            end
                        end
                        # if the meeting meets on thursday
                        if meeting.thursday
                            # Get a list of all the availabilities for this grader that matches the correct weekday, start and end times
                            availabilities = grader.availabilities.where("weekday = (?) and start_time <= (?) and end_time >= (?)", 4, meeting.start_time, meeting.end_time)
                            # if the availabilities are empty set the match found to false
                            if availabilities.empty?
                                match_found = false
                            end
                        end
                        # if the meeting meets on friday
                        if meeting.friday
                            # Get a list of all the availabilities for this grader that matches the correct weekday, start and end times
                            availabilities = grader.availabilities.where("weekday = (?) and start_time <= (?) and end_time >= (?)", 5, meeting.start_time, meeting.end_time)
                            # if the availabilities are empty set the match found to false
                            if availabilities.empty?
                                match_found = false
                            end
                        end
                        # if the meeting meets on saturday
                        if meeting.saturday
                            # Get a list of all the availabilities for this grader that matches the correct weekday, start and end times
                            availabilities = grader.availabilities.where("weekday = (?) and start_time <= (?) and end_time >= (?)", 6, meeting.start_time, meeting.end_time)
                            # if the availabilities are empty set the match found to false
                            if availabilities.empty?
                                match_found = false
                            end 
                        end
                    end
        end
        # Add the grader to the array if match found
        graders << grader if match_found
        # Resets match found
        match_found = true
      end
    else
        # sets the graders to the initial graders found
        graders = initial_graders
    end
    
    # Returns grader
    return graders
 end

end

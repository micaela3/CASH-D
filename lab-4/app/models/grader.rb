class Grader < ApplicationRecord
  belongs_to :user
  belongs_to :section, optional: true
  validates_associated :section
  has_many :availabilities, dependent: :delete_all
  has_many :courses_graders, dependent: :delete_all
    
  def self.get_graders(section)
    meetings = section.meetings.where.not(start_time: nil).where.not(end_time: nil)
    
      # Get date, month, and next year for calculating terms
      date = section.start_date
      month = date.month
      year = date.strftime("%y")

      semester = 0
      if month < 5
        semester = '1' + year + "2"
      elsif month < 8
        semester = '1' + year + "4"
      else
        semester = '1' + year + "8"
      end
      semester = semester.to_i

     
     graders = []
     initial_graders = self.joins(:courses_graders).where(courses_graders: {course_id: section.course_id}, assigned: nil, semester: semester)
     if meetings.count > 0
        days =["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"]
        match_found = true

        initial_graders.each do |grader|
            meetings.each do |meeting|
               
                    if match_found
                        if meeting.sunday
                            availabilities = grader.availabilities.where("weekday = (?) and start_time <= (?) and end_time >= (?)", 0, meeting.start_time, meeting.end_time)
                            if availabilities.empty?
                                match_found = false
                            end
                        end
                        if meeting.monday
                            availabilities = grader.availabilities.where("weekday = (?) and start_time <= (?) and end_time >= (?)", 1, meeting.start_time, meeting.end_time)
                            if availabilities.empty?
                                match_found = false
                            end
                        end
                        if meeting.tuesday
                            availabilities = grader.availabilities.where("weekday = (?) and start_time <= (?) and end_time >= (?)", 2, meeting.start_time, meeting.end_time)
                            if availabilities.empty?
                                match_found = false
                            end
                        end
                        if meeting.wednesday
                            availabilities = grader.availabilities.where("weekday = (?) and start_time <= (?) and end_time >= (?)", 3, meeting.start_time, meeting.end_time)
                            puts availabilities.size
                            if availabilities.empty?
                                match_found = false
                            end
                        end
                        if meeting.thursday
                            availabilities = grader.availabilities.where("weekday = (?) and start_time <= (?) and end_time >= (?)", 4, meeting.start_time, meeting.end_time)
                            if availabilities.empty?
                                match_found = false
                            end
                        end
                        if meeting.friday
                            availabilities = grader.availabilities.where("weekday = (?) and start_time <= (?) and end_time >= (?)", 5, meeting.start_time, meeting.end_time)
                            if availabilities.empty?
                                match_found = false
                            end
                        end
                        if meeting.saturday
                            availabilities = grader.availabilities.where("weekday = (?) and start_time <= (?) and end_time >= (?)", 6, meeting.start_time, meeting.end_time)
                            if availabilities.empty?
                                match_found = false
                            end 
                        end
                    end
        end
        graders << grader if match_found
        match_found = true
      end
    else
        graders = initial_graders
    end

    return graders
 end

end

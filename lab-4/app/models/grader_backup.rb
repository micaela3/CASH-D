class Grader < ApplicationRecord
  belongs_to :user
  belongs_to :section, optional: true
  validates_associated :section
  has_many :availabilities, dependent: :delete_all
  has_many :courses_graders, dependent: :delete_all
  #has_and_belongs_to_many :courses, class_name: 'course_interests', dependent: :delete_all
    
  def self.get_graders(section)
    meetings = section.meetings.where.not(start_time: nil).where.not(end_time: nil)
    graders = self.joins(:courses_graders).where(courses_graders: {course_id: section.course_id})
    
    if meetings.count > 0
       days = [0,0,0,0,0,0,0]
       days_index = []
       start_times = []
       end_times = []
       query = ""
       meetings.each do |meeting|
           days[0] = meeting.sunday if days[0] == 0
           days[1] = meeting.monday if days[1] == 0
           days[2] = meeting.tuesday if days[2] == 0
           days[3] = meeting.wednesday if days[3] == 0
           days[4] = meeting.thursday if days[4] == 0
           days[5] = meeting.friday if days[5] == 0
           days[6] = meeting.saturday if days[6] == 0
       end
       days.each_with_index { |val, index| days_index << index if val }
       puts days_index
       graders = graders.joins(:availabilities).where("availabilities.weekday IN (?)", days_index)
       meetings.each do |meeting|
          start_times << meeting.start_time if !start_times.include? meeting.start_time
          end_times << meeting.end_time if !end_times.include? meeting.end_time
       end

       start_times.each_with_index do |start_times|
           query += "availabilities.start_time <= "

       graders = graders.where("availabilities.start_time <= (?) and availabilities.end_time >= (?)", meeting.start_time, meeting.end_time)
        
    end
    return graders
 end

end

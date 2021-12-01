class Grader < ApplicationRecord
  belongs_to :user
  belongs_to :section, optional: true
  validates_associated :section
  has_many :availabilities, dependent: :delete_all
  has_many :courses_graders, dependent: :delete_all
  #has_and_belongs_to_many :courses, class_name: 'course_interests', dependent: :delete_all
    
  def self.get_graders(section)
    meetings = section.meetings.where.not(start_time: nil).where.not(end_time: nil)
    graders = self.joins(:courses_graders).where(courses_graders: {course_id: section.course_id}, assigned: nil)
    
    if meetings.count > 0
       days = [0,0,0,0,0,0,0]
       days_index = []
       start_times = []
       end_times = []
       query = ""
       query2 = ""
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
       query2 = "availabilities.weekday IN (" + days_index.map(&:to_s).join(",") + ")"
       meetings.each do |meeting|
           query += (" or (availabilities.weekday = 0 and availabilities.start_time <= ('" + meeting.start_time.to_s(:db) + "') and availabilities.end_time >= ('" + meeting.end_time.to_s(:db) + "'))") if (meeting.sunday && !query.include?("availabilities.weekday = 0 and availabilities.start_time <= ('" + meeting.start_time.to_s(:db) + "') and availabilities.end_time >= ('" + meeting.end_time.to_s(:db) + "')"))
           query += (" or (availabilities.weekday = 1 and availabilities.start_time <= ('" + meeting.start_time.to_s(:db) + "') and availabilities.end_time >= ('" + meeting.end_time.to_s(:db) + "'))") if (meeting.monday && !query.include?("availabilities.weekday = 1 and availabilities.start_time <= ('" + meeting.start_time.to_s(:db) + "') and availabilities.end_time >= ('" + meeting.end_time.to_s(:db) + "')"))
           query += (" or (availabilities.weekday = 2 and availabilities.start_time <= ('" + meeting.start_time.to_s(:db) + "') and availabilities.end_time >= ('" + meeting.end_time.to_s(:db) + "'))") if (meeting.tuesday && !query.include?("availabilities.weekday = 2 and availabilities.start_time <= ('" + meeting.start_time.to_s(:db) + "') and availabilities.end_time >= ('" + meeting.end_time.to_s(:db) + "')"))
           query += (" or (availabilities.weekday = 3 and availabilities.start_time <= ('" + meeting.start_time.to_s(:db) + "') and availabilities.end_time >= ('" + meeting.end_time.to_s(:db) + "'))") if (meeting.wednesday && !query.include?("availabilities.weekday = 3 and availabilities.start_time <= ('" + meeting.start_time.to_s(:db) + "') and availabilities.end_time >= ('" + meeting.end_time.to_s(:db) + "')"))
           query += (" or (availabilities.weekday = 4 and availabilities.start_time <= ('" + meeting.start_time.to_s(:db) + "') and availabilities.end_time >= ('" + meeting.end_time.to_s(:db) + "'))") if (meeting.thursday && !query.include?("availabilities.weekday = 4 and availabilities.start_time <= ('" + meeting.start_time.to_s(:db) + "') and availabilities.end_time >= ('" + meeting.end_time.to_s(:db) + "')"))
           query += (" or (availabilities.weekday = 5 and availabilities.start_time <= ('" + meeting.start_time.to_s(:db) + "') and availabilities.end_time >= ('" + meeting.end_time.to_s(:db) + "'))") if (meeting.friday && !query.include?("availabilities.weekday = 5 and availabilities.start_time <= ('" + meeting.start_time.to_s(:db) + "') and availabilities.end_time >= ('" + meeting.end_time.to_s(:db) + "')"))
           query += (" or (availabilities.weekday = 6 and availabilities.start_time <= ('" + meeting.start_time.to_s(:db) + "') and availabilities.end_time >= ('" + meeting.end_time.to_s(:db) + "'))") if (meeting.saturday && !query.include?("availabilities.weekday = 6 and availabilities.start_time <= ('" + meeting.start_time.to_s(:db) + "') and availabilities.end_time >= ('" + meeting.end_time.to_s(:db) + "')"))
       end
       query.slice!(0..3)
       puts query
       graders = graders.joins(:availabilities).where(query2).where(query).uniq
    end
    return graders
 end

end

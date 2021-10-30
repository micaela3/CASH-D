class Course < ApplicationRecord
  has_many :sections
  default_scope { order(course_number: :asc) }
  scope :filter_by_course_number, -> (course_number) { where("course_number like ?", "#{course_number}%")}
  scope :filter_by_course_title, -> (course_title) { where("course_title like ?", "%#{course_title}%")}
end

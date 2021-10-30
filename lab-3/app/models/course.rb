class Course < ApplicationRecord
  has_many :sections
  default_scope { order(course_number: :asc) }
  scope :filter_by_starts_with, -> (course_number) { where("course_number like ?", "#{course_number}%")}
end

class Grader < ApplicationRecord
  belongs_to :user
  belongs_to :section, optional: true
  has_many :availabilities
  has_and_belongs_to_many :courses, class_name: 'course_interests'
end
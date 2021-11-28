class Grader < ApplicationRecord
  belongs_to :user
  belongs_to :section, optional: true
  has_many :availabilities, dependent: :delete_all
  has_many :courses_graders, dependent: :delete_all
  has_and_belongs_to_many :courses, class_name: 'course_interests', dependent: :delete_all
end

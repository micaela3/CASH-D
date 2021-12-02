class Course < ApplicationRecord
  has_many :sections
  has_and_belongs_to_many :graders, class_name: 'possible_graders', dependent: :delete
  # sort by ascending course_number
  default_scope { order(course_number: :asc) }
  
 # Code for filtering courses by course level and title was obtained from: https://www.justinweiss.com/articles/search-and-filter-rails-models-without-bloating-your-controller/
  
  scope :filter_by_course_number, -> (course_number) { where("course_number like ?", "#{course_number}%")}
  scope :filter_by_course_title, -> (course_title) { where("course_title like ?", "%#{course_title}%")}
    
  def course_number_with_title
    "#{course_number}: #{course_title}"
  end
end

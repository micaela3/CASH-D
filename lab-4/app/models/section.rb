class Section < ApplicationRecord
  belongs_to :course
  has_many :meetings
  has_many :graders, dependent: :delete_all
  validates_length_of :graders, maximum: 2

  # sort by ascending section number 
  default_scope { order(section_number: :asc) }
end

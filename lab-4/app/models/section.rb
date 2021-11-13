class Section < ApplicationRecord
  belongs_to :course
  has_many :meetings

  # sort by ascending section number 
  default_scope { order(section_number: :asc) }
end

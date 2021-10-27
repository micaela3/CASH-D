class Section < ApplicationRecord

  belongs_to :course
  has_many :meetings, foreign_key: 'section_number'
end

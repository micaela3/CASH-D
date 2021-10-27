class Section < ApplicationRecord
  self.primary_key = 'section_number'

  belongs_to :course
  has_many :meetings, foreign_key: 'section_number'
end

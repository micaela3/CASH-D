class Meeting < ApplicationRecord
  belongs_to :section, foreign_key: 'section_number'
  has_many :instructors
end

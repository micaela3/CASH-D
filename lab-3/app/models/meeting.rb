class Meeting < ApplicationRecord
  belongs_to :section
  has_many :instructors
end

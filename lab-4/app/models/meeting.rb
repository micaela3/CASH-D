class Meeting < ApplicationRecord
  belongs_to :section
  has_many :instructors
  default_scope { order(start_time: :asc) }
end

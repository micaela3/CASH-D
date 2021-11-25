class Recommendation < ApplicationRecord
  belongs_to: grader
  has_one: instructor
end


class Section < ApplicationRecord
  belongs_to :course
  has_many :meetings
end

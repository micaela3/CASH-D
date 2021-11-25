class Instructor < ApplicationRecord
  belongs_to :meeting
  has_many :recommendation
end

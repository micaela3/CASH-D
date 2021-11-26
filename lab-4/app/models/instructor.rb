class Instructor < ApplicationRecord
  belongs_to :meeting
  has_many :recommendation, dependent: :delete_all
end

class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :ride
  has_one :review

  validates :date_begin, presence: true
  validates :date_end, presence: true
end

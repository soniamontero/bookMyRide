class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :ride

  validates :date_begin, presence: true
  validates :date_end, presence: true
end

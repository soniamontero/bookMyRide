class Ride < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :reviews, through: :bookings

  validates :name, :category, :price, presence: true
  validates :price, :year, numericality: { only_integer: true }
end

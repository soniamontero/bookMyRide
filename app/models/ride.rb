class Ride < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews
  has_many_attached :photos

  validates :name, :category, :price, :location, presence: true
  validates :price, :year, numericality: { only_integer: true }
end

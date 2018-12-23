class Ride < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews
  has_many_attached :photos

  validates :name, :category, :price, :location, presence: true
  validates :price, :year, numericality: { only_integer: true }

  def unavailable_dates
    bookings.pluck(:date_begin, :date_end).map do |range|
      { from: range[0], to: range[1] }
    end
  end
end

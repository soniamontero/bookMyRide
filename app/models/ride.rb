class Ride < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews
  has_many_attached :photos

  validates :name, :category, :price, :location, presence: true
  validates :price, :year, numericality: { only_integer: true }

  def average_ratings
    ratings = 0
    sum = 0
    reviews.each do |review|
      sum += review.rating
      ratings += 1
    end
    average = sum / ratings if ratings.positive?
  end

  def stars_rating
    self.global_rating * 2 * 10
  end
end



class Ride < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews

  validates :name, :category, :price, :location, presence: true
  validates :year, numericality: { only_integer: true }

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  mount_uploader :photo, PhotoUploader

  monetize :price_cents

  include PgSearch
  pg_search_scope :search_by_name_and_location,
    against: [ :name, :location ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }


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



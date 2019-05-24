class Ride < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings

  validates :name, :category, :price, :location,
            presence: true
  validates :name, length: { minimum: 10 }
  validates :year, numericality: { only_integer: true },
            inclusion: (1901..Time.now.year)
  validates :price, numericality: { greater_than: 0 }
  validates :description, presence: true

  monetize :price_cents

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  mount_uploader :photo, PhotoUploader

  before_create :set_default_photo

  include PgSearch
  pg_search_scope :search_by_name_and_location,
    against: [:name, :location],
    using: {
      tsearch: {
        prefix: true
      }
    }

  def set_default_photo
    if self.photo.blank?
      url = "https://nonukes.nl/wp-content/themes/gonzo/images/no-image-featured-image.png"
      self.remote_photo_url = url
    end
  end

  def has_upcoming_bookings?
    if bookings == []
      false
    else
      bookings.each do |booking|
        return true if !booking.is_over?
      end
    end
  end

  def unavailable_dates
    self.bookings.pluck(:date_begin, :date_end).map do |range|
      { from: range[0], to: range[1] }
    end
  end

  def has_been_booked_by_user?(user)
    if user.bookings.pluck(:ride_id).include?(self.id)
      user.bookings.where("ride_id = ? AND date_end < ?", self.id, Date.today)
    end
  end

  def users_who_booked
    User.where(id: self.bookings.pluck(:user_id))
  end

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

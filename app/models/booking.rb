class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :ride
  has_one :review

  monetize :amount_cents

  validates :date_begin, :date_end, presence: true

  validate :date_end_is_after_date_begin
  validate :not_overlapping_other_bookings, on: :create

  delegate :first_name, :avatar, to: :user, prefix: true

  scope :overlapping, ->(period_start, period_end) do
    where "((date_begin <= ?) and (date_end >= ?))", period_end, period_start
  end

  def is_over?
    if self.date_end < Date.today
      self.is_over = true
      true
    else
      false
    end
  end

  def current_status
    if date_end < Date.today
      state = 'Finished'
      class_name = 'finished'
      [state, class_name]
    elsif date_begin <= Date.today && date_end >= Date.today
      state = 'In Progress'
      class_name = 'in-progress'
      [state, class_name]
    elsif date_begin > Date.today
      state = 'Upcoming'
      class_name = 'upcoming'
      [state, class_name]
    end
  end

  def number_of_days
    days = (self.date_end.to_date - self.date_begin.to_date).to_i
    if days == 0
      return '1 day'
    else
      return "#{days} days"
    end
  end

  def self.renting_to_users(current_user)
    rides = current_user.rides
    bookings = []
    rides.each do |ride|
      bookings << ride.bookings
    end
    bookings.flatten
  end

  def self.renting_from_users(current_user)
    current_user.bookings
  end

  private

  def not_overlapping_other_bookings
    if Booking.where(ride_id: ride.id).overlapping(date_begin, date_end).any?
      errors.add(:date_end, 'overlaps another booking')
    end
  end

  def date_end_is_after_date_begin
    return if date_end.blank? || date_begin.blank?
    if date_end < date_begin
      errors.add(:date_end, "must be after the start date")
    end
  end
end

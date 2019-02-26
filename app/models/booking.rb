class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :ride
  has_one :review

  monetize :amount_cents

  validates :date_begin, :date_end, presence: true

  validate :date_end_is_after_date_begin
  validate :not_overlapping_other_bookings, on: :create

  scope :overlapping, ->(period_start, period_end) do
    where "((date_begin <= ?) and (date_end >= ?))", period_end, period_start
  end

  def is_over?
    self.date_end < Date.today
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

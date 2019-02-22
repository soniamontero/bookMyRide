class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :ride
  has_one :review

  validates :date_begin, :date_end, presence: true
  validate :date_end_after_date_begin

  def is_over?
    self.date_end < Date.today
  end

  private

  def date_end_after_date_begin
    return if date_end.blank? || date_begin.blank?

    if date_end < date_begin
      errors.add(:date_end, "must be after the start date")
    end
  end

end

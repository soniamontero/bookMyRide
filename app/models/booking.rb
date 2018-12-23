class Booking < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :ride

  validates :date_begin, :date_end, presence: true, availability: true
  validate :date_end_after_date_begin

  private

  def date_end_after_date_begin
    return if date_end.blank? || date_begin.blank?

    if date_end < date_begin
      errors.add(:date_end, "must be after the start date")
    end
 end
end

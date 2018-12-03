class Review < ApplicationRecord
  belongs_to :booking

  validates :title, presence: true, length: {minimum: 3}
  validates :message, allow_blank: true
  validates :rating, presence: true
end

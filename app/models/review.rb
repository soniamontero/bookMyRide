class Review < ApplicationRecord
  belongs_to :booking

  validates :title, :message, :rating, presence: true
  validates :rating, numericality: true
end

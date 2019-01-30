class Review < ApplicationRecord
  belongs_to :ride

  validates :title, :message, :rating, presence: true
  validates :rating, numericality: true
end

class Review < ApplicationRecord
  belongs_to :ride
  belongs_to :user

  validates :title, :message, :rating, presence: true
  validates :rating, numericality: true

  delegate :first_name, :avatar, to: :user, prefix: true
end

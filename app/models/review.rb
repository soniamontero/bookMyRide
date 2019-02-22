class Review < ApplicationRecord
  belongs_to :booking
  belongs_to :user

  validates :title, :message, :rating, presence: true
  validates :rating, numericality: true

  delegate :first_name, :avatar, to: :user, prefix: true
end

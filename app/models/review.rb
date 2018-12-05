class Review < ApplicationRecord
  belongs_to :ride

  # validates :title, :message, :rating, presence: true
end

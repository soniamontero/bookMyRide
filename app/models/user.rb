class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :rides, dependent: :destroy
  has_many :bookings, dependent: :destroy

  mount_uploader :avatar, PhotoUploader

  before_create :set_default_avatar

  def set_default_avatar
    if self.avatar.blank?
      url = "https://www.qualiscare.com/wp-content/uploads/2017/08/default-user.png"
      self.remote_avatar_url = url
    end
  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: [:facebook]

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

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.first_name = auth.info.name.split(" ")[0]
      user.last_name = auth.info.name.split(" ")[1..-1].join(" ")
      user.remote_avatar_url = auth.info.image + "?type=large"
      user.provider = auth.provider
      user.uid = auth.uid
      user.password = Devise.friendly_token[0, 20]
    end
  end
end

class User < ApplicationRecord
  attr_accessor :avatar
  enum role: [:user, :admin]

  has_many :adverts
  has_many :identities, dependent: :destroy

  mount_uploader :avatar, ImageUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :twitter, :vkontakte]

  def role?(checked_role)
    checked_role == role
  end

  def self.find_for_oauth(auth)
    identity = Identity.find_for_oauth(auth)
    user = identity.user
    image = auth.info.image

    if user.nil?
      email = auth.info.email
      user = User.where(email: email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
        email: email,
        password: Devise.friendly_token[0,20],
        remote_avatar_url: image.to_s)
        user.save!
      end
    end

    if image.present?
      user.update_attribute(:remote_avatar_url, image)
    end

    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end
end

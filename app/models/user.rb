class User < ApplicationRecord
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
    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)
    user = identity.user
    
    # Create the user if needed
    if user.nil?
      email = auth.info.email
      user = User.where(email: email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          email: email,
          password: Devise.friendly_token[0,20]
        )
        puts user.inspect
        user.skip_confirmation
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end
end

class User < ApplicationRecord
  enum role: [:user, :admin]

  mount_uploader :avatar, ImageUploader

  has_many :adverts

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def role?(checked_role)
    checked_role == role
  end
end

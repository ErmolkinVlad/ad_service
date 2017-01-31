class Advert < ApplicationRecord
  enum category: [:Sale, :Buy, :Exchange, :Service, :Rent]
  enum status: [:fresh, :moderation, :rejected, :published, :archive]

  validates :price, numericality: { greater_than: 0 }
  belongs_to :user
  has_many :images
  accepts_nested_attributes_for :images
end

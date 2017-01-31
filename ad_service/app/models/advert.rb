class Advert < ApplicationRecord
  include AASM

  enum category: [:Sale, :Buy, :Exchange, :Service, :Rent]
  enum status: [:recent, :moderated, :canceled, :published, :archived]

  validates :price, numericality: { greater_than: 0 }

  belongs_to :user

  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images

  aasm column: :status, enum: true do
    state :recent, initial: true
    state :moderated
    state :canceled
    state :published
    state :archived

    event :archive do
      transitions to: :archived, from: [:recent, :moderated, :published, :canceled]
    end

    event :publish do
      transitions to: :published, from: :moderated
    end

    event :cancel do
      transitions to: :canceled, from: :moderated
    end

    event :refresh do
      transitions to: :recent#, from: [:recent, :moderated, :published, :canceled, :archived]
    end

    event :moderate do
      transitions to: :moderated, from: [:recent, :archived]
    end
  end
end

class Advert < ApplicationRecord
  paginates_per 2

  include AASM
  has_paper_trail
  enum status: [:recent, :moderated, :canceled, :published, :archived]

  validates :price, numericality: { greater_than: 0 }
  validates :title, presence: true, length: { maximum: 20 }
  validates :category_id, presence: true

  belongs_to :user
  belongs_to :category

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
      transitions to: :recent
    end

    event :moderate do
      transitions to: :moderated, from: [:recent, :archived]
    end
  end

  def self.set_archive
    yesterday = Time.zone.now.ago(1.day)
    @adverts = Advert.all.select { |ad| ad.published? }
    @adverts.each do |advert|
      if advert.versions.last.changeset['updated_at'][1] < yesterday
        advert.archive!
        puts "#{Time.now} | #{advert.title} - Success!"
      end
    end
  end
end

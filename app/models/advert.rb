class Advert < ApplicationRecord
  paginates_per 10

  include AASM
  has_paper_trail
  enum status: [:recent, :moderated, :canceled, :published, :archived]
  enum ad_type: [:Sale, :Buy, :Exchange, :Service, :Rent]

  validates :price, numericality: { greater_than: 0 }
  validates :title, presence: true, length: { maximum: 20 }
  validates :category_id, presence: true
  validates :ad_type, presence: true

  belongs_to :user
  belongs_to :category

  has_many :logs, dependent: :destroy
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
      if advert.logs.last.time < yesterday
        advert.archive!
        advert.create_log(advert.user, 'Auto set after 1 day in publihed.')
        puts "#{Time.now} | #{advert.title} - Success!"
      end
    end
    puts "#{Time.now} | Done!"
  end

  def create_log(modifier, comment = nil)
    time = DateTime.now
    prev_status = self.paper_trail.previous_version.try(:status) || 'recent'
    new_status = self.status
    if prev_status != new_status
      self.logs.create(user_id: modifier.id, time: time, prev_status: prev_status, new_status: new_status, comment: comment)
    end
  end

  def owner?(user)
    user == self.user
  end
end

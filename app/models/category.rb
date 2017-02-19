class Category < ApplicationRecord
  has_many :adverts

  validates :title, presence: true, uniqueness: true
end

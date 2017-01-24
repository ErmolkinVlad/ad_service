class Advert < ApplicationRecord
  resourcify

  belongs_to :user
  belongs_to :category
end

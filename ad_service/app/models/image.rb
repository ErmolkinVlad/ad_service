class Image < ApplicationRecord
  belongs_to :advert
  mount_uploader :body, ImageUploader
end
class Log < ApplicationRecord
  belongs_to :advert
  belongs_to :user

  def to_s

  end
end

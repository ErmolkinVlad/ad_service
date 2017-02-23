class ImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  # process :convert => 'png'
  # process :tags => ['image_body']

  def default_url(*args)
    # "/images/fallback/" + [version_name, "user_avatar.png"].compact.join('_')
    'user_avatar'
  end

  version :standard do
    process eager: true
    # process resize_and_pad: [300, 300]
  end

  version :thumbnail do
    eager
    resize_to_fit(50, 50)
  end
end

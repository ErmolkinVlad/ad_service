module AdvertsHelper
  def advert_avatar(advert)
    if advert.images.present?
      image_tag(advert.images.first.body_url(:standard), class: 'brd')
    else
      image_tag('photo_icon', version: :standart, class: 'brd', size: '300x300')
    end
  end
end

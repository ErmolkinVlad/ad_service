module UsersHelper
  def user_avatar(user)
    image_tag(user.avatar_url(:standard), class: 'avatar brd')
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:notice] = 'you are not authorizes to perform this action.'
    redirect_to(request.referrer || root_path)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password,
      :password_confirmation, :remember_me, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password,
      :password_confirmation, :current_password, :avatar, :avatar_cache])
  end
end

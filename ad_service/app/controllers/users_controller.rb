class UsersController < ApplicationController
  def show
    @user = current_user
    @adverts = @user.adverts
    authorize @user
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    @user.avatar = params[:avatar]
    @user.create
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :role,
      :avatar
    )
  end
end

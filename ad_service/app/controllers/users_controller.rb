class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @adverts = @user.adverts
    authorize @user
    # if @user.show(user_params)
    #   redirect_to @user
    # else
    #   redirect_to root_path
    # end
  end

  def index
    @users = User.all
  end

  def create
    puts user_params
    @user = User.new(user_params)
    @user.avatar = params[:avatar]
    puts @user
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

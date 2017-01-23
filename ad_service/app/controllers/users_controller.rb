class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @adverts = @user.adverts
  end

  def index
    @users = User.all
  end

end

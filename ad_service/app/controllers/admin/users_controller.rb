class Admin::UsersController < ApplicationController
  def index
    @users = User.all
    authorize [:admin, User]
  end

  def show
    @user = User.find(params[:id])
    @adverts = @user.adverts.where(status: [:moderated, :published, :canceled])
  end
end
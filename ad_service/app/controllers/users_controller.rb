class UsersController < ApplicationController
  def show
    @user = current_user
    category = params[:filter].try(:fetch, :category)
    status = params[:filter].try(:fetch, :status)
    @adverts = @user.adverts.search(category_id_eq: category, status_eq: status).result(distinct: true).page params[:page]
    authorize @user
    respond_to do |format|
      format.html
      format.js
    end
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

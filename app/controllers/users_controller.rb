class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:create]
  
  def show
    @user = current_user
    authorize @user || User
    category = params[:filter].try(:fetch, :category)
    status = params[:filter].try(:fetch, :ad_type)
    @q = @user.adverts.search(category_id_eq: category, ad_type_eq: status)
    @q.sorts = 'created_at asc'
    @adverts = @q.result().page params[:page]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @user = User.new(user_params)
    @user.avatar = params[:avatar]
    @user.save
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :avatar
    )
  end
end

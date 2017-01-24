class AdvertsController < ApplicationController
  # load_and_authorize_resource
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end


  def index
  end

  def new
    authorize! :create, Advert
    @user = User.find(params[:user_id])
    @categories = Category.all.map { |c| [c.title, c.id] }
  end

  def create
    @user = User.find(params[:user_id])
    @advert = @user.adverts.create(advert_params)
    redirect_to user_path(@user)
  end

  private
    def advert_params
      params.require(:advert).permit(:title, :body, :price, :category_id)
    end


end

class AdvertsController < ApplicationController 
  def index
  end

  def new
    @user = User.find(params[:user_id])
    @categories = Category.all.map { |c| [c.title, c.id] }
    authorize Advert
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

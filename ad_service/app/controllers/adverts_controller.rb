class AdvertsController < ApplicationController 
  def index
  end

  def show
    @advert = Advert.find(params[:id])
    authorize @advert
  end

  def new
    @user = User.find(params[:user_id])
    @categories = Category.all.map { |c| [c.title, c.id] }
    authorize Advert
  end

  def create
    @user = User.find(params[:user_id])
    @advert = @user.adverts.new(advert_params)
    respond_to do |format|
      if @advert.save
        params[:images]['image_url'].each do |a|
          @image = @advert.images.create!(body: a)
        end
        format.html { redirect_to @user, notice: 'Advert was succesfully created.'}
      else
        format.html { render action: 'new' }
      end
    end
  end

  private
    def advert_params
      params.require(:advert).permit(:title, :body, :price, :category_id, image_attributes: [:id, :body, :advert_id])
    end
end

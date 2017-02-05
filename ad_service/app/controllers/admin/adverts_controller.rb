class Admin::AdvertsController < ApplicationController
  def index
    @categories = Advert.categories.symbolize_keys.keys.unshift(:All)
    @adverts = Advert.where(status: 'moderated')
    @users = User.all
    authorize [:admin, Advert]
  end

  def show
    @advert = Advert.find(params[:id])
  end

  def update
    @advert = Advert.find(params[:id])
    @advert.update(advert_params)
  end


  private

  def advert_params
  params.require(:advert).permit(
      :title,
      :body,
      :price,
      :status,
      :category,
      image_attributes: [:id, :body, :advert_id]
    )
  end
end

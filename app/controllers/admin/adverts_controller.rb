module Admin
  class AdvertsController < ApplicationController
    before_action :set_advert, only: [:show, :update]

    def index
      @categories = Category.all
      @category = Category.new
      @adverts = Advert.where(status: 'moderated')
      @users = User.all
      authorize [:admin, Advert]
    end

    def show
    end

    def update
      @advert.update(advert_params)
    end

    private

    def set_advert
      @advert = Advert.find(params[:id])
    end

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
end

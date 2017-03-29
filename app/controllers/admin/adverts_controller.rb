module Admin
  class AdvertsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_advert, only: [:show, :update]

    def index
      @categories = Category.all
      @category = Category.new
      @adverts = Advert.moderated
      @users = User.all
      authorize [:admin, Advert]
    end

    def show
    end

    def update
      @advert.update(advert_params)
      comment = params[:log].try(:fetch, :comment)
      @advert.create_log(current_user, comment)
    end

    private

    def set_advert
      @advert = Advert.find(params[:id])
    end

    def advert_params
      params.require(:advert).permit(
        :title,
        :description,
        :price,
        :status,
        :category,
        image_attributes: [:id, :body, :advert_id]
      )
    end
  end
end

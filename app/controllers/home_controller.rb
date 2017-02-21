class HomeController < ApplicationController
  def index
    category = params[:filter].try(:fetch, :category)
    status = params[:filter].try(:fetch, :ad_type)
    @adverts = Advert.where(status: :published).search(category_id_eq: category, ad_type_eq: status).result().page params[:page]
    @categories = Category.all.sort_by { |category| category.title }
    respond_to do |format|
      format.html
      format.js
    end
  end
end

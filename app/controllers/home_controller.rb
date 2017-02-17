class HomeController < ApplicationController
  def index
    category = params[:filter].try(:fetch, :category)
    @adverts = Advert.where(status: :published).search(category_id_eq: category).result().page params[:page]
    @categories = Category.all.sort_by { |category| category.title }
  end
end

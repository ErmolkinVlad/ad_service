class HomeController < ApplicationController
  def index
    category = params[:filter].try(:fetch, :category)
    status = params[:filter].try(:fetch, :ad_type)
    sorts = params[:q].try(:fetch, :s)

    @q = Advert.published.search(category_id_eq: category, ad_type_eq: status)
    @q.sorts = sorts ? sorts : 'created_at asc'
    @adverts = @q.result().page params[:page]
    respond_to do |format|
      format.html
      format.js
    end
  end
end

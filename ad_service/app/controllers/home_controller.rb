class HomeController < ApplicationController
  def index
    @q = Advert.where(status: :published).ransack(params[:q])
    @q.sorts = 'price desc' if @q.sorts.empty?
    @adverts = @q.result(distinct: true)
    @categories = Category.all.sort_by { |category| category.title }
  end

  def filter
    @category = params[:filter][:category]
    @adverts = Advert.where(status: :published).search(category_id_eq: @category).result(distinct: true)
    respond_to do |format|
      format.js
    end
  end
end

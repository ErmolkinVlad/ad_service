class HomeController < ApplicationController
  def index
    @adverts = Advert.where status: :published
  end
end

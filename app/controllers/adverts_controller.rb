class AdvertsController < ApplicationController
  before_action :authenticate_user!, except: [:search_index, :show]
  before_action :set_user, except: [:search_index, :filter]
  before_action :set_advert, except: [:show, :new, :create, :search_index]

  def show
    user = User.find(params[:user_id])
    @advert = user.adverts.select { |ad| ad.id == params[:id].to_i }.first
    if @advert.nil?
      render :file => "#{Rails.root}/public/404.html",  :status => 404
    end
  end

  def new
    @advert = @user.adverts.build
    authorize @advert
  end

  def edit
    authorize @advert
  end

  def create
    @advert = @user.adverts.new(advert_params)
    if @advert.save
      create_images
      redirect_to @user, notice: 'Advert was succesfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @advert.update(advert_params)
      @advert.refresh!
      @advert.create_log(@advert.user)
      redirect_to [@user, @advert]
    else
      render action: 'edit'
    end
  end

  def search_index
    @search_phrase = params[:q][:title_or_description_cont]
    @q = Advert.where(status: :published).ransack(params[:q])
    @q.sorts = 'price desc' if @q.sorts.empty?
    @adverts = @q.result(distinct: true).page params[:page]
    render 'search_index'
  end

  def make_archived
    @advert.archive!
    @advert.create_log(@advert.user)
    respond_to do |format|
      format.js {}
    end
  end

  def make_moderated
    @advert.moderate!
    @advert.create_log(@advert.user)
    respond_to do |format|
      format.js {}
    end
  end

  def history
    @logs = @advert.logs
  end

  private

  def set_advert
    @advert = Advert.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def create_images
    return if params[:images].nil?
    params[:images]['body'].each do |a|
      @advert.images.create!(body: a)
    end
  end

  def advert_params
    params.require(:advert).permit(
      :title,
      :description,
      :price,
      :ad_type,
      :category_id,
      image_attributes: [:id, :body, :advert_id]
    )
  end
end

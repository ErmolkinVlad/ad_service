class AdvertsController < ApplicationController
  before_action :set_user, except: [:search_index, :filter]
  before_action :set_advert, except: [:new, :create, :search_index]
  after_action :save_my_previous_url, only: [:edit]

  def index; end

  def show
    authorize @advert
  end

  def new
    @advert = @user.adverts.build
    authorize Advert
  end

  def edit
    @statuses = statuses_for_select
    authorize @advert
  end

  def create
    @advert = @user.adverts.new(advert_params)
    respond_to do |format|
      if @advert.save
        create_images
        format.html { redirect_to @user, notice: 'Advert was succesfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    if @advert.update(advert_params)
      @advert.refresh!
      redirect_to session[:my_previous_url]
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
    respond_to do |format|
      format.js {}
    end
  end

  def make_moderated
    @advert.moderate!
    respond_to do |format|
      format.js {}
    end
  end

  private

  def set_advert
    @advert = Advert.find(params[:id])
  end

  def save_my_previous_url
    session[:my_previous_url] = URI(request.referer || '').path
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

  def statuses_for_select
    statuses = @advert.aasm.states(permitted: true).map(&:name)
    statuses -= [:published, :canceled] unless @user.admin?
    statuses -= [:recent]
    statuses << @advert.status
    statuses
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

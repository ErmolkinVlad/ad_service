class AdvertsController < ApplicationController
  before_action :user

  def index; end

  def show
    @advert = Advert.find(params[:id])
    authorize @advert
  end

  def new
    @advert = @user.adverts.build
    @categories = Advert.categories
    authorize Advert
  end

  def edit
    @advert = Advert.find(params[:id])
    @available_statuses = available_statuses(@advert)
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
    @advert = Advert.find(params[:id])
    @advert.fresh!
    if @advert.update(advert_params) && @advert.valid?
      redirect_to [@user, @advert]
    else
      @available_statuses = available_statuses(@advert)
      render action: 'edit'
    end
  end

  private

  def available_statuses(advert)
    result = [:archive] << advert.status
    result << :moderation if advert.fresh? || advert.archive?
    result
  end

  def user
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
      :body,
      :price,
      :status,
      :category,
      image_attributes: [:id, :body, :advert_id]
    )
  end
end

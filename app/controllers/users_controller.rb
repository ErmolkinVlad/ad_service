class UsersController < ApplicationController
  def show
    @user = current_user
    category = params[:filter].try(:fetch, :category)
    status = params[:filter].try(:fetch, :ad_type)
    @adverts = @user.adverts.search(category_id_eq: category, ad_type_eq: status).result().page params[:page]
    authorize @user
    respond_to do |format|
      format.html
      format.js
    end
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    @user.avatar = params[:avatar]
    @user.save!
  end

  def finish_signup
    # authorize! :update, @user 
    if request.patch? && params[:user] #&& params[:user][:email]
      if @user.update(user_params)
        @user.skip_reconfirmation!
        sign_in(@user, :bypass => true)
        redirect_to @user, notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :avatar
    )
  end
end

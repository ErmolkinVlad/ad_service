module Admin
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: [:show]

    def show
      @adverts = @user.adverts.where(status: [:moderated, :published, :canceled]).page params[:page]
      authorize [:admin, User]
    end

    private

    def set_user
      @user = User.find(params[:id])
    end
  end
end

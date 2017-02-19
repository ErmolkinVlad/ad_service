module Admin
  class UsersController < ApplicationController
    before_action :set_user, only: [:show]

    def index
      @users = User.all
      authorize [:admin, User]
    end

    def show
      @adverts = @user.adverts.where(status: [:moderated, :published, :canceled]).page params[:page]
    end

    private

    def set_user
      @user = User.find(params[:id])
    end
  end
end

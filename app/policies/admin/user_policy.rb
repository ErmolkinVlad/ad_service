module Admin
  class UserPolicy
    attr_reader :user, :record

    def initialize(user, record)
      @user = user
      @record = record
    end

    def show?
      @user == @record || @user.admin?
    end

    def index?
      @user.admin?
    end
  end
end

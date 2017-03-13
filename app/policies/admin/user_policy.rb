module Admin
  class UserPolicy
    attr_reader :user, :record

    def initialize(user, record)
      @user = user || User.new
      @record = record
    end

    def show?
      @user.admin?
    end
  end
end

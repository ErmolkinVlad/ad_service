class UserPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user || User.new
    @record = record
  end

  def show?
    @user == @record || @user.admin?
  end

  def admin_index?
    @user.admin?
  end
end

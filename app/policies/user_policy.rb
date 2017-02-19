class UserPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    @user && @user == @record || @user.admin?
  end

  def admin_index?
    @user.admin?
  end
end

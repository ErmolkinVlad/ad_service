class Admin::AdvertPolicy
  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    true
  end

  def index?
    @user.admin?
  end

  def edit?
    @record.user.id == @user.id
  end

  def update?
    true
  end
end
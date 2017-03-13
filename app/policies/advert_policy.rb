class AdvertPolicy
  attr_reader :user, :advert

  def initialize(user, advert)
    @user = user || User.new
    @advert = advert
  end

  def new?
    User.exists?(@user.id) && @user == @advert.user
  end

  def create?
    new?
  end

  def edit?
    @advert.user == @user
  end

  def update?
    edit?
  end

  def destroy?
    false
  end

  def history?
    @advert.user == @user || @user.admin?
  end
end

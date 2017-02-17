class AdvertPolicy
  attr_reader :user, :advert

  def initialize(user, advert)
    @user = user || User.new
    @advert = advert
  end

  def new?
    !@user.nil?
  end

  def create?
    new?
  end

  def show?
    !@user.nil?
  end

  def edit?
    @advert.user == @user
  end

  def update?
    edit?
  end

  def destroy?
    @user == @advert.user
  end
end

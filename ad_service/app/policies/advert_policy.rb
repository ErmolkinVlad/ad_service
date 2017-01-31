class AdvertPolicy
  attr_reader :user, :advert

  def initialize(user, advert)
    @user = user
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
    @user.admin? || @advert.user == @user
  end

  def update?
    edit?
  end

  def destroy?
    @user.admin? || @user.adverts.include?(@advert)
  end
end

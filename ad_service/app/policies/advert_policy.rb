class AdvertPolicy
  attr_reader :user, :advert

  def initialize(user, advert)
    @user = user.nil? ? User.new : user
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
    true
    @advert.user == @user
  end

  def update?
    true
    edit?
  end

  def destroy?
    @user.admin? || @user.adverts.include?(@advert)
  end
end

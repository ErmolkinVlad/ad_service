class CategoryPolicy
  attr_reader :user, :category

  def initialize(user, category)
    @user = user
    @category = category
  end

  def destroy?
    false
  end
end
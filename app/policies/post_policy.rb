class PostPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    user.admin? || (user.writer? && record.user == user)
  end

  def edit?
    user.admin? || (user.writer? && record.user == user)
  end

  def destroy?
    user.admin? || (user.writer? && record.user == user)
  end
end

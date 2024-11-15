class CommentPolicy < ApplicationPolicy
  def edit?
    user.admin?
  end

  def update?
    edit?  # Same logic for update
  end

  def destroy?
    user.admin?
  end
end

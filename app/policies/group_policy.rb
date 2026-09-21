class GroupPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    true
  end

  def destroy?
    record.creator == user || user.admin?
  end
end
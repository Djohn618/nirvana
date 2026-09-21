class MembershipPolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    record.user == user ||
    record.group.creator == user ||
    user.admin?
  end
end
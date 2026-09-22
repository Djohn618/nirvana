class ActivityPolicy < ApplicationPolicy
  def index?
    user.admin?
  end
end
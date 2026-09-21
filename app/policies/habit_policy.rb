class HabitPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
  end

  def destroy?
    record.user == user
  end
end
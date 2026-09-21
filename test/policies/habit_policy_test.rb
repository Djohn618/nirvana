require "test_helper"

class HabitPolicyTest < ActiveSupport::TestCase
  test "user can delete own habit" do
    member = users(:member)
    habit = habits(:sport)
    policy = HabitPolicy.new(member, habit)
    assert policy.destroy?
  end

  test "user cannot delete foreign habit" do
    admin = users(:admin)
    habit = habits(:sport)
    policy = HabitPolicy.new(admin, habit)
    assert_not policy.destroy?
  end
end
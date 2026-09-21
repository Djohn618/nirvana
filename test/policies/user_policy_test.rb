require "test_helper"

class UserPolicyTest < ActiveSupport::TestCase
  test "admin can see user list" do
    admin = users(:admin)
    policy = UserPolicy.new(admin, User)
    assert policy.index?
  end

  test "regular user cannot see user list" do
    member = users(:member)
    policy = UserPolicy.new(member, User)
    assert_not policy.index?
  end

  test "admin can delete another user" do
    admin = users(:admin)
    member = users(:member)
    policy = UserPolicy.new(admin, member)
    assert policy.destroy?
  end

  test "admin cannot delete themselves" do
    admin = users(:admin)
    policy = UserPolicy.new(admin, admin)
    assert_not policy.destroy?
  end
end
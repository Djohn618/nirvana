require "test_helper"

class HabitTest < ActiveSupport::TestCase
  test "habit with valid name is valid" do
    user = users(:member)
    habit = Habit.new(user: user, name: "New Hobby")
    assert habit.valid?
  end

  test "habit without name is invalid" do
    user = users(:member)
    habit = Habit.new(user: user, name: "")
    assert_not habit.valid?
  end

  test "same habit name per user is not allowed" do
    user = users(:member)
    habit = Habit.new(user: user, name: "Workout")
    assert_not habit.valid?
  end
end
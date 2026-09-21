require "test_helper"

class HabitLogTest < ActiveSupport::TestCase
  test "only one log per habit per day per user" do
    user = users(:member)
    sport = habits(:sport)
    duplicate = HabitLog.new(user: user, habit: sport, date: Date.today, completed: true)
    assert_not duplicate.valid?
  end

  test "log on different days is allowed" do
    user = users(:member)
    sport = habits(:sport)
    log = HabitLog.new(user: user, habit: sport, date: Date.yesterday, completed: true)
    assert log.valid?
  end
end
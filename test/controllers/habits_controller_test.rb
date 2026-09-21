require "test_helper"

class HabitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:member)
    post session_path, params: { email: "user@test.ch", password: "User12345678" }
  end

  test "logged in user sees habits" do
    get habits_path
    assert_response :success
  end

  test "not logged in user is redirected to login" do
    delete destroy_session_path
    get habits_path
    assert_redirected_to new_session_path
  end
end
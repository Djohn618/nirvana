require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "user with valid data is valid" do
    user = User.new(
      username: "TestPerson",
      email: "test@example.ch",
      password: "Sicher12345678",
      password_confirmation: "Sicher12345678"
    )
    assert user.valid?
  end

  test "user without email is invalid" do
    user = User.new(username: "Test", password: "Sicher12345678")
    assert_not user.valid?
  end

  test "password must have at least 12 characters" do
    user = User.new(
      username: "Test",
      email: "test@example.ch",
      password: "short",
      password_confirmation: "short"
    )
    assert_not user.valid?
  end

  test "email must be unique" do
    User.create!(username: "A", email: "dup@test.ch",
                 password: "Sicher12345678", password_confirmation: "Sicher12345678")
    user2 = User.new(username: "B", email: "dup@test.ch",
                     password: "Sicher12345678", password_confirmation: "Sicher12345678")
    assert_not user2.valid?
  end
end
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new( username: "Makatunga", email: "makatunga@makatunga.com", 
                      password: "cartoon", password_confirmation: "cartoon")
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "username should be present" do
    @user.username = " "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end
end

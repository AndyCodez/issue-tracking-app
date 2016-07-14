require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "valid signup information with activation sent but not activated" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params:{
        user: {
          username: "Valid User",
          email: "valid@email.com",
          password: "validpassword",
          password_confirmation: "validpassword"
        }
      } 
      assert_equal 1, ActionMailer::Base.deliveries.size
      user = assigns(:user)
      assert_not user.activated?
      #can log in for upto 2 days without activation
      assert is_logged_in?
      assert_not flash.empty?
      assert_redirected_to root_url
      follow_redirect!
      assert_template 'static_pages/home'
      end 
  end

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params:{
        user: {
          username: "",
          email: "invalid@email",
          password: "foo",
          password_confirmation: "bar"
        }
      }
      assert_template 'users/new'
    end
  end
end

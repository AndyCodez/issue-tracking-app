require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "valid signup information" do
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
      follow_redirect!
      assert_template 'users/show'
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

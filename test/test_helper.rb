ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Returns true if test user is logged in
  def is_logged_in?
    !session[:user_id].nil?
  end

  #Logs in a test user
  def log_in_as(user, options = {})
    password = options[:password] || 'password'
    remember_me = options[:remember_me] || '1'

    if integration_test?
      #Login by posting to the sessions path
      post login_path, params: {
              session:{ username: user.username, 
                                password: password,
                                remember_me: remember_me
                      }
                }
    else
      #Login using the session
      session[:user_id] - user.id
    end
  end

  #Returns a random time upto now
  def time_rand from = 0.0, to = Time.now
          Time.at(from + rand * (to.to_f - from.to_f))
  end

  private
    #Returns true inside an integration test
    def integration_test?
      defined?(post_via_redirect)
    end
end

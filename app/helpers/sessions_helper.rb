module SessionsHelper

  #Logs in the given user
  def log_in(user)
    #sets the session called 'user_id' to user.id
    session[:user_id] = user.id
  end

  #Returns the current logged-in user if any
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  #User is logged in if current_user is not nil (Returns true if user is logged in)
  def logged_in?
    !current_user.nil?
  end

  #Logs out current user
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  #Remembers a user in a persistent session
  def remember(user)
    #Calls the remember method which is in user.rb
    #It assigns the user a remember_token and creates and stores a digest of the token in the db
    user.remember
    cookies.signed[:user_id] = user.id
    cookies[:remember_token] = { value: user.remember_token, expires: 7.days.from_now }
  end

  #Forgets a persistent session
  def forget(user)
    #calls the forget method in user.rb
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
end

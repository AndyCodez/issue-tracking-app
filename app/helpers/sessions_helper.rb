module SessionsHelper

  #Logs in the given user
  def log_in(user)
    #sets the session called 'user_id' to user.id
    session[:user_id] = user.id
  end

  #Returns the current logged-in user if any
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  #User is logged in if current_user is not nil (Returns true if user is logged in)
  def logged_in?
    !current_user.nil?
  end

  #Logs out current user
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end

class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      if time_from_signup(user) > 2.days && !user.activated?
        #Deny full access to app functionality
        log_in user
        flash[:danger] = "Please check your email and activate your account."
        redirect_to root_url
      else
        #Allow access
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user) 
        if current_user.admin?
          redirect_to issues_path
        else
          redirect_to user
        end
      end
    else
      flash.now[:alert] = "Invalid username/password combination"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end

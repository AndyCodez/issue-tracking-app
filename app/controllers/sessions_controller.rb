class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      redirect_to user
    else
      flash.now[:alert] = "Invalid username/password combination"
      render 'new'
    end
  end
end

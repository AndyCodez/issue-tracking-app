class AccountActivationsController < ApplicationController
  before_action :check_expiration, only: [:edit]

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "You have been activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end

  #Checks expiration of activation token
  private
    def check_expiration
      user = User.find_by(email: params[:email])
      if user.activation_token_expired?
        flash[:alert] = "Sorry, your activation link has expired."
        redirect_to root_url
      end
    end
end

include Recaptcha::Verify
include Recaptcha::ClientHelper

class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if verify_recaptcha(model: @user) && @user.save
      @user.send_activation_email
      log_in @user
      #note to self: change flash to info and blue later 
      flash[:success] = "We've sent you an activation link. Please check your email."
      redirect_to root_url
      
    else
      render 'new'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @issues = @user.issues
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end

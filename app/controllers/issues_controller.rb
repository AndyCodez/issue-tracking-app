class IssuesController < ApplicationController
  before_action :admin_user, only: [:change_status_to_in_progress, :change_status_to_resolved, 
                                    :change_status_to_closed]

  def new
    @issue = Issue.new
  end

  def create
    @issue = current_user.issues.build(issue_params)
    if @issue.save
      send_issue_raised_email
      flash[:success] = "Your issue has been recorded."
      redirect_to current_user
    else
      flash.now[:alert] = "There was a problem submitting your issue."
      render 'new'
    end
  end

  def show
    @issue = current_user.issues.find_by(id: params[:id])
    #The issue in the admin's view
    @issue_admin = Issue.find_by(id: params[:id])
    #To help build the comment form 
    @comment = Comment.new
    #Returns all the comments associated with the current issue
    @comments = @issue_admin.comments
  end

  def index
    @issues = Issue.all
  end

  #Executes when issue is assigned
  def change_status_to_in_progress
    user = User.find_by(id: params[:user_id])
    user.send_issue_assigned_email
    issue = Issue.find_by(id: params[:id])
    issue.update_attribute(:status, "inprogress")
    flash[:success] = "Issue status changed to in progress!"
    redirect_to issues_path
  end

  def change_status_to_resolved
    user = User.find_by(id: params[:user_id])
    user.send_issue_resolved_email
    issue = Issue.find_by(id: params[:id])
    issue.update_attribute(:status, "resolved")
    flash[:success] = "Issue status changed to resolved!"
    redirect_to issues_path
  end

  def change_status_to_closed
    user = User.find_by(id: params[:user_id])
    user.send_issue_closed_email
    issue = Issue.find_by(id: params[:id])
    issue.update_attribute(:status, "closed")
    flash[:success] = "Issue status changed to closed!"
    redirect_to issues_path
  end

  private

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def issue_params
    params.require(:issue).permit(:title, :description, :priority)
  end
end

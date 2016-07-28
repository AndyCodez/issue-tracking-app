class IssuesController < ApplicationController
  before_action :admin_user, only: [:index, :change_status_to_in_progress, :change_status_to_resolved, 
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
    #To help build the comment form 
    @comment = Comment.new
    if current_user.admin?
    #The issue in the admin's view
    @issue_admin = Issue.find_by(id: params[:id])
    #Returns all the comments associated with the current issue for admin's view
    @comments_admin = @issue_admin.comments
    else
    #The issue for the current user's view
    @issue = current_user.issues.find_by(id: params[:id])
    #Returns all the comments associated with the current issue for user's view
    @comments = @issue.comments
    end
  end

  def index
    @issues = Issue.all
  end

  def change_status_to_open
    user = User.find_by(id: params[:user_id])
    user.send_issue_open_email
    issue = Issue.find_by(id: params[:id])
    issue.update_attribute(:status, "open")
    flash[:success] = "Issue status changed to open!"
    redirect_to issues_path
  end

  def choose_expert
    @users = User.where(expert: true)
    @issue = Issue.find_by(id: params[:id])
  end

  #Executes when issue is assigned
  def change_status_to_in_progress
    user = User.find_by(id: params[:user_id])
    user.send_issue_assigned_email
    issue = Issue.find_by(id: params[:id])
    expert = User.find_by(id: params[:expert_id])
    issue.update_attributes(status: "inprogress", expert_id: expert.id)
    flash[:success] = "Issue status changed to in progress! Assigned to #{expert.username}"
    redirect_to issues_path
  end

  #Executes when issue is resolved
  def change_status_to_resolved
    user = User.find_by(id: params[:user_id])
    user.send_issue_resolved_email
    issue = Issue.find_by(id: params[:id])
    issue.update_attribute(:status, "resolved")
    flash[:success] = "Issue status changed to resolved!"
    redirect_to issues_path
  end

  #Executes when issue is closed
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

class IssuesController < ApplicationController

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
    @issue_admin = Issue.find_by(id: params[:id])
  end

  def index
    @issues = Issue.all
  end


  def change_status_to_in_progress
    issue = Issue.find_by(id: params[:id])
    issue.update_attribute(:status, "inprogress")
    redirect_to issues_path
  end
  
  def change_status_to_resolved
    issue = Issue.find_by(id: params[:id])
    issue.update_attribute(:status, "resolved")
    redirect_to issues_path
  end

  def change_status_to_closed
    issue = Issue.find_by(id: params[:id])
    issue.update_attribute(:status, "closed")
    redirect_to issues_path
  end

  private
    def issue_params
      params.require(:issue).permit(:title, :description, :priority)
    end
end

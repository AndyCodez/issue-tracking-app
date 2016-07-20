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
  end

  def index
  end

  private
    def issue_params
      params.require(:issue).permit(:title, :description, :priority)
    end
end

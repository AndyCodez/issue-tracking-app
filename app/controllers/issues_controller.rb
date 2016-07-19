class IssuesController < ApplicationController

  def new
    @issue = Issue.new
  end

  def create
    @issue = Issue.new(issue_params)
    if @issue.save
      flash[:success] = "Your issue has been recorded."
      redirect_to root_url
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
      params.require(:issue).permit(:description)
    end
end

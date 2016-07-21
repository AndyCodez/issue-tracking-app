class CommentsController < ApplicationController

  def create
    @issue = Issue.find_by(id: params[:id])
    @comment = @issue.comments.build(comment_params)
    if @comment.save
      flash[:success] = "Comment has been added!"
      redirect_back fallback_location: root_url
    else
      flash[:alert] = "Please provide comment"
      redirect_back fallback_location: root_url
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end

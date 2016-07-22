class CommentsController < ApplicationController

  def create
    @issue = Issue.find_by(id: params[:id])
    @comment = @issue.comments.build(comment_params)
    if @comment.save
      user = User.find_by(id: params[:user_id])
      user.send_comment_made_email
      flash[:success] = "Comment has been added!"
      redirect_back fallback_location: root_url
    else
      flash[:alert] = "Please provide comment"
      redirect_back fallback_location: root_url
    end
  end

  def index
    @issue = current_user.issues.find_by(id: params[:id])
    #Returns all the comments associated with the current issue for current user
    @comments = @issue.comments
  end
  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end

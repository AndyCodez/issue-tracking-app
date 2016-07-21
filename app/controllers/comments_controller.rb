class CommentsController < ApplicationController

  def create
    @issue = Issue.find_by(id: params[:id])
    @comment = @issue.comments.build(comment_params)
    if @comment.save
      flash[:success] = "Comment has been added!"
      redirect_to root_url
    # else
      # render 'issues/show'
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end

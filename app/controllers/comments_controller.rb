class CommentsController < ApplicationController

  def create
    @comment = Comment.new(create_params)
    if @comment.save
      redirect_to letter_path(@comment.letter)
    else
      redirect_to letter_path(@comment.letter)
    end
  end

  private
  def create_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, letter_id: params[:letter_id])
  end
end

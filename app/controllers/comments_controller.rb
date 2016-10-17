class CommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    @comment = Comment.new(create_params)
    if @comment.save
      redirect_to :back
    else
      flash[:alert] = "コメントを作成できませんでした。"
      redirect_to :back
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to :back
    else
      flash[:alert] = "コメントを削除できませんでした。"
      redirect_to :back
    end
  end

  private
    def create_params
      params.require(:comment).permit(:content).merge(user_id: current_user.id, letter_id: params[:letter_id])
    end
end

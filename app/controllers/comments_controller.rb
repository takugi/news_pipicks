class CommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    if Comment.create(create_params)
      flash[:notice] = ""
    else
      flash[:alert] = "Pickできませんでした。"
    end
    redirect_to :back
  end

  def destroy
    if Comment.find(params[:id]).destroy
      flash[:notice] = "Pickを削除しました。"
    else
      flash[:alert] = "Pickを削除できませんでした。"
    end
    redirect_to :back
  end

  private
    def create_params
      params.require(:comment).permit(:content).merge(user_id: current_user.id, letter_id: params[:letter_id])
    end
end

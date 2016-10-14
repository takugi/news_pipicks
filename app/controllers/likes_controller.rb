class LikesController < ApplicationController

  before_action :set_letter, only: [:create, :destroy]

  def create
    Like.create(likes_params)
  end

  def destroy
    Like.find_by(likes_params).destroy
  end

  private
  def likes_params
    params.permit(:comment_id).merge(user_id: current_user.id)
  end

  def set_letter
    @letter = Letter.find(params[:letter_id])
  end

  def set_comment
    @comment = Comment.find_by(letter_id: @letter.id, user_id: current_user.id)
  end
end

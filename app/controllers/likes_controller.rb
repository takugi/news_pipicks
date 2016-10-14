class LikesController < ApplicationController

  before_action :set_letter, only: [:create, :destroy]

  def create
    @like = Like.new(likes_params)
    if @like.save
      redirect_to letter_path(@letter)
    else
      redirect_to letter_path(@letter)
    end
  end

  def destroy
    if Like.find_by(likes_params).destroy
      redirect_to letter_path(@letter)
    else
      redirect_to letter_path(@letter)
    end
  end

  private
  def likes_params
    params.permit(:comment_id).merge(user_id: current_user.id)
  end

  def set_letter
    @letter = Letter.find(params[:letter_id])
  end
end

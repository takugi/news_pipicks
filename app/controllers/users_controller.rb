class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :set_user

  def show
    @letters = Letter.search_with_user_comment_letter(@user)
  end

  def edit
  end

  def update
    if current_user == @user
      if @user.update(update_params)
        redirect_to root_path
      else
        redirect_to edit_user_path(current_user)
      end
    else
      redirect_to root_path
    end
  end

  def following
    @follows = @user.following
  end

  def followers
    @follows = @user.followers
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def update_params
    params.require(:user).permit(:avatar, :last_name, :firstname, :profile)
  end
end

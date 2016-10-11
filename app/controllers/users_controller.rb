class UsersController < ApplicationController

  has_many :comments

  before_action :set_user, only: [:show, :edit, :update]
  before_action :authenticate_user!

  def show
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

  private
  def set_user
    @user = User.find(params[:id])
  end

  def update_params
    params.require(:user).permit(:avatar, :last_name, :firstname, :profile)
  end
end

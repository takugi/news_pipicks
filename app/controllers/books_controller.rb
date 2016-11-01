class BooksController < ApplicationController

  before_action :authenticate_user!

  def index
    @books = Book.all
    @user = User.find(params[:user_id])
  end
end

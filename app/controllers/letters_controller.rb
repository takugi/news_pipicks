class LettersController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]

  def index
    @letters = Letter.order("created_at desc").first(9)
    @better_letters = Letter.with_better_letters
    @categories = Letter.select_categories
  end

  def new
  end

  def create
    @letters = Letter.order("created_at desc")
    unless @letters.pluck(:url).include?(url_params[:url])
      letter = Letter.new(url_params)
      if letter.save
        letter.create_letter
        flash[:notice] = ""
        redirect_to letter_path(letter)
      else
        flash[:alert] = "投稿に失敗しました。"
        redirect_to :back
      end
    else
      @select_letter = Letter.find_by(url: url_params[:url])
      redirect_to letter_path(@select_letter)
    end
  end

  def show
    @letter = Letter.find(params[:id])
    @comments = @letter.comments
    @comment = Comment.new
    @create_storage = Storage.new
    @delete_storage = Storage.find_by(user_id: current_user.id, letter_id: @letter)
  end

  private
    def url_params
      params.permit(:url)
    end
end

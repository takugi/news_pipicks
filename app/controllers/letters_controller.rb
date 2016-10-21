class LettersController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]

  def index
    @letters = Letter.order("created_at desc")
    @better_letters = Letter.with_better_letters
  end

  def new
  end

  def create
    letter = Letter.new(url_params)
    if letter.save
      letter.create_letter
      flash[:notice] = "正常に投稿できました。"
      redirect_to letter_path(letter)
    else
      flash[:alert] = "投稿に失敗しました。"
      redirect_to :back
    end
  end

  def show
    @letter = Letter.find(params[:id])
    @comments = @letter.comments
    @comment = Comment.new
  end

  private
    def url_params
      params.permit(:url)
    end
end

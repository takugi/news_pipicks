class LettersController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_letters, only: [:index, :create]

  def index
    @better_letters = Letter.with_better_letters
  end

  def new
  end

  def create
    unless @letters.pluck(:url).include?(url_params[:url])
      letter = Letter.new(url_params)
      if letter.save
        letter.create_letter
        flash[:notice] = "正常に投稿できました。"
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
  end

  private
    def set_letters
      @letters = Letter.order("created_at desc")
    end

    def url_params
      params.permit(:url)
    end
end

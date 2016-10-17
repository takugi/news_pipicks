class LettersController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_letter, only: [:show]
  before_action :set_comments, only: [:show]

  def index
    @letters = Letter.order("created_at desc")
  end

  def new
    @letter = Letter.new
  end

  def create
    letter = Letter.new(url_params)
    if letter.save
      letter.create_letter
      redirect_to letter_path(letter)
    else
      redirect_to new_letter_path
    end
  end

  def show
    @comment = Comment.new
  end


  private
  def url_params
    params.permit(:url)
  end

  def set_letter
    @letter = Letter.find(params[:id])
  end

  def set_comments
    @comments = @letter.comments
  end
end

class LettersController < ApplicationController

  before_action :set_letter, only: [:show]
  before_action :set_comments, only: [:show]
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @letters = Letter.order("created_at desc")
  end

  def new
    @letter = Letter.new
  end

  def create
    letter = Letter.new(url: url_params)
    if letter.save
      letter.create_letter
      redirect_to root_path
    else
      redirect_to new_letter_path
    end
  end

  def show
    @comment = Comment.new
  end


  private
  def url_params
    params.require(:url)
  end

  def set_letter
    @letter = Letter.find(params[:id])
  end

  def set_comments
    @comments = @letter.comments
  end
end

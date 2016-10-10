class LettersController < ApplicationController

  before_action :set_letter, only: [:show]

  def index
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
  end


  private
  def url_params
    params.require(:url)
  end

  def set_letter
    @letter = Letter.find(params[:id])
  end
end

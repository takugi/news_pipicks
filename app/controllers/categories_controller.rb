class CategoriesController < ApplicationController
  def show
    @classified_letters = Letter.classify_letters(params[:id])
  end
end

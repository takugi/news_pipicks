class BooksController < ApplicationController

  before_action :authenticate_user!

  def index
    @books = Book.all
    @user = User.find(params[:user_id])
  end

  def new
    if params[:keyword].present?
      Amazon::Ecs.debug = true

      books = Amazon::Ecs.item_search(
        params[:keyword],
        search_index: 'Books',
        dataType: 'script',
        response_group: 'ItemAttributes, Images',
        country: 'jp',
        power: 'Not kindle'
      )

      @search_books = []
      books.items.each do |item|
        book = Book.new(
          title: item.get('ItemAttributes/Title'),
          image: item.get('LargeImage/URL'),
          url: item.get('DetailPageURL'),
          author: item.get('ItemAttributes/Author'),
          manufacturer: item.get('ItemAttributes/Manufacturer'),
        )
        @search_books.push(book)
      end
    end
  end

  def create
    book = Book.new(create_params)
    if book.save
      flash[:notice] = "おすすめ本を投稿しました。"
      redirect_to user_book_path(current_user, book)
    else
      flash[:alert] = "おすすめ本の投稿に失敗しました。"
      redirect_to :back
    end
  end

  private
    def create_params
      params.require(:book).permit(:title, :image, :url, :author, :manufacturer).merge(user_id: current_user.id)
    end
end

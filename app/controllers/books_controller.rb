class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def new

  end

  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @book2 = Book.new
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
       render "edit"
    else
       redirect_to books_path
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else

      render :edit, status: :unprocessable_entity
    end
  end

   private

  def book_params
    params.require(:book).permit(:title, :image, :body)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
  unless @user == current_user
    redirect_to(books_path)
  end
  end
end

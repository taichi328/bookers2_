class UsersController < ApplicationController

  def index
    @users = User.all

  end

  def show
    @book = Book.new
    @books = Book.all
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
       render "edit"
    else
       redirect_to books_path
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(@user.params)
    redirect_to user_path(current_user.id)
  end
end


private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end



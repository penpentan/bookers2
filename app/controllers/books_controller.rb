class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  # def new　#フォームを表示させるためのアクション
  #   @book=Book.new
  # end

  def create #新規作成した本の内容を保存
    @book = Book.new(book_params) #フォームからデータを受け取り
    @book.user_id = current_user.id #フォームに含まれないidを補完
    if @book.save
      flash[:notice] = "successfully create"
      redirect_to book_path(@book.id) #bookのshow画面に戻る
    else
      @books=Book.all
      render :index
    end
  end

  def index #本の一覧を取得
    @books=Book.all
    @book = Book.new
  end

  def show #本の詳細を取得して表示
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "successfully update"
      redirect_to book_path(params[:id]) #とりあえず
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end
  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user == current_user
      redirect_to books_path
    end
  end

end

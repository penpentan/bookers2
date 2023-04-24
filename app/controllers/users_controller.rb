class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def index #ユーザの一覧を取得して表示
    @users = User.all
  end

  def edit #ユーザ名を表示
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @books =@user.books
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "successfully update"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:profile_image,:name,:introduction)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

end

class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :followings, :followers]
  before_action :set_users, only: [:followings, :followers]
  before_action :logged_in_user, only: [:edit, :update]
  before_action :collect_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      # 保存に成功した場合はトップページへリダイレクト
      redirect_to @user, notice: 'アカウント情報を更新しました'
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  
  def followings
    @title = "Followings"
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    render 'show_follow'
  end

  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :region)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def set_users
    @users = @user.follower_users
  end
  
  # beforeフィルター
  # ログイン済みか確認
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in"
      redirect_to root_path
    end
  end
  
  # 正しいユーザか確認
  def collect_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
end

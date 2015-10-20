class UsersController < ApplicationController

  def show
   @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Samle App!"
      redirect_to @user
    else
      render 'new'
    end
  end
    
  def edit
    @user = current_user
  end
    
  def update
    @user = User.find(params[:id])
    if @user.save
      flash[:success] = "プロフィールを更新しました"
      redirect_to current_user
    else
      render 'edit'
    end
  end
  
    
  private
  
  def user_params
    params.require(:user).permit(:name, :area, :profile, :email, :password, :password_confirmation)
  end
  
end

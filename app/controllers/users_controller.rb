class UsersController < ApplicationController
  def index
    gon.users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = "Created success!"
      redirect_to root_path
    else
      flash[:danger] = "Something wrong!!!"
      render :new
    end
  end

  def destroy
    logge_out
    redirect_to roo_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :address, :password, :password_confirmation)
  end
end

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
      @user.send_activation_email
      Dir.mkdir "#{Settings.dir_store_data}/user#{@user.id}" unless File.exist?("#{Settings.dir_store_data}/user#{@user.id}")
      Dir.mkdir "#{Settings.dir_store_data}/user#{@user.id}/test_suites" unless File.exist?("#{Settings.dir_store_data}/user#{@user.id}/test_suites")
      Dir.mkdir "#{Settings.dir_store_data}/user#{@user.id}/layout" unless File.exist?("#{Settings.dir_store_data}/user#{@user.id}/layout")
      Dir.mkdir "#{Settings.dir_store_data}/user#{@user.id}/report" unless File.exist?("#{Settings.dir_store_data}/user#{@user.id}/report")
      flash[:info] = "Please check your email to activate your account."
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

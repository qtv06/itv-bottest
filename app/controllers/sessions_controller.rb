class SessionsController < ApplicationController
  include SessionsHelper

  def new

  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] = "Welcome to Bottest"
      redirect_to root_path
    else
      flash[:danger] = "Invalid Email/Password!!!"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end

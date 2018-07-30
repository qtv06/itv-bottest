class UsersController < ApplicationController
  def index
    gon.users = User.all
  end
end

class LayoutsController < ApplicationController
	include LayoutsHelper

	before_action :authenticate_user!
	before_action :read_layout
  
  def index
  end

  def new
  	# debugger
    @layout = Layout.new
  end

  def create
    if params[:layout][:name].present?
      layout = {}
      layout["id"] = (@big_id + 1).to_s

      layout["name"] = params[:layout][:name]
      layout["width"] = params[:layout][:width]
      layout["height"] = params[:layout][:height]
      layout["user_id"] = current_user.id
      layout["created_at"] = Time.current
      debugger

      # @layoutes << layout
      write_layouts layout
      flash[:success] = "#{layout["name"]} Added Successfully!!"
    else
      flash[:danger] = "Some thing wrong!"
    end
    redirect_to layouts_path
  end

  def destroy
    path_layout_delete = "#{Settings.dir_store_data}/user#{current_user.id}/layout/layout#{params["id"]}"
    if File.exist?(path_layout_delete)
      FileUtils.rm_rf(path_layout_delete)
      flash[:success] = "Deleted TestSuit Complete"
    else
      flash[:danger] = "Have a few wrong!!"
    end
    redirect_to layouts_path
  end
end

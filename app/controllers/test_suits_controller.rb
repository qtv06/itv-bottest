class TestSuitsController < ApplicationController
  include TestSuitsHelper
  include TestCasesHelper

  before_action :authenticate_user!
  before_action :read_test_suites, except: %i(new)
  before_action :read_test_suites_of_user, only: :index
  before_action :find_testsuit_for_edit, only: %i(edit update)

  def index
  end

  def new
    @test_suit = TestSuit.new
  end

  def create
    if params[:test_suit][:name].present?
      test_suit = {}
      test_suit["id"] = (@big_id + 1).to_s
      test_suit["name"] = params[:test_suit][:name]
      test_suit["user_id"] = current_user.id
      test_suit["created_at"] = Time.current

      # @test_suites << test_suit
      write_test_suite_to_file_xml test_suit
      flash[:success] = "#{test_suit["name"]} Added Successfully!!"
    else
      flash[:danger] = "Some thing wrong!"
    end
    redirect_to root_path
  end

  def edit
    @test_cases = []
    if params[:id]
      @test_cases = read_test_cases(params[:id])
    end
    # render xml: test_suit_doc
  end

  def update
    count = 0
    test_suit = {}
    @test_suites.each do |ts|
      if ts["id"] == params[:id]
        ts["name"] = params[:test_suit][:name]
        test_suit = ts
        count += 1
        break
      end
    end
    if count > 0
      write_test_suite_to_file_xml test_suit
      flash[:success] = "Updated TestSuit Successful!!"
      redirect_to root_path
    else
      flash[:danger] = "Something wrong!!"
      render :edit
    end
  end

  def destroy
    path_test_suit_delete = "lib/xml/user#{current_user.id}/test_suites/test_suit#{params["id"]}"
    if File.exist?(path_test_suit_delete)
      FileUtils.rm_rf(path_test_suit_delete)
      flash[:success] = "Deleted TestSuit Complete"
    else
      flash[:danger] = "Have a few wrong!!"
    end
    redirect_to test_suits_path
  end

  private


  def find_testsuit_for_edit
    @test_suit = TestSuit.new
    @test_suites.each do |ts|
      if ts["id"] == params[:id]
        @test_suit.name = ts["name"]
        @test_suit.id = ts["id"]
      end
    end
    redirect_to root_path if @test_suit.blank?
  end
end

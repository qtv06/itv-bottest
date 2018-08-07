class TestSuitsController < ApplicationController
  include TestSuitsHelper
  before_action :authenticate_user!
  before_action :read_test_suites
  before_action :find_testsuit_for_edit, only: %i(edit update)
  before_action :find_testsuit, only: %i(destroy)
  def index
    # @test_suites = TestSuit.all

    # render html: @test_suites
  end

  def new
    @test_suit = TestSuit.new
  end

  def create
    if params[:test_suit][:name].present?
      test_suit = {}
      test_suit['id'] = (@big_id + 1).to_s
      test_suit["name"] = params[:test_suit][:name]
      test_suit["created_at"] = Time.current

      @test_suites << test_suit

      write_test_suite_to_file_xml @test_suites
      flash[:success] = "#{test_suit["name"]} Added Successfully!!"
    else
      flash[:danger] = "Some thing wrong!"
    end
    redirect_to root_path
  end

  def edit
    @test_cases = []
    test_suit_doc = Nokogiri::XML(File.open("lib/xml/"))


  end

  def update
    count = 0
    @test_suites.each do |ts|
      if ts["id"] == params[:id]
        ts["name"] = params[:test_suit][:name]
        count += 1
        break
      end
    end
    if count > 0
      write_test_suite_to_file_xml @test_suites
      flash[:success] = "Updated TestSuit Successful!!"
      redirect_to root_path
    else
      flash[:danger] = "Something wrong!!"
      render :edit
    end
  end

  def destroy
    if @test_suites.delete(@test_suit)
      write_test_suite_to_file_xml @test_suites
      flash[:success] = "Deleted TestSuit Complete"
    else
      flash[:danger] = "Have a few wrong!!"
    end
    redirect_to test_suits_path
  end

  private

  def find_testsuit
    @test_suit = {}

    @test_suites.each do |ts|
      if ts["id"] == params[:id]
        @test_suit = ts
      end
    end
    redirect_to root_path if @test_suit.blank?
  end

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

  def read_test_suites
    @test_suites = []
    @big_id = 1
    doc = Nokogiri::XML(File.open("lib/xml/test_suits.xml"))

    doc.xpath("//TestSuit").each do |ts|
      objTestSuit = {}
      objTestSuit["id"] = ts.at_xpath("Id").text
      @big_id = @big_id > objTestSuit["id"].to_i ? @big_id : objTestSuit["id"].to_i
      objTestSuit["name"] = ts.at_xpath("Name").text
      objTestSuit["created_at"] = ts.at_xpath("CreatedAt").text

      @test_suites << objTestSuit
    end
  end
end

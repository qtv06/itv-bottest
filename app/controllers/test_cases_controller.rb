class TestCasesController < ApplicationController
  include TestCasesHelper
  before_action :authenticate_user!
  before_action :read_test_suites
  before_action :find_test_suit
  before_action :read_test_cases_of_test_suit, except: %i(index new)
  before_action :find_test_case, only: %i(edit update destroy)
  before_action :read_action, only: :edit

  def index
  end

  def new
    @test_case = TestCase.new
  end

  def create
    @test_case = TestCase.new
    name = params[:test_case][:name]
    if !name.blank?
      @test_case.id = @big_id_tc + 1
      @test_case.name = name
      @test_case.created_at = Time.current

      write_test_case_to_file_xml(@test_case, @test_suit.id)
      flash[:success] = "Add Successful!!"
      redirect_to edit_test_suit_path(@test_suit)
    else
      flash[:danger] = "Have some wrong"
      redirect_to new_test_suit_test_case_path @test_suit, @test_case
    end
  end

  def edit
    lsTestScript = []
    doc_script = Nokogiri::XML(File.open("lib/xml/user#{current_user.id}/test_suites/test_suit#{@test_suit.id}/test_case#{@test_case.id}.xml"));

    doc_script.xpath("//step").each do |script|

      objScript = {}
      objScript["name"] = script.at_xpath("name").text
      objScript["action_id"] = script.at_xpath("IdAction").text
      arguments = []
      script.xpath("arguments//argument").each do |arg|
        objArg = {}
        objArg["name"] = arg.at_xpath("name").text
        objArg["value"] = arg.at_xpath("value").text
        arguments << objArg
      end
      objScript["arguments"] = arguments
      lsTestScript << objScript
    end
    gon.test_suit_id = @test_suit.id
    gon.test_actions = @test_actions
    gon.test_case = @test_case
    gon.test_scripts = lsTestScript
    gon.action_have_text = @action_have_text
  end

  def update
    count = 0
    test_case = TestCase.new
    name = params[:test_case][:name]
    @test_cases.each do |tc|
      if tc.id == params[:id].to_i
        tc.name = name
        test_case = tc
        count += 1
        break
      end
    end

    if count > 0
      write_test_case_to_file_xml(test_case, @test_suit.id)
      flash[:success] = "Test case #{name} successfully updated"
    else
      flash[:danger] = I18n.t "flash.danger"
    end
    redirect_to edit_test_suit_test_case_path(@test_suit, @test_case)
  end

  def destroy
    test_case_file = "lib/xml/user#{current_user.id}/test_suites/test_suit#{@test_suit.id}/test_case#{params['id']}.xml"
    if File.exist? test_case_file
      FileUtils.rm_rf test_case_file
      flash[:success] = "Test case #{@test_case.name} successfully deleted"
    else
      flash[:danger] = I18n.t "flash.danger"
    end
    redirect_to edit_test_suit_path(@test_suit)
  end
  private

  def find_test_suit
    @test_suit = TestSuit.new
    @test_suites.each do |ts|
      if ts["id"] == params[:test_suit_id]
        @test_suit.name = ts["name"]
        @test_suit.id = ts["id"]
      end
    end
    redirect_to root_path if @test_suit.blank?
  end

  def find_test_case
    @test_case = TestCase.new
    @test_cases.each do |tc|
      if tc.id == params[:id].to_i
        @test_case = tc
      end
    end
    redirect_to root_path if @test_case.blank?
  end

  def read_test_cases_of_test_suit
    @test_cases = read_test_cases @test_suit.id
  end
end

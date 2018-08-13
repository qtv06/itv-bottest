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
      @test_cases << @test_case

      write_test_case_to_file_xml(@test_cases, @test_suit.id)
      flash[:success] = "Add Successful!!"
      redirect_to edit_test_suit_path(@test_suit)
    else
      flash[:danger] = "Have some wrong"
      redirect_to new_test_suit_test_case_path @test_suit, @test_case
    end
  end

  def show
  end

  def edit
    lsTestScript = []
    file_script = "test_script#{@test_suit.id}#{@test_case.id}.xml"
    doc_script = Nokogiri::XML(File.open("lib/xml/test_scripts/#{file_script}", "a+"));

    doc_script.xpath("//TestScript").each do |script|
      objScript = {}
      objScript["name"] = script.at_xpath("Name").text
      objScript["action_id"] = script.at_xpath("TestActionId").text
      objScript["param_id"] = script.at_xpath("ParamId").text
      objScript["value"] = script.at_xpath("Value").text
      objScript["text"] = script.at_xpath("Text").text

      lsTestScript << objScript
    end
    gon.test_suit_id = @test_suit.id
    gon.test_actions = @test_actions
    gon.tcId = @test_case.id
    gon.test_scripts = lsTestScript
    gon.action_have_text = @action_have_text
  end

  def update
    count = 0
    name = params[:test_case][:name]
    @test_cases.each do |tc|
      if tc.id == params[:id].to_i
        tc.name = name
        count += 1
        break
      end
    end

    if count > 0
      write_test_case_to_file_xml(@test_cases, @test_suit.id)
      flash[:success] = "Test case #{name} successfully updated"
    else
      flash[:danger] = I18n.t "flash.danger"
    end
    redirect_to edit_test_suit_test_case_path(@test_suit, @test_case)
  end

  def destroy
    if @test_cases.delete(@test_case)
      write_test_case_to_file_xml(@test_cases, @test_suit.id)
      path_file_script = "lib/xml/test_scripts/test_script#{@test_suit.id}#{@test_case.id}.xml"
      File.delete(path_file_script) if File.exist?(path_file_script)
      flash[:success] = I18n.t "Test case #{@test_case.name} successfully deleted"
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

class TestCasesController < ApplicationController
  include TestCasesHelper
  before_action :authenticate_user!
  # before_action :read_test_suites
  # before_action :find_test_suit
  # before_action :read_test_cases_of_test_suit, except: %i(index new)
  # before_action :find_test_case, only: %i(edit update destroy)
  # before_action :read_action, only: :edit
  ActionController::Parameters.permit_all_parameters = true

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
      @test_case.status = Settings.status.change
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
    @test_suit_id = params["test_suit_id"]
    @test_case_id = params["id"]
  
    @change_action = false
    @test_scripts = get_test_script(@test_suit_id, @test_case_id)
    @actions = read_action

  end

  def update
    # debugger
    # count = 0
    # test_case = TestCase.new
    # name = params[:test_case][:name]
    # @test_cases.each do |tc|
    #   if tc.id == params[:id].to_i
    #     tc.name = name
    #     test_case = tc
    #     count += 1
    #     break
    #   end
    # end
    # debugger
    # if count > 0
    #   write_test_case_to_file_xml(test_case, @test_suit.id)
    #   flash[:success] = "Test case #{name} successfully updated"
    # else
    #   flash[:danger] = I18n.t "flash.danger"
    # end
    # redirect_to edit_test_suit_test_case_path(@test_suit, @test_case)
  end

  def destroy
    test_case_file = "#{Settings.dir_store_data}/user#{current_user.id}/test_suites/test_suit#{@test_suit.id}/test_case#{params['id']}.xml"
    if File.exist? test_case_file
      FileUtils.rm_rf test_case_file
      flash[:success] = "Test case #{@test_case.name} successfully deleted"
    else
      flash[:danger] = I18n.t "flash.danger"
    end
    redirect_to edit_test_suit_path(@test_suit)
  end

  def render_row_step
    @actions_select = params.to_h["action_select"]
    @id_row_step = params.to_h["id_row_step"]
    @new_step_script = true
    if !params.to_h["test_suit_id"].blank?
      @test_suit_id = params.to_h["test_suit_id"].to_i
      @test_case_id = params.to_h["test_case_id"].to_i
      id_row_step_split = @id_row_step.split("_")
      index_script = id_row_step_split[1].to_i
      @test_scripts = get_test_script(@test_suit_id, @test_case_id)
      @test_script = @test_scripts[index_script]
      @new_step_script = false
    end
    @actions = read_action
    @change_action = true

    respond_to do |format|
      format.js
    end
  end

  def add_row_step
    @row_count = params.to_h["row_count"]
    @actions = read_action
    @add_row = true

    respond_to do |format|
      format.js
    end
  end

  private

  def get_test_script(test_suit_id, test_case_id)
    @test_scripts = []
    @test_cases = read_test_cases(test_suit_id)
    @test_case = @test_cases.select { |tc| tc["id"] == test_case_id }
    doc_script = Nokogiri::XML(File.open("#{Settings.dir_store_data}/user#{current_user.id}/test_suites/test_suit#{test_suit_id}/test_case#{test_case_id}.xml"));

    doc_script.xpath("//step").each do |script|

      obj_script = {}

      obj_script["name"] = script.at_xpath("name").text
      obj_script["action_id"] = script.at_xpath("IdAction").text
      arguments = []
      script.xpath("arguments//argument").each do |arg|
        obj_arg = {}
        obj_arg["name"] = arg.at_xpath("name").text
        obj_arg["value"] = arg.at_xpath("value").text
        arguments << obj_arg
      end
      obj_script["arguments"] = arguments
      @test_scripts << obj_script
    end
    @test_scripts
  end
  # def find_test_suit
  #   @test_suit = TestSuit.new

  #   @test_suites.each do |ts|
  #     if ts["id"] == params[:test_suit_id]
  #       # debugger
  #        @test_suit.name = ts["name"]
  #        @test_suit.id = ts["id"]
  #       # @test_suit = ts
  #     end
  #   end
  #   # debugger
  #   redirect_to root_path if @test_suit.blank?
  # end

  # def find_test_case
  #   @test_case = TestCase.new
  #   @test_cases.each do |tc|
  #     if tc["id"].to_i == params[:id].to_i
  #       @test_case = tc
  #     end
  #   end
  #   redirect_to root_path if @test_case.blank?
  # end

  # def read_test_cases_of_test_suit
  #   @test_cases = read_test_cases @test_suit.id
  # end
end

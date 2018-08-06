class TestCasesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_testsuit
  before_action :find_testcase, only: %i(edit update destroy)

  def index
  end

  def new
    @test_case = TestCase.new
  end

  def create
    @test_case = @test_suit.test_cases.build(testcase_params)
    @test_case.user = current_user
    if @test_case.save
      flash[:success] = I18n.t "flash.add-success"
      redirect_to edit_test_suit_path(@test_suit)
    else
      flash[:danger] = I18n.t "flash.danger"
      render :new
    end
  end

  def show
  end

  def edit
    lsTestAction = []
    lsTestScript = []
    @test_actions = TestAction.all
    @test_actions.each do |t|
      objTest = {}
      objTest["data"] = t
      objTest["params"] = t.params
      lsTestAction << objTest
    end

    @test_scripts = TestScript.where("test_case_id = ?", @test_case.id)
    @test_scripts.each do |s|
      objScript = {}
      objScript["data"] = s
      objScript["text_value"] = TestValue.find_by test_script_id: s.id
      lsTestScript.push(objScript)
    end
    gon.test_actions = lsTestAction
    gon.tcId = @test_case.id
    gon.test_scripts =lsTestScript
  end

  def update
    if @test_case.update testcase_params
      flash[:success] = I18n.t "flash.update-success"
    else
      flash[:danger] = I18n.t "flash.danger"
    end
    redirect_to edit_test_suit_test_case_path(@test_suit, @test_case)
  end

  def destroy
    if @test_case.destroy
      flash[:success] = I18n.t "flash.delete-success"
    else
      flash[:danger] = I18n.t "flash.danger"
    end
    redirect_to edit_test_suit_path(@test_suit)
  end

  private

  def find_testsuit
    @test_suit = TestSuit.find_by id: params[:test_suit_id]
    redirect_to root_path if @test_suit.blank?
  end

  def find_testcase
    @test_case = TestCase.find_by id: params[:id]
    redirect_to @test_suit if @test_case.blank?
  end

  def testcase_params
    params.require(:test_case).permit(:name)
  end
end

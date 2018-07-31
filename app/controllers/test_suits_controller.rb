class TestSuitsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_testsuit, only: %i(destroy edit update)
  def index
    @test_suites = TestSuit.all
  end

  def new
    @test_suit = TestSuit.new
  end

  def create
    @test_suit = TestSuit.new testsuit_params
    @test_suit.user = current_user
    if @test_suit.save
      flash[:success] = "Added TestSuit successful"
      redirect_to root_path
    else
      flash[:danger] = "Some thing wrong!!!"
      render :new
    end
  end

  def edit
  end

  def update
    if @test_suit.update testsuit_params
      flash[:success] = "Updated TestSuit Succesful!!"
      redirect_to test_suits_path
    else
      flash[:danger] = "Some thing wrong!"
      render :edit
    end
  end

  def destroy
    if @test_suit.destroy
      flash[:success] = "Deleted TestSuit Complete"
    else
      flash[:danger] = "Have a few wrong!!"
    end
    redirect_to test_suits_path
  end

  private
  def testsuit_params
    params.require(:test_suit).permit(:name)
  end

  def find_testsuit
    @test_suit = TestSuit.find_by id: params[:id]
    redirect_to root_path if @test_suit.blank?
  end
end

class TestScriptsController < ApplicationController
  before_action :authenticate_user!

  def create
    id_test_case = params["test_case_id"].to_i
    ls_test_scripts = params["lsTestScript"]

    ls_test_scripts.each do |script|
      @script = TestScript.new
      @script.test_case_id = id_test_case
      @script.test_action_id = script[1]["idTestAction"]
      @script.name = script[1]["nameTestScript"]
      @script.user_id = current_user.id
      @script.description = script[1]["description"]

      if @script.save && script[1]["value"].present?
        @test_value = TestValue.new
        @test_value.test_script_id = @script.id
        @test_value.test_action_id = @script.test_action_id
        @test_value.param_id = script[1]["param_id"]
        @test_value.value = script[1]["value"]
        @test_value.save
      end
    end

    render html: "Success"

    # listTestScript = params[]
  end
end

class TestScriptsController < ApplicationController
  before_action :authenticate_user!

  def create
    id_test_case = params["test_case_id"].to_i
    ls_test_scripts = params["lsTestScript"]
    test_suit_id = params["test_suit_id"]
    builder = Nokogiri::XML::Builder.new(encoding: "UTF-8") do |xml|
      xml.TestScripts{
        ls_test_scripts.each do |script|
          xml.TestScript{
            xml.TestActionId script[1]["idTestAction"]
            xml.TestCaseId id_test_case
            xml.ParamId script[1]["param_id"]
            xml.Name script[1]["nameTestScript"]
            xml.Value script[1]["value"]
            xml.Text script[1]["text"]
          }
        end
      }
    end
    file_name_test_script = "test_script#{test_suit_id}#{id_test_case}.xml"
    File.open("lib/xml/test_scripts/#{file_name_test_script}", "w+") do |file|
      file << builder.to_xml
    end
    # ls_test_scripts.each do |script|
    #   @script = {}
    #   @script["test_case_id"] = id_test_case
    #   @script["test_action_id"] = script[1]["idTestAction"]
    #   @script["name"] = script[1]["nameTestScript"]
    #   @script["param_id"] = script[1]["param_id"]
    #   @script["value"] = script[1]["value"]
    #   @script["text"] = script[1]["text"]
    #   # @script["description"] = script[1]["description"]

    #   if @script.save && script[1]["value"].present?
    #     @test_value = TestValue.new
    #     @test_value.test_script_id = @script.id
    #     @test_value.test_action_id = @script.test_action_id
    #     @test_value.param_id = script[1]["param_id"]
    #     @test_value.value = script[1]["value"]
    #     @test_value.save
    #   end
    # end

    render html: "Success"

    # listTestScript = params[]
  end

  def write_test_script_to_xml

  end
end

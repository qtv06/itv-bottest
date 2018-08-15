class TestScriptsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  def create
    test_case = params["test_case"]
    test_suit_id = params["test_suit_id"]
    ls_test_scripts = params["lsTestScript"]
    builder = Nokogiri::XML::Builder.new(encoding: "UTF-8") do |xml|
      xml.TestCase{
        xml.Id test_case["id"]
        xml.Name test_case["name"]
        xml.CreatedAt Time.current
        xml.steps{
        JSON.parse(ls_test_scripts).each do |script|
          items_step = script.to_a
          xml.step{
            xml.name items_step[0][1]
            xml.IdAction items_step[1][1]
            xml.arguments{
              for i in 2..items_step.length-1
                xml.argument{
                  xml.name items_step[i][0]
                  xml.value items_step[i][1]
                }
              end
            }
          }
        end
        }
      }
    end
    File.open("lib/xml/user#{current_user.id}/test_suites/test_suit#{test_suit_id}/test_case#{test_case["id"]}.xml", "w+") do |file|
      file << builder.to_xml
    end
    # builder = Nokogiri::XML::Builder.new(encoding: "UTF-8") do |xml|
    #   xml.TestScripts{
    #     ls_test_scripts.each do |script|
    #       xml.TestScript{
    #         xml.TestActionId script[1]["idTestAction"]
    #         xml.TestCaseId id_test_case
    #         xml.ParamId script[1]["param_id"]
    #         xml.Name script[1]["nameTestScript"]
    #         xml.Value script[1]["value"]
    #         xml.Text script[1]["text"]
    #       }
    #     end
    #   }
    # end
    # file_name_test_script = "test_script#{test_suit_id}#{id_test_case}.xml"
    # File.open("lib/xml/test_scripts/#{file_name_test_script}", "w+") do |file|
    #   file << builder.to_xml
    # end

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

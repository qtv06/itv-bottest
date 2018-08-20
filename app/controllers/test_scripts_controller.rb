class TestScriptsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  def create
    test_suit_id = params["test_suit_id"]
    ls_test_scripts = params["lsTestScript"]
    builder = Nokogiri::XML::Builder.new(encoding: "UTF-8") do |xml|
      xml.TestCase{
        xml.Id params['test_case_id']
        xml.Name params['test_case_name']
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
    File.open("#{Settings.dir_store_data}/user#{current_user.id}/test_suites/test_suit#{test_suit_id}/test_case#{params['test_case_id']}.xml", "w+") do |file|
      file << builder.to_xml
    end
    render html: "Test Case #{params['test_case_name']} succesfully saved!!"
  end

  def write_test_script_to_xml

  end
end

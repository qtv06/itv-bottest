class ApplicationController < ActionController::Base
  include SessionsHelper

  def authenticate_user!
    redirect_to login_path unless current_user.present?
  end

  def read_test_suites
    @test_suites = []
    @big_id = 1
    doc = Nokogiri::XML(File.open("lib/xml/test_suits/test_suits.xml"))

    doc.xpath("//TestSuit").each do |ts|
      objTestSuit = {}
      objTestSuit["id"] = ts.at_xpath("Id").text
      @big_id = @big_id > objTestSuit["id"].to_i ? @big_id : objTestSuit["id"].to_i
      objTestSuit["name"] = ts.at_xpath("Name").text
      objTestSuit["created_at"] = ts.at_xpath("CreatedAt").text

      @test_suites << objTestSuit
    end
  end

  def read_action
    @test_actions = []
    doc = Nokogiri::XML(File.open("lib/xml/actions.xml"))
    doc.xpath("//Action").each do |action|
      test_action = TestAction.new
      obj = {}
      test_action.id = action.at_xpath("Id").text
      test_action.name = action.at_xpath("Name").text
      obj["data"] = test_action
      params = []
      doc_params = Nokogiri::XML(File.open("lib/xml/params.xml"))
      doc_params.xpath("//Param").each do |param|
        actions_id = param.at_xpath("IdAction").text.split(",")
        if actions_id.include? action.at_xpath("Id").text
          obj_param = Param.new
          obj_param.id = param.at_xpath("Id").text
          obj_param.test_action_id = param.at_xpath("IdAction").text
          obj_param.name = param.at_xpath("Name").text
          obj_param.param_value = param.at_xpath("Value").text

          params << obj_param
        end
      end
      obj["params"] = params

      @test_actions << obj
    end
  end
end

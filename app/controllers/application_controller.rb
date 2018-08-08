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
end

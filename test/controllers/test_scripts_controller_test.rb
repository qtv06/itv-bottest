require 'test_helper'

class TestScriptsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get test_scripts_create_url
    assert_response :success
  end

end

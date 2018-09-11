require 'test_helper'

class LayoutsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get layouts_index_url
    assert_response :success
  end

end

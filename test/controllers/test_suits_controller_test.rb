require 'test_helper'

class TestSuitsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get test_suits_index_url
    assert_response :success
  end

  test "should get edit" do
    get test_suits_edit_url
    assert_response :success
  end

  test "should get update" do
    get test_suits_update_url
    assert_response :success
  end

  test "should get new" do
    get test_suits_new_url
    assert_response :success
  end

  test "should get create" do
    get test_suits_create_url
    assert_response :success
  end

  test "should get destroy" do
    get test_suits_destroy_url
    assert_response :success
  end

end

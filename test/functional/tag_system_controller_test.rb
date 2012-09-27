require 'test_helper'

class TagSystemControllerTest < ActionController::TestCase
  test "should get process" do
    get :process
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end

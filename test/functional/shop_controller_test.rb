require 'test_helper'

class ShopControllerTest < ActionController::TestCase
  test "should get search" do
    get :search
    assert_response :success
  end

  test "should get buy" do
    get :buy
    assert_response :success
  end

end

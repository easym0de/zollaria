require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get buy" do
    get :buy
    assert_response :success
  end

  test "should get search" do
    get :search
    assert_response :success
  end

end

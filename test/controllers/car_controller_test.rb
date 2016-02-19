require 'test_helper'

class CarControllerTest < ActionController::TestCase
  test "should get new_car" do
    get :new_car
    assert_response :success
  end

end

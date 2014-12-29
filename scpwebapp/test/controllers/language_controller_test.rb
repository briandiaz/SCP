require 'test_helper'

class LanguageControllerTest < ActionController::TestCase
  test "should get english" do
    get :english
    assert_response :success
  end

  test "should get spanish" do
    get :spanish
    assert_response :success
  end

end

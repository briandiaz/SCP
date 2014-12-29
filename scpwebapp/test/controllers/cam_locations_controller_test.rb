require 'test_helper'

class CamLocationsControllerTest < ActionController::TestCase
  setup do
    @cam_location = cam_locations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cam_locations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cam_location" do
    assert_difference('CamLocation.count') do
      post :create, cam_location: { ip_addres: @cam_location.ip_addres, location: @cam_location.location, mac_address: @cam_location.mac_address }
    end

    assert_redirected_to cam_location_path(assigns(:cam_location))
  end

  test "should show cam_location" do
    get :show, id: @cam_location
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cam_location
    assert_response :success
  end

  test "should update cam_location" do
    patch :update, id: @cam_location, cam_location: { ip_addres: @cam_location.ip_addres, location: @cam_location.location, mac_address: @cam_location.mac_address }
    assert_redirected_to cam_location_path(assigns(:cam_location))
  end

  test "should destroy cam_location" do
    assert_difference('CamLocation.count', -1) do
      delete :destroy, id: @cam_location
    end

    assert_redirected_to cam_locations_path
  end
end

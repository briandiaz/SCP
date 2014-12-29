class CamLocationsController < ApplicationController
  include ApplicationHelper
  before_action :set_cam_location, only: [:show, :edit, :update, :destroy]
  before_action :is_user_validated
  before_action :user_has_permission, only: [:edit, :update, :new]
  before_action :admin_user_permission, only: [:destroy]

  def index
    @cam_locations = CamLocation.all
  end

  def show
    @cam_location_image = search_google_image_by("security video camera")
  end

  def new
    redirect_to cam_locations_path if !admin_user
    @cam_location = CamLocation.new 
  end

  def edit
  end

  def create
    @cam_location = CamLocation.new(cam_location_params)
    create_action(@cam_location)
  end

  def update
    update_action(@cam_location,cam_location_params)
  end

  def destroy
    destroy_action(@cam_location,cam_locations_path)
  end

  private
    def set_cam_location
      @cam_location = CamLocation.find(params[:id])
    end

    def cam_location_params
      params.require(:cam_location).permit(:location, :ip_addres, :mac_address)
    end
end

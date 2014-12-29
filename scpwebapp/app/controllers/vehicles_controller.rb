class VehiclesController < ApplicationController
  include ApplicationHelper
  include VehiclesHelper
  before_action :set_vehicle, only: [:show, :edit, :update, :destroy]
  before_action :is_user_validated
  before_action :user_has_permission, only: [:edit, :update, :new]
  before_action :admin_user_permission, only: [:destroy]

  def index
    @vehicles = Vehicle.find(:all, :order => "id asc", :include => [:brand,:model,{:owner => :person}])
  end

  def show
    @vehicle_image = get_vehicle_image(@vehicle)
  end

  def new
    @vehicle = Vehicle.new
  end

  def edit
  end

  def create
    if params[:is_ajax]
      create_vehicle_ajax(params)
    else
      @vehicle = Vehicle.new(vehicle_params)
      create_action(@vehicle)
    end
  end

  def update
    update_action(@vehicle,vehicle_params)
  end

  def destroy
    destroy_action(@vehicle,vehicles_path)
  end

  private
    def set_vehicle
      @vehicle = Vehicle.find(params[:id])
    end

    def vehicle_params
      params.require(:vehicle).permit(:owner_id, :brand_id, :model_id, :year, :color, :special_signs, :plate_number)
    end
end

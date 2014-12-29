class LogsController < ApplicationController
  include ApplicationHelper
  include VehiclesHelper
  before_action :set_log, only: [:show, :update, :destroy]
  before_action :is_user_validated

  def index
    @logs = Log.find(:all, :order => "time desc", :include => [:vehicle,:cam_location])
  end

  def show
  end

  def new
    @log = Log.new
  end

  def create
    @log = Log.new(log_params)
    create_action(@log)
  end

  def update
    update_action(@log,log_params)
  end

  def destroy
    destroy_action(@log,logs_path)
  end

  private
    def set_log
      @log = Log.find(params[:id])
    end

    def log_params
      params.require(:log).permit(:time, :cam_location_id, :vehicle_id)
    end
end

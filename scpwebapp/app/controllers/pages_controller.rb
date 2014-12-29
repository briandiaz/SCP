class PagesController < ApplicationController
  include ApplicationHelper
  include PagesHelper
  include VehiclesHelper
  before_action :is_user_validated
  before_action :set_logs, only: [:home]
  before_action :set_vehicles, only: [:home]
  before_action :set_clients, only: [:home]
  before_action :set_users, only: [:home]
  before_action :set_last_log, only: [:home, :livelog]
  
  def home
    @latest_logs = Log.find(:all, :order => "id desc", :limit => 10, :include => [:vehicle,:cam_location])
    @log = Log.last
    @today = Time.now
  end
  
  def livelog
  end
  
  private
    def set_last_log
      @log = Log.last
      @vehicle_image = get_vehicle_image(@log.vehicle)
    end
    def set_logs
      @logs_data = get_object_dashboard_data(Log)
    end
    def set_vehicles
      @vehicles_data = get_object_dashboard_data(Vehicle)
    end
    def set_clients
      @clients_data = get_object_dashboard_data(Client)
    end
    def set_users
      @users_data = get_object_dashboard_data(User)
    end
end

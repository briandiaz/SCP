class ApiController < ApplicationController
  include VehiclesHelper
  include ApiHelper

  def authorize_plate
    if !params[:plate]
      render json: {message:"Plate Number param not found"}, status: :bad_request 
    elsif !params[:cam]
      render json: {message:"Cam Location ID param not found"}, status: :bad_request 
    elsif !params[:plate] && !params[:cam]
      render json: {message:"Plate Number and Cam Location ID params not found"}, status: :bad_request 
    else
      @vehicle ||= Vehicle.where(plate_number: params[:plate]).first
      @cam ||= CamLocation.where(ip_addres: params[:cam]).first()
      if @vehicle and @cam
        if @vehicle.owner_id == 15
          @visitor = Visitor.where(vehicle_id: @vehicle.id).first
          if @visitor
            if visitor_expired?(@visitor)
                render json: {message:"Visitor expired."}, status: :not_found 
            else
              @vehicle_image = get_vehicle_image(@vehicle) 
              create_log(@cam,@vehicle.id)
            end
          else
            render json: {message:"Visitor not found"}, status: :not_found 
          end
        else
          @vehicle_image = get_vehicle_image(@vehicle)
          create_log(@cam,@vehicle.id)
        end
      else
        if !@vehicle
          render json: {message:"Vehicle not found"}, status: :not_found 
        else
          render json: {message:"Cam not found"}, status: :not_found 
        end
      end
    end
  end
  
  
  def latest_logs
    @logs = Log.find(:all, :order => "id desc", :limit => 10, :include => [:vehicle,:cam_location])
  end
  private
  def visitor_expired?(visitor)
    (visitor.expiring_time < DateTime.parse(Time.now.to_s))
  end
end

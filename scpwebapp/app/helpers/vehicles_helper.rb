module VehiclesHelper
  include ApplicationHelper
  include AjaxHelper
  
  def get_vehicle_image(vehicle)
    #search_google_image_by(vehicle.brand.name + " " + vehicle.model.name + " " + vehicle.year.to_s + " " + vehicle.color + " png")
    search_google_image_by(vehicle.brand.name + " " + vehicle.model.name + " " + vehicle.year.to_s + " png")
  end
  
  def create_vehicle_ajax(params)
    vehicle = Vehicle.new
    vehicle.owner_id = params[:owner_id]
    vehicle.brand_id = params[:brand_id]
    vehicle.model_id = params[:model_id]
    vehicle.year = params[:year]
    vehicle.color = params[:color]
    vehicle.special_signs = params[:special_signs]
    vehicle.plate_number = params[:plate_number]
    respond_to_json(vehicle)
  end
  
end


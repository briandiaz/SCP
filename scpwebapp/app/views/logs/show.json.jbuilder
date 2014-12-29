json.log do
  json.id @log.id
  json.cam_location @log.cam_location
  json.cam_location_photo search_google_image_by("security video camera")
  json.date @log.time.strftime("%d/%m/%Y")
  json.hour @log.time.strftime("%I:%M:%S %p")
  json.timestamp @log.time.strftime("%d/%m/%Y %I:%M:%S.%L %p")
end
json.vehicle do
  json.id @log.vehicle.id
  json.brand @log.vehicle.brand
  json.model @log.vehicle.model
  json.year @log.vehicle.year
  json.color @log.vehicle.color
  json.special_signs @log.vehicle.special_signs
  json.plate_number @log.vehicle.plate_number
  json.owner do
    json.client do
      json.id @log.vehicle.owner.person.client.id
    end
    json.person @log.vehicle.owner.person
  end
  json.photo get_vehicle_image(@log.vehicle)
end
json.vehicle_logs Log.where(vehicle_id: @log.vehicle.id).count
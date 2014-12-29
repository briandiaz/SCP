json.array!(@logs) do |log|
  json.log do
    json.id log.id
    json.owner "#{log.vehicle.owner.person.first_name} #{log.vehicle.owner.person.last_name}"
    json.vehicle "#{log.vehicle.brand.name} - #{log.vehicle.model.name} #{log.vehicle.year}"
    json.plate log.vehicle.plate_number
    json.cam_location log.cam_location.location if log.cam_location
    json.date log.time.strftime("%d/%m/%Y")
    json.hour log.time.strftime("%I:%M:%S %p")
  end
end

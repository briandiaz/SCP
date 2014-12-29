json.array!(@vehicles) do |vehicle|
  json.extract! vehicle, :id, :owner, :brand, :model, :year, :color, :special_signs, :plate_number
  json.url vehicle_url(vehicle, format: :json)
end

json.array!(@cam_locations) do |cam_location|
  json.extract! cam_location, :id, :location, :ip_addres, :mac_address
  json.url cam_location_url(cam_location, format: :json)
end

json.array!(@logs) do |log|
  json.extract! log, :id, :time, :cam_location_id, :vehicle_id
  json.url log_url(log, format: :json)
end

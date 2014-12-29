json.array!(@visitors) do |visitor|
  json.extract! visitor, :id, :person_id, :vehicle_id, :expiring_time, :notes
  json.url visitor_url(visitor, format: :json)
end

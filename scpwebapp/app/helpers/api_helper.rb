module ApiHelper
  def create_log(cam_location,vehicle_id)
    now = Time.now
    log = Log.new
    log.time = now
    log.cam_location_id = cam_location.id
    log.vehicle_id = vehicle_id
    log.created_at = now
    log.save
  end
end

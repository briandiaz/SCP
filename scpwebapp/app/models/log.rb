class Log < ActiveRecord::Base
  belongs_to :cam_location
  belongs_to :vehicle
  
  def self.most_recent
    order("created_at desc").limit(10)
  end
  
end

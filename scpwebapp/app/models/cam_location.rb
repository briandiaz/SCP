class CamLocation < ActiveRecord::Base
  
  validates :location, presence: true
  validates :ip_addres, presence: true
  validates :mac_address, presence: true
end

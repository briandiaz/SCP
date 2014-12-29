class Visitor < ActiveRecord::Base
  belongs_to :person
  belongs_to :vehicle
  
  validates :vehicle_id, presence: true, numericality: true, :uniqueness => true
  validates :person_id, presence: true, numericality: true
  validates :expiring_time, presence: true
  
end

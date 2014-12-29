class Role < ActiveRecord::Base
  has_one :user
  
  validates :name, presence: true
  validates :value, presence: true, numericality: true
end

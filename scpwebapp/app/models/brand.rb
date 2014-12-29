class Brand < ActiveRecord::Base
  has_many :models
  
  validates :name, presence: true
end

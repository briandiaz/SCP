class Model < ActiveRecord::Base
  belongs_to :brand
  
  validates :name, presence: true, uniqueness: true
  validates :brand_id, presence: true, numericality: true
end

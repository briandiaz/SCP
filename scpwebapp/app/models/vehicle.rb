class Vehicle < ActiveRecord::Base
  belongs_to :brand
  belongs_to :model
  belongs_to :owner, :class_name => Client

  validates :owner_id, presence: true, numericality: true
  validates :brand_id, presence: true, numericality: true
  validates :model_id, presence: true, numericality: true
  validates :year, presence: true, numericality: true
  validates :color, presence: true
  validates :plate_number, presence: true, uniqueness: true
end
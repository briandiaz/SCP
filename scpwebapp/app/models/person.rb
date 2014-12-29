class Person < ActiveRecord::Base
  has_one :client
  has_one :user
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true
  validates :email, presence: true, uniqueness: true
  validates :sex, presence: true
  validates :identification_card, presence: true, uniqueness: true

  mount_uploader :photo, ImageUploader
  
end

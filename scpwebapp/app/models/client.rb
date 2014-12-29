class Client < ActiveRecord::Base
  belongs_to :person
  has_many :owners, :class_name => Vehicle, :foreign_key => :owner_id
  
  validates :person_id, presence: true, numericality: true
end

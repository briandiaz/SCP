json.vehicle do
  json.id @vehicle.id
  json.brand do
    json.id @vehicle.brand.id
    json.name @vehicle.brand.name
  end
  json.model do
    json.id @vehicle.model.id
    json.name @vehicle.model.name
  end
  json.year @vehicle.year
  json.color @vehicle.color
  json.special_signs  @vehicle.special_signs
  json.plate_number @vehicle.plate_number
  json.owner do
    json.client do
      json.id @vehicle.owner.person.client.id
    end
    json.person do 
      if @visitor
        json.id @visitor.person.id
        json.first_name @visitor.person.first_name
        json.last_name @visitor.person.last_name
        json.sex  @visitor.person.sex
        json.email @visitor.person.email
        json.phone @visitor.person.phone
        json.mobile @visitor.person.mobile
        json.identification_card @visitor.person.identification_card
        json.photo @visitor.person.photo
        json.expiring_time @visitor.expiring_time
        json.notes @visitor.notes
      else
        json.id @vehicle.owner.person.id
        json.first_name @vehicle.owner.person.first_name
        json.last_name @vehicle.owner.person.last_name
        json.sex  @vehicle.owner.person.sex
        json.email @vehicle.owner.person.email
        json.phone @vehicle.owner.person.phone
        json.mobile @vehicle.owner.person.mobile
        json.identification_card @vehicle.owner.person.identification_card
        json.photo @vehicle.owner.person.photo
      end
    end
  end
  json.photo @vehicle_image
  json.cam @cam
end
json.message "Vehicle Found"
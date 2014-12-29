class CreateCamLocations < ActiveRecord::Migration
  def change
    create_table :cam_locations do |t|
      t.string :location
      t.string :ip_addres
      t.string :mac_address

      t.timestamps
    end
  end
end

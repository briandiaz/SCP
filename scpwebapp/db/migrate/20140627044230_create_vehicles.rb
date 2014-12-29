class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.belongs_to :brand, index: true
      t.belongs_to :model, index: true
      t.integer :year
      t.integer :owner
      t.string :color
      t.text :special_signs
      t.string :plate_number

      t.timestamps
    end
  end
end

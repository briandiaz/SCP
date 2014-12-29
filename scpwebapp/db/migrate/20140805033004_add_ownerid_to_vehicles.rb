class AddOwneridToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :owner_id, :integer
  end
end

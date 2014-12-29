class RemoveOwnerFromVehicles < ActiveRecord::Migration
  def change
    remove_column :vehicles, :owner, :integer
  end
end

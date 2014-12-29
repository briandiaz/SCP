class AddExpiringTimeToVisitors < ActiveRecord::Migration
  def change
    add_column :visitors, :expiringtime, :datetime
  end
end

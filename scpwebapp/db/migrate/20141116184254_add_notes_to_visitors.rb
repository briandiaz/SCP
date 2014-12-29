class AddNotesToVisitors < ActiveRecord::Migration
  def change
    add_column :visitors, :notes, :string
  end
end

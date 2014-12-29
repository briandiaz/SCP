class CreateVisitors < ActiveRecord::Migration
  def change
    create_table :visitors do |t|
      t.belongs_to :person, index: true
      t.belongs_to :vehicle, index: true
      t.string :notes
      t.datetime :expiring_time

      t.timestamps
    end
  end
end

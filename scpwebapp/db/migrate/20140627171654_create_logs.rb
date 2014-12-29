class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.datetime :time
      t.belongs_to :cam_location, index: true
      t.belongs_to :vehicle, index: true

      t.timestamps
    end
  end
end

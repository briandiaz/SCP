class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.belongs_to :person, index: true

      t.timestamps
    end
  end
end

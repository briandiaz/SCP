class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.belongs_to :person, index: true
      t.belongs_to :role, index: true
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end

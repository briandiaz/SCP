class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :username
      t.string :password_digest

      t.timestamps
    end
  end
end

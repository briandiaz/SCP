class DropVisitorsTable < ActiveRecord::Migration
  def up
    drop_table :visitors
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

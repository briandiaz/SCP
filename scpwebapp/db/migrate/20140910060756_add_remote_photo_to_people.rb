class AddRemotePhotoToPeople < ActiveRecord::Migration
  def change
    add_column :people, :remote_photo, :string
  end
end

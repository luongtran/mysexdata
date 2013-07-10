class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :user_id
      t.integer :photo_id
      t.string :photo_url
      t.boolean :profile_photo

      t.timestamps
    end
    
    add_index :photos, [:user_id, :photo_id]
  end
end

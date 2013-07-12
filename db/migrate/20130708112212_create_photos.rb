class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos, :primary_key => :photo_id do |t|
      t.string :photo_url

      t.timestamps
    end

    create_table :user_photos, :id => false do |t|
      t.belongs_to :user
      t.belongs_to :photo
    end
  end
end

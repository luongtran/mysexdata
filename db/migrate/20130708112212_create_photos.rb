class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :url

      t.timestamps
    end

    #create_table :user_photos, :id => false do |t|
    # t.belongs_to :user
    #  t.belongs_to :photo
    #end
  end
end

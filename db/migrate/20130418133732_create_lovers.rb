class CreateLovers < ActiveRecord::Migration
  def change
    create_table :lovers, :primary_key => :lover_id do |t|
      t.string :facebook_id
      t.string :name
      t.string :photo_url
      t.integer :age
      t.integer :sex_gender
      t.integer :job
      t.integer :height
      t.integer :visibility, default:0
      t.boolean :pending, default:false
      t.integer :experience_id

      t.timestamps
    end

    create_table :lovers_users, :id => false do |t|
      t.belongs_to :user
      t.belongs_to :lover
    end
  end
end

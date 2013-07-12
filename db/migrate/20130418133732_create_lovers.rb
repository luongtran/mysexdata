class CreateLovers < ActiveRecord::Migration
  def change
    create_table :lovers do |t|
      t.integer :user_id
      t.integer :lover_id
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
    add_index :lovers, [:user_id, :lover_id]
  end
end

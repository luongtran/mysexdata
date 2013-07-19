class CreateLovers < ActiveRecord::Migration
  def change
    create_table :lovers, :primary_key => :lover_id do |t|
      t.string :facebook_id
      t.string :name
      t.string :photo_url
      t.integer :age, default: -1
      t.integer :sex_gender, default:-1
      t.integer :job, default: -1
      t.integer :height, default: -1
      t.timestamps
    end

    create_table :user_lovers do |t|
      t.integer :user_id
      t.integer :lover_id
      t.integer :visibility, default:0
      t.boolean :pending, default:false
    end
    add_index :user_lovers, [:user_id, :lover_id], :unique => true

  end
end

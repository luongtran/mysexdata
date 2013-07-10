class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :facebook_id
      t.string :remember_token
      t.string :password_digest
      t.string :password
      t.string :main_photo_url
      t.integer :photo_num
      t.integer :job
      t.datetime :birthday
      t.datetime :startday
      t.integer :eye_color
      t.integer :hair_color
      t.integer :height
      t.integer :hairdressing
      t.integer :sex_interest
      t.integer :sex_gender
      t.integer :preferences, :array => true, :length => 6
      t.boolean :admin, default: false

      t.timestamps

    end

    add_index :users, :email, unique: true
    add_index :users, :facebook_id, unique: true
    add_index :users, :remember_token
  end
end

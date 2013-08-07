class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, primary_key: :user_id do |t|
      t.string :name
      t.string :email
      t.string :facebook_id
      t.string :remember_token
      t.string :password
      t.integer :status
      t.string :main_photo_url
      t.integer :photo_num
      t.integer :lovers_num, default: 0
      t.integer :job
      t.integer :age
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
  end
end

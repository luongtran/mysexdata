class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, primary_key: :user_id do |t|
      t.string :name
      t.string :email
      t.string :facebook_id
      t.string :remember_token
      t.string :password_digest
      t.integer :status, default: -1
      t.string :facebook_photo
      t.integer :profile_photo, default: -1
      t.integer :photo_num, default: 1
      t.integer :lovers_num, default: 0
      t.integer :job, default: -1
      t.integer :age, default: -1
      t.datetime :birthday
      t.datetime :startday
      t.integer :eye_color, default: -1
      t.integer :hair_color, default: -1
      t.integer :height, default: -1
      t.integer :hairdressing, default: -1
      t.integer :sex_interest, default: -1
      t.integer :sex_gender, default: -1
      t.integer :preferences, :array => true, :length => 6
      t.boolean :admin, default: false
      t.integer :premium, default: -1

      t.timestamps

    end
  end
end

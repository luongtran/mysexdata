class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, primary_key: :user_id do |t|
      t.string :name
      t.string :email
      t.string :facebook_id
      t.string :remember_token
      t.string :password_digest
      t.integer :status, default: 0
      t.string :main_photo_url
      t.integer :photo_num, default: 1
      t.integer :lovers_num, default: 0
      t.integer :job, default: 0
      t.integer :age, default: 0
      t.datetime :birthday
      t.datetime :startday
      t.integer :eye_color, default: 0
      t.integer :hair_color, default: 0
      t.integer :height, default: 0
      t.integer :hairdressing, default: 0
      t.integer :sex_interest, default: 0
      t.integer :sex_gender, default: 0
      t.integer :preferences, :array => true, :length => 6
      t.boolean :admin, default: false

      t.timestamps

    end
  end
end

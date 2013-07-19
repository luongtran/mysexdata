class CreateGeosexes < ActiveRecord::Migration
  def change
    create_table :geosexes, primary_key: :user_id do |t|
      t.integer :access, default: 0
      t.integer :status, default: 0
      t.float :lat, precision: 9, scale: 3
      t.float :lng, precision: 9, scale: 3
      t.string :address

      t.timestamps
    end
    add_index :geosexes, :user_id
  end
end

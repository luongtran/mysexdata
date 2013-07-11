class CreateGeosexes < ActiveRecord::Migration
  def change
    create_table :geosexes do |t|
      t.integer :user_id
      t.integer :access, default: 0
      t.integer :status, default: 0
      t.decimal :lat, precision: 3, scale:2
      t.decimal :lng, precision: 3, scale: 2

      t.timestamps
    end
    add_index :geosexes, :user_id
    add_index :geosexes, :status
  end
end

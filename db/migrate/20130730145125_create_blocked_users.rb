class CreateBlockedUsers < ActiveRecord::Migration
  def change
    create_table :blocked_users do |t|
      t.integer :user_id
      t.integer :blocked_user_id
      t.boolean :blocked
      t.string :description


      t.timestamps
    end
        add_index :blocked_users, ["user_id", "blocked_user_id"], :unique => true

  end
end

class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :user_id
      t.integer :friend_id
      t.boolean :accepted, default: false
      t.boolean :pending, default: false
      t.boolean :secret_lover_ask, default: false
      t.boolean :secret_lover_accepted, default: false
      t.boolean :banned, default: false, null: false

      t.timestamps
    end

    add_index :friendships, ["user_id", "friend_id"], :unique => true
  end
end

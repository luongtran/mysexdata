class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships, :id => false do |t|
      t.integer :user_id
      t.integer :friend_id
      t.boolean :accepted, default: false
      t.boolean :pending, default: false
      t.boolean :secret_lover_ask, default: false
      t.boolean :secret_lover_accepted, default: false
      t.string :email

      t.timestamps
    end
  end
end

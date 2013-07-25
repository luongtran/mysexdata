class CreateExternalInvitations < ActiveRecord::Migration
  def change
    create_table :external_invitations do |t|
      t.integer :sender_id
      t.string :receiver
      t.string :facebook_id
      t.string :name
      t.string :photo_url

      t.timestamps
    end
    add_index :external_invitations, [:sender_id, :facebook_id], :unique => true
  end
end

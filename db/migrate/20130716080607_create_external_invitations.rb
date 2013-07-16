class CreateExternalInvitations < ActiveRecord::Migration
  def change
    create_table :external_invitations do |t|
      t.integer :sender_id
      t.string :receiver
      t.datetime :date

      t.timestamps
    end    
    add_index :external_invitations, [:sender_id, :receiver], :unique => true
  end
end

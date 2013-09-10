class AddUnReadToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :unread, :boolean,  :null => false, :default => true
  end
end

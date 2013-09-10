class ReAddDisableToUsers < ActiveRecord::Migration
  def change
    add_column :users, :disable, :boolean, :null => false, :default => false
  end
end

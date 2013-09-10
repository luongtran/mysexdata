class AddUserAccountToLover < ActiveRecord::Migration
  def change
    add_column :lovers, :account_user, :integer
  end
end

class AddIndexToGroupUsers < ActiveRecord::Migration
  def change
    add_index :group_users, :user_id
    add_index :group_users, :group_id
  end
end

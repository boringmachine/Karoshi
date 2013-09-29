class RemoveUserFromGroups < ActiveRecord::Migration
  def up
    remove_column :groups, :user_id
  end

end

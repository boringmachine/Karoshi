class AddIndexToCommunityUsers < ActiveRecord::Migration
  def change
    add_index :community_users, :user_id
    add_index :community_users, :community_id
  end
end

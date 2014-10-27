class AddCommunityIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :community_id, :integer
    add_index :posts, :community_id
  end
end

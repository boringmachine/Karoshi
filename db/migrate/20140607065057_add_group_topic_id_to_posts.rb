class AddCommunityTopicIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :community_topic_id, :integer
  end
end

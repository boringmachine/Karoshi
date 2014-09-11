class AddIndexToCommunityTopics < ActiveRecord::Migration
  def change
    add_index :community_topics, :topic_id
    add_index :community_topics, :community_id
  end
end

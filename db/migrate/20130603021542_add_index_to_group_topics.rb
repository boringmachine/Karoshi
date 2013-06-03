class AddIndexToGroupTopics < ActiveRecord::Migration
  def change
    add_index :group_topics, :topic_id
    add_index :group_topics, :group_id
  end
end

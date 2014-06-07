class AddGroupTopicIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :group_topic_id, :integer
  end
end

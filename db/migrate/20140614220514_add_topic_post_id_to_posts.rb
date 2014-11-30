class AddTopicPostIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :topic_post_id, :integer
  end
end

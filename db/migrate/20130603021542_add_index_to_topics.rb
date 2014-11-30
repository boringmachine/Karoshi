class AddIndexToTopics < ActiveRecord::Migration
  def change
    add_index :topics, :community_id
  end
end

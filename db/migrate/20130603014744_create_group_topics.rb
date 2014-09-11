class CreateCommunityTopics < ActiveRecord::Migration
  def change
    create_table :community_topics do |t|
      t.integer :community_id
      t.integer :topic_id

      t.timestamps
    end
  end
end

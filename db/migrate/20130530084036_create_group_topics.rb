class CreateGroupTopics < ActiveRecord::Migration
  def change
    create_table :group_topics do |t|
      t.integer :topic_id
      t.integer :group_id
      t.string :name

      t.timestamps
    end
  end
end

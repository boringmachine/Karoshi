class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :community_user_id

      t.timestamps
    end
  end
end

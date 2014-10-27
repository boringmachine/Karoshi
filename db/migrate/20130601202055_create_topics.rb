class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :subject
      t.integer :community_id
      t.timestamps
    end
  end
end

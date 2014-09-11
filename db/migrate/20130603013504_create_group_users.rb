class CreateCommunityUsers < ActiveRecord::Migration
  def change
    create_table :community_users do |t|
      t.integer :community_id
      t.integer :user_id
      t.boolean :status

      t.timestamps
    end
  end
end

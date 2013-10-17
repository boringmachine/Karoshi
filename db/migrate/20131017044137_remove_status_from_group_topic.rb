class RemoveStatusFromGroupTopic < ActiveRecord::Migration
  def up
    remove_column :group_topics, :status
  end

  def down
    add_column :group_topics, :status, :string
  end
end

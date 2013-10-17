class AddStatusToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :status, :boolean
  end
end

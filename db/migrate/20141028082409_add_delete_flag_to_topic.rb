class AddDeleteFlagToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :deleteflag, :boolean
  end
end

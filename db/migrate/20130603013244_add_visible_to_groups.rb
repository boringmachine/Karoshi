class AddVisibleToCommunities < ActiveRecord::Migration
  def change
    add_column :communities, :visible, :boolean
  end
end

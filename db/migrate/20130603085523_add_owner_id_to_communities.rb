class AddOwnerIdToCommunities < ActiveRecord::Migration
  def change
    add_column :communities, :owner_id, :integer
  end
end

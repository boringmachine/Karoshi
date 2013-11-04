class RemoveParentFromPosts < ActiveRecord::Migration
  def up
    remove_column :posts, :parent_id
  end

  def down
    add_column :posts, :parent_id, :string
  end
end

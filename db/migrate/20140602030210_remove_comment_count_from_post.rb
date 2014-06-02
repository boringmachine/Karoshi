class RemoveCommentCountFromPost < ActiveRecord::Migration
  def up
    remove_column :posts, :field_name
  end

  def down
    add_column :posts, :field_name, :comment_count
  end
end

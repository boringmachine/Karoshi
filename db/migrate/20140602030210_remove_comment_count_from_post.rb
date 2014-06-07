class RemoveCommentCountFromPost < ActiveRecord::Migration
  def up
    remove_column :posts, :comment_count
  end

  def down
    add_column :posts, :comment_count, :integer
end

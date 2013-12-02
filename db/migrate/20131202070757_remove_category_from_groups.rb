class RemoveCategoryFromGroups < ActiveRecord::Migration
  def up
    remove_column :groups, :category
  end

  def down
    add_column :groups, :category, :integer
  end
end

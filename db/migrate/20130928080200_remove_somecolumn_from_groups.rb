class RemoveSomecolumnFromGroups < ActiveRecord::Migration
  def up
    remove_column :groups, :url
    remove_column :groups, :tel
    remove_column :groups, :address
    remove_column :groups, :geo
    remove_column :groups, :description
  end

  def down
    add_column :groups, :description, :string
    add_column :groups, :geo, :string
    add_column :groups, :address, :string
    add_column :groups, :tel, :string
    add_column :groups, :url, :string
  end
end

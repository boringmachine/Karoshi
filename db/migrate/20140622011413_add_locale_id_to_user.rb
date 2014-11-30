class AddLocaleIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :locale_id, :integer
  end
end

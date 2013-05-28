class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :category_id
      t.string :name
      t.boolean :visible
      t.string :url
      t.string :email
      t.string :description

      t.timestamps
    end
    add_index :groups, :category_id;
  end
end

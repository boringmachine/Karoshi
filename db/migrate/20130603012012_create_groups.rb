class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :url
      t.string :address
      t.string :tel
      t.string :geo
      t.string :description

      t.timestamps
    end
  end
end

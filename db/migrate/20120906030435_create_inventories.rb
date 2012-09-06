class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.integer :id
      t.text :asin

      t.timestamps
    end
  end
end

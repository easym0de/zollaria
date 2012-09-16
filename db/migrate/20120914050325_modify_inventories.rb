class ModifyInventories < ActiveRecord::Migration
  def up
    
    add_column :inventories, :product_id, :int
    add_column :inventories, :user_id, :int
  end

  def down
    remove_column :inventories, :product_id
    remove_column :inventories, :user_id
  end
end

class AddToLikes < ActiveRecord::Migration
  def up
    add_column :likes, :active, :boolean, :default => false
  end

  def down
  end
end

class AdjustUsers < ActiveRecord::Migration
  def up
    remove_column :users, :books
    remove_column :users, :movies
    remove_column :users, :gadgets
    remove_column :users, :balance
    add_column :users, :inventory_id, :integer
    add_column :users, :account_id, :integer
  end

  def down
    add_column :users, :books, :text
    add_column :users, :movies, :text
    add_column :users, :gadgets, :text
    add_column :users, :balance, :decimal
    remove_column :users, :inventory_id
    remove_column :users, :account_id
  end
end

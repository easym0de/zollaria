class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :balance, :decimal

    add_column :users, :books, :text

    add_column :users, :movies, :text

    add_column :users, :gadgets, :text

  end
end

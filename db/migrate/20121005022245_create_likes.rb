class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :inventory_id
      t.integer :user_id
      t.boolean :unliked, :default => false

      t.timestamps
    end
  end
end

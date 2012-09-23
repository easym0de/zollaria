class REmoveColumnFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :account_id
  end

  def down
  end
end

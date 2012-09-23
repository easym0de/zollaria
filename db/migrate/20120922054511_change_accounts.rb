class ChangeAccounts < ActiveRecord::Migration
  def up
    change_column_default(:accounts, :balance, 500.00)
  end

  def down
  end
end

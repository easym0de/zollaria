class ModifyContacts < ActiveRecord::Migration
  def up
    rename_column :accounts, :balance, :balance_string
    add_column :accounts, :balance, :decimal, :precision => 8, :scale => 2
    
    Account.reset_column_information
    Account.find_each { |a| a.update_attribute(:balance, a.balance_string) }
    remove_column :accounts, :balance_string
  end

  def down
  end
end

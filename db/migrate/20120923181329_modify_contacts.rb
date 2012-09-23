class ModifyContacts < ActiveRecord::Migration
  def up
    rename_column :contacts, :balance, :balance_string
    add_column :contacts, :balance, :decimal, :precision => 8, :scale => 2
    
    Account.reset_column_information
    Account.find_each { |a| a.update_attribute(:balance, a.balance_string) }
    remove_column :contacts, :balace_string
  end

  def down
  end
end

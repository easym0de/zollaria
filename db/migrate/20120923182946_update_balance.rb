class UpdateBalance < ActiveRecord::Migration
  def up
    Account.reset_column_information
    Account.find_each { |a| a.update_attribute(:balance, 500.00) }
  end

  def down
  end
end

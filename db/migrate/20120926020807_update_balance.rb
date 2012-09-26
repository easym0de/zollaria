class UpdateBalance < ActiveRecord::Migration
  def up
    Account.reset_column_information
    Account.find_each do |a|
      if a.balance.blank?
        a.balance = 500.00
      end
    end
  end

  def down
  end
end

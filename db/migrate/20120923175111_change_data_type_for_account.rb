class ChangeDataTypeForAccount < ActiveRecord::Migration
  def up
    change_table :accounts do |t|
      t.change :balance, :decimal, :precision => 8, :scale => 2
    end
  end

  def down
  end
end

class AddColumnToProducts < ActiveRecord::Migration
  def change
    add_column :products, :asin, :string
  end
end

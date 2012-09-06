class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :id
      t.string :title
      t.string :category
      t.text :detail_page_url
      t.string :small_image
      t.string :medium_image
      t.string :large_image
      t.decimal :price

      t.timestamps
    end
  end
end

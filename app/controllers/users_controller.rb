class UsersController < ApplicationController
  def home
    unless current_user.blank?
      @items = current_user.get_inventory
    end
  end

  def buy
    @title = params[:title]
    product = Product.update_or_create(params)
    inventory_item = Inventory.find_or_create_by_user_id_and_product_id(current_user.id, product.id)
  end

  def search
  end
  
end

class UsersController < ApplicationController
  def home
    puts "UsersController#home"
    unless current_user.blank?
      @items = current_user.get_inventory
    end
  end

  def buy
    @title = params[:title]
    product = Product.update_or_create(params)
    
    is_duplicate = Inventory.check_for_duplicate_or_create(current_user.id, product.id)
    
    if is_duplicate == true
      render :action => "duplicate"
    else
      current_user.buy(params[:price])    
    end
  end

  def search
    puts "UsersController#search"
    @search_result = User.search(params)
  end
  
  def duplicate
    
  end
  
end

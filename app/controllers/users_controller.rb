class UsersController < ApplicationController
  def home
    puts "UsersController#home"
    unless profile_user.blank?
      @items = profile_user.get_inventory
    end
  end
  
  def home_ajax
    unless profile_user.blank?
      @items = profile_user.get_inventory
    end
    respond_to do |format|
      format.js {render :partial => 'home'}
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
  
  def like
    like = Like.update_or_create(profile_user.id, params[:inventory_id])
    
    unless like.unliked
      # TO DO: send notification
    end
    
    @item = Inventory.get_inventory_item(params[:inventory_id], profile_user.id)
    #item = Inventory.check_for_duplicate_or_create(current_user.id, product.id)
    #params_ajax = params
    #debugger
    #params_jax2 = params[:a]
    #puts "UsersController#like"
    respond_to do |format|
      format.js {render :partial => 'like'}
    end
  end
  
  def unlike
    like = Like.unlike(profile_user.id, params[:inventory_id])
    
    @item = Inventory.get_inventory_item(params[:inventory_id], profile_user.id)

    respond_to do |format|
      format.js {render :partial => 'like'}
    end
  end

  def search
    puts "UsersController#search"
    @search_result = User.search(params)
  end
  
  def duplicate
    
  end
  
end

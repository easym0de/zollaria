class UsersController < ApplicationController
  def home
    puts "UsersController#home"
    unless profile_user.blank?
      @items = profile_user.get_inventory(current_user)
    end
  end
  
  def home_ajax
    unless profile_user.blank?
      @items = profile_user.get_inventory(current_user)
    end
    respond_to do |format|
      format.js {render :partial => 'home'}
    end
  end
  
  def view_friend_profile
    user = User.find_by_uid(params[:uid])
    unless user.blank?
      profile_user = user
    end
    @items = profile_user.get_inventory(current_user)
    respond_to do |format|
      format.js {render :partial => 'home'}
    end
  end
  
  def friends_main
    @graph = Koala::Facebook::API.new(facebook_auth)
  
    fql_friends_on_zollaria = 'select uid, name, pic_small from user where has_added_app=1 and uid in(select uid2 FROM friend where uid1 = me())'
    @friends_on_zollaria =  @graph.fql_query(fql_friends_on_zollaria)
  
    @friends_on_zollaria.each do |friend|
      user = User.find_by_uid(friend["uid"].to_s)  
      unless user.blank?
        friend["item_count"] = user.products.size
      end
    end

    respond_to do |format|
      format.js {render :partial => 'friends_home'}
    end
  end
  
  def shop
    respond_to do |format|
      format.js {render :partial => 'shop'}
    end
  end

  def buy_check
    @title = params[:title]
    @params = params
    product = Product.update_or_create(params)
    
    is_duplicate = Inventory.check_for_duplicate(current_user.id, product.id)
    @params[:balance_after_purchase] = current_user.calculate_balance_after_purchase(params[:price])
   
    @params[:action] = 'buy_confirm'

    if is_duplicate == true
      @params[:action] = 'duplicate'
    end
    
    if @params[:balance_after_purchase] < 0
      @params[:action] = 'insufficient_balance'
    end 
  end
  
  def buy_confirm
    @params = params
    product = Product.update_or_create(params)
    Inventory.check_for_duplicate_or_create(current_user.id, product.id)
    current_user.buy(params[:price])
  end
  
  def like
    like = Like.update_or_create(current_user.id, params[:inventory_id])
    
    unless like.unliked
      # TO DO: send notification
    end
    
    @item = Inventory.get_inventory_item(params[:inventory_id], current_user.id)

    respond_to do |format|
      format.js {render :partial => 'like'}
    end
  end
  
  def unlike
    like = Like.unlike(current_user.id, params[:inventory_id])
    
    @item = Inventory.get_inventory_item(params[:inventory_id], current_user.id)

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

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def current_inventory
    @current_inventory ||= Inventory.find(session[:inventory_id]) if session[:inventory_id]
  end
  
  def current_account
    @current_account ||= Account.find(session[:account_id]) if session[:account_id]
  end
  
  helper_method :current_user
  helper_method :current_inventory
  helper_method :current_account
end

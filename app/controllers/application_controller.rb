class ApplicationController < ActionController::Base
  protect_from_forgery
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  def current_inventory
    @current_inventory ||= Inventory.find(session[:inventory_id]) if session[:inventory_id]
  end
  helper_method :current_user
  helper_method :current_inventory
end

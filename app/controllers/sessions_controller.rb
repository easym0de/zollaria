class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    
    if user.inventory_id.blank?
      inventory = Inventory.create(:asin => '')
      user.inventory_id = inventory.id
      user.save
    else
      inventory = Inventory.find(user.inventory_id)
    end
    
    if user.account_id.blank?
      account = Account.create(:balance => 1000)
      user.account_id = account.id
      user.save
    else
      account = Account.find(user.account_id)
    end
    
    session[:user_id] = user.id
    session[:inventory_id] = user.inventory_id
    session[:account_id] = user.account_id
    
    if request.referer.blank?
      redirect_to Settings.app.auth_redirect_url
    else
      if request.referer.include? 'apps.facebook.com'
        redirect_to Settings.app.auth_redirect_url_in_app
      else
        redirect_to Settings.app.auth_redirect_url
      end
    end
    
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    
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
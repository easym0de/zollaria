class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    omniauth = env["omniauth.auth"]
    session[:user_id] = user.id
    session[:profile_user_id] = user.id
    session[:inventory_id] = user.inventory_id
    session[:facebook_auth] = omniauth['credentials']['token']
    
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
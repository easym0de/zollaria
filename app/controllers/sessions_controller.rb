class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    #redirect_to root_url
    #redirect_to 'http://apps.facebook.com/zollaria-dev/'
    redirect_to '/canvas'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
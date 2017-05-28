class SessionsController < ApplicationController
 
  def omnicreate
    if auth
      @user = User.find_or_create_by_omniauth(auth)
      session[:user_id] = @user.try(:id)
    end
    redirect_to root_path
  end
 
  def auth
    request.env['omniauth.auth']
  end
end
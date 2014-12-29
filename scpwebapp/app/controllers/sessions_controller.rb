class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.from_omniauth(env["omniauth.auth"],params[:person_id])
    #session[:user_id] = user.id
    if params[:register]
      respond_to do |format|
          format.json { render :json => user}
      end
    else
      myidentity = Identity.find(user.uid)
      session[:user_id] = user.id
      cookies[:profile_pic] = { :value => user.person.photo_url(:medium).to_s, :expires => 1.year.from_now }
      cookies[:username] = { :value => myidentity.username, :expires => 1.year.from_now }
      redirect_to root_path, notice: "Sign in!"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Signed out!"
  end

  def failure
    redirect_to root_path, alert: "Authentication failed, please try again."
  end
end

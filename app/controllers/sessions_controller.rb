class SessionsController < ApplicationController
  def new
    render :new 
  end

  def create 
    email = params[:user][:email]
    password = params[:user][:password]
    user = User.find_by_credentials(email, password)
    if user 
      log_in_user(user)
      redirect_to user_url(user)
    else
      flash.now[:errors] = ["Invalid password"]
      render :new 
    end

  end

  def destroy 
    logout
    redirect_to '/' 
  end
end

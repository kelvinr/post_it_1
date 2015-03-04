class SessionsController < ApplicationController

  def new
    respond_to do |format|
      format.html{redirect_to login_path}
      format.js
    end
  end

  def create
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "You are now logged in."
      redirect_to :back
    else
      flash.now[:error] = "Username or password is incorrect, please try again."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You are now logged out."
    redirect_to root_path
  end
end

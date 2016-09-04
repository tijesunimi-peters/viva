class SessionsController < ApplicationController
  include Messages
  
  def new
  end

  def create
    user = User.find_by(email: login_params[:email])
    login( !user.nil? && user.authenticate(login_params[:password]),
           user
         ) && return
  end

  def logout
    session.clear
    flash[:success] = msg("Logout")[:successful]
    redirect_to root_path
  end

  private

  def login_params
    params.permit(:email, :password)
  end

  def path(path)
    return root_path if path.nil?
    path
  end

  def login(result, user)
    if result
      session[:user_id] = user.id
      flash[:success] = msg("Login")[:successful]
      redirect_to path(session[:return_route])
    else
      flash[:errors] = output_errors msg[:login_failed]
      redirect_to "/user/session/new"
    end
  end
end

class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: login_params[:email])
    if !user.nil? && user.authenticate(login_params[:password])
      session[:user_id] = user.id
      flash[:success] = msg("Login")[:successful]
      if session[:return_route]
        redirect_to session[:return_route]
      else
        redirect_to root_path
      end
    else
      flash[:errors] = output_errors msg[:login_failed]
      redirect_to "/user/session/new"
    end
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

  def output_errors(errors)
    if errors.is_a? Array
      errors.map { |item| "#{item}<br>" }.join
    else
      errors
    end
  end
end

class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: login_params[:email])
    if !user.nil? && user.authenticate(login_params[:password])
      session[:user_id] = user.id
      flash[:success] = "Login Successful"
      if session[:return_route]
        redirect_to session[:return_route]
      else
        redirect_to root_path
      end
    else
      flash[:login_errors] = output_errors "Email/Password Incorrect"
      redirect_to "/user/session/new"
    end
  end

  def logout
    session.clear
    flash[:success] = "Logout Successful"
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

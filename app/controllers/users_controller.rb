class UsersController < ApplicationController
  include Messages

  def new
    @user = User.new
  end

  def create
    @user = User.create user_params
    if @user.errors.empty?
      set_session
      redirect_to(root_path) && return
    end
    flash[:reg_errors] = output_errors @user.errors.full_messages
    redirect_to "/user/new"
  end

  private

  def user_params
    params.require(:user).permit(
      :firstname,
      :lastname,
      :email,
      :password,
      :password_confirmation
    )
  end

  def set_session
    session[:user_id] = @user.id
    flash[:success] = msg("Registration")[:successful]
  end
end

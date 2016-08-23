class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create user_params
    if @user.errors.empty?
      flash[:success] = "Registration Successful"
      redirect_to root_path
    else
      flash[:reg_errors] = @user.errors.full_messages.map do |msg|
        "<li>#{msg}</li>"
      end.join
      redirect_to "/user/new"
    end
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
end

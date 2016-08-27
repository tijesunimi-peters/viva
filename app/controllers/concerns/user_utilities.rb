module UserUtilities
  def current_user
    redirect_to new_session_path and return if session[:user_id].nil?
    @user = User.find_by id: session[:user_id]
  end
end
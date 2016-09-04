Doorkeeper.configure do
  orm :active_record

  resource_owner_authenticator do
    session[:return_route] = request.fullpath
    User.find_by_id(session[:user_id]) || redirect_to(new_session_url)
  end

  access_token_generator "Doorkeeper::JWT"
  use_refresh_token
  enable_application_owner confirmation: true
  authorization_code_expires_in 10.minutes
  access_token_expires_in 2.hours
end

Doorkeeper::JWT.configure do
  token_payload do |opts|
    user = User.find(opts[:resource_owner_id])

    {
      gen_id: Base64.encode64(rand(1000).to_s),
      user: {
        id: user.id,
        email: user.email
      }
    }
  end

  secret_key "MY-SECRET"
  encryption_method :hs256
end

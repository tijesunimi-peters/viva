class Api::V1::UsersController < Api::ApisController
  before_action :doorkeeper_authorize!

  def show
    render json: current_user.as_json
  end

  private

  def current_user
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end

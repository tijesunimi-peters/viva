class Api::V1::UsersController < Api::ApisController
  before_action :doorkeeper_authorize!

  def show
    render json: current_user
  end
end

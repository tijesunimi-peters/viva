class Api::V1::UsersController < Api::ApisController
  def show
    render json: current_user, key_transform: :underscore
  end
end

module Api
  module V1
    class UsersController < Api::ApisController
      def show
        render json: current_user
      end
    end
  end
end

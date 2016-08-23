module Api
  class ApisController < ActionController::API
    before_action :doorkeeper_authorize!

    def route_not_found
      render json: { error: "Route not found" }, status: :not_found
    end

    def doorkeeper_unauthorized_render_options(error: nil)
      { json: { error: "Token not found" } }
    end

    private

    def current_user
      User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end

    def get_bucketlist
      @bucketlist = current_user.bucketlists.find_by(id: params[:id])
    end
  end
end

module Api
  class ApisController < ApplicationController
    before_action :doorkeeper_authorize!
    include Messages

    def route_not_found
      render json: { error: msg("Route")[:not_found] }, status: :not_found
    end

    def doorkeeper_unauthorized_render_options(error: nil)
      { json: { error: msg("Token")[:required] } }
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

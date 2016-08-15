class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def no_route_found
    render json: { error: "Route does not exists" }, status: 404
  end
end

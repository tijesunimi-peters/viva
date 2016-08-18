class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def route_not_found
    render json: { error: "Route not found" }, status: 404
  end
end

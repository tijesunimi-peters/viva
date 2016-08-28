class ApplicationController < ActionController::Base
  protect_from_forgery with: :exceptions
  include Messages

  def route_not_found
    render json: { error: msg("Route")[:not_found] }, status: :not_found
  end

end

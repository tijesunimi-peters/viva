require "rails_helper"

RSpec.describe "ApplicationRequests", type: :request do
  let(:token) { double acceptable?: true, resource_owner_id: 1 }

  before do
    allow_any_instance_of(Api::ApisController).
      to receive(:doorkeeper_token).
      and_return(token)
    create :user
  end

  describe "GET /no_route" do
    it "returns a 404 error" do
      get "/random_route"
      expect(response).to have_http_status 404
      msg = JSON.parse(response.body)["error"]
      expect(msg).to eql("Route not found")
    end
  end

  describe "GET /api/v1/no_route" do
    it "returns a 404 error" do
      get "/api/v1/random_route"
      expect(response).to have_http_status 404
      msg = JSON.parse(response.body)["error"]
      expect(msg).to eql("Route not found")
    end
  end
end

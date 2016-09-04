require "rails_helper"

RSpec.describe "UsersRequests", type: :request do
  let(:token) { double acceptable?: true, resource_owner_id: 1 }

  before do
    allow_any_instance_of(Api::V1::UsersController).
      to receive(:doorkeeper_token).
      and_return(token)
    @user = create :user
  end

  describe "GET /user" do
    it "returns currently logged in user" do
      get "/api/v1/user"
      result = JSON.parse(response.body)["user"]
      expect(result["firstname"]).to eql(@user.firstname)
      expect(result["id"]).to eql(@user.id)
    end
  end
end

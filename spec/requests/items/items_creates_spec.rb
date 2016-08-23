require "rails_helper"

RSpec.describe "Items::Creates", type: :request do
  let(:token) { double acceptable?: true, resource_owner_id: 1 }

  before do
    allow_any_instance_of(Api::V1::ItemsController).
      to receive(:doorkeeper_token).
      and_return(token)
    create :user
  end

  describe "POST /bucketlists/:id/items" do
    context "when details validate" do
      it "create items" do
        create :bucketlist
        post "/api/v1/bucketlists/1/items", params: { name: "Hello" }
        expect(response).to have_http_status(201)
      end
    end

    context "when details dont validate" do
      it "does not create item" do
        create :bucketlist
        post "/api/v1/bucketlists/1/items", params: { name: "" }
        expect(response).to have_http_status(500)
      end
    end
  end
end

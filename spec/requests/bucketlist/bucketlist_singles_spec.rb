require "rails_helper"

RSpec.describe "Bucketlist::Singles", type: :request do
  let(:token) { double acceptable?: true, resource_owner_id: 1 }

  before do
    allow_any_instance_of(Api::V1::BucketlistsController).
      to receive(:doorkeeper_token).
      and_return(token)
    create :user
  end

  describe "GET /bucketlist/:id" do
    context "when bucketlist is not found" do
      it "return 404 error" do
        get "/api/v1/bucketlists/1"
        expect(response).to have_http_status 404
      end
    end

    context "when bucketlist exists" do
      before do
        @bklist = create :bucketlist
        @item1 = create :item
        @item2 = create :item, name: Faker::Name.name
      end

      it "returns bucketlist and all its items" do
        get "/api/v1/bucketlists/1"
        expect(response).to have_http_status 200
        result = JSON.parse(response.body)["bucketlist"]
        expect(result["name"]).to eql(@bklist.name)
        expect(result["items"][0]["name"]).to eql(@item1.name)
      end
    end
  end
end

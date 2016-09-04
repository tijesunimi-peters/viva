require "rails_helper"

RSpec.describe "Bucketlist::Singles", type: :request do
  include_examples "bucketlist token"

  describe "GET /bucketlist/:id" do
    context "when bucketlist is not found" do
      it "return 404 error" do
        get "/api/v1/bucketlists/1"
        expect(response).to have_http_status 404
      end
    end

    context "when bucketlist exists" do
      before do
        @bucketlist = create :bucketlist
        @item1 = create :item
        @item2 = create :item, name: Faker::Name.name
      end

      it "returns bucketlist and all its items" do
        get "/api/v1/bucketlists/1"
        expect(response).to have_http_status 200
        result = JSON.parse(response.body)["bucketlist"]
        expect(result["name"]).to eql(@bucketlist.name)
        expect(result["items"][0]["name"]).to eql(@item1.name)
      end
    end
  end
end

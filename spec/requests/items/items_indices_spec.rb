require "rails_helper"

RSpec.describe "Items::Indices", type: :request do
  include_examples "item token"

  describe "GET /bucetlist/:id/items" do
    before do
      create :bucketlist
    end

    context "when bucketlist does not exist" do
      it "returns 404 error" do
        get "/api/v1/bucketlists/3/items"
        expect(response).to have_http_status(404)
        result = JSON.parse(response.body)["error"]
        expect(result).to eql("Bucketlist not found")
      end
    end

    context "when bucketlist has items" do
      it "returns empty array" do
        get "/api/v1/bucketlists/1/items"
        expect(response).to have_http_status(200)
        result = JSON.parse(response.body)["items"]
        expect(result.size).to eql(0)
      end
    end

    context "when bucketlists has items" do
      before do
        @item1 = create :item
        @item2 = create :item, name: Faker::Name.name
        @item3 = create :item, name: Faker::Name.name
      end

      it "returns 3 items for bucketlist 1" do
        get "/api/v1/bucketlists/1/items"
        result = JSON.parse(response.body)["items"]
        expect(result.size).to eql(3)
        expect(result[0]["name"]).to eql(@item1.name)
      end
    end
  end
end

require "rails_helper"

RSpec.describe "Items::Singles", type: :request do
  include_examples "item token"

  describe "GET /bucketlists/:id/items/:id" do
    before do
      create :bucketlist
      @item = create :item
    end

    context "when bucketlist item exists" do
      it "returns the item" do
        get "/api/v1/bucketlists/1/items/1"
        result = JSON.parse(response.body)["item"]
        expect(result["name"]).to eql(@item.name)
      end
    end

    context "when bucketlist item does not exist" do
      it "returns a 404 error" do
        get "/api/v1/bucketlists/1/items/2"
        expect(response).to have_http_status 404
      end
    end
  end
end

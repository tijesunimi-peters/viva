require "rails_helper"

RSpec.describe "Items::Updates", type: :request do
  include_examples "item token"

  describe "PUT /bucketlist/:id/items/:id" do
    before do
      create :bucketlist
      @item = create :item
    end

    context "when update is successful" do
      it "returns 200 status" do
        put "/api/v1/bucketlists/1/items/1", params: { name: "Hello" }
        expect(response).to have_http_status 200
        item = Item.find_by id: 1

        expect(item.name).to eql("Hello")
      end
    end

    context "when bucketlist item does not exist" do
      it "returns a 404 error" do
        get "/api/v1/bucketlists/1/items/2"
        expect(response).to have_http_status 404
      end
    end

    context "when update details does not validate" do
      it "returns a 500 error" do
        put "/api/v1/bucketlists/1/items/1", params: { name: "" }
        expect(response).to have_http_status 500
      end
    end
  end
end

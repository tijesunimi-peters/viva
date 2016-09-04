require "rails_helper"

RSpec.describe "Items::Creates", type: :request do
  include_examples "item token"

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

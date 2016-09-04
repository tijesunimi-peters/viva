require "rails_helper"

RSpec.describe "Bucketlist::Indices", type: :request do
  include_examples "bucketlist token"

  describe "GET /bucketlists" do
    context "when bucketlist is empty" do
      it "returns empty array" do
        get "/api/v1/bucketlists"
        expect(response).to have_http_status 200
        expect(JSON.parse(response.body)["bucketlists"].size).to eq(0)
      end
    end

    context "when user has bucketlist" do
      before do
        @bklist1 = create :bucketlist
        @bklist2 = create :bucketlist, name: Faker::Name.name
        @bklist3 = create :bucketlist, name: Faker::Name.name
      end

      it "returns all bucketlists" do
        get "/api/v1/bucketlists"
        result = JSON.parse(response.body)["bucketlists"]
        expect(result.size).to eql(3)
        expect(result[0]["name"]).to eql(@bklist1.name)
      end
    end
  end
end

require "rails_helper"

RSpec.describe "Bucketlist::Paginations", type: :request do
  include_examples "bucketlist token"

  describe "pagination" do
    before do
      30.times do
        create :bucketlist, name: Faker::Name.name
      end
    end

    context "when page and limit query is present" do
      it "returns 20 bucketlists" do
        get "/api/v1/bucketlists?page=1&limit=20"
        result = JSON.parse(response.body)["bucketlists"]
        expect(result.size).to eql(20)
      end

      it "returns 10 bucketlists" do
        get "/api/v1/bucketlists?page=2&limit=20"
        result = JSON.parse(response.body)["bucketlists"]
        expect(result.size).to eql(10)
      end
    end

    context "when there is no limit" do
      it "return default limit of bucketlists" do
        get "/api/v1/bucketlists?page=1"
        result = JSON.parse(response.body)["bucketlists"]
        expect(result.size).to eql(20)
      end
    end

    context "when there is no page query" do
      it "returns results for page 1 and limit query" do
        get "/api/v1/bucketlists?limit=30"
        result = JSON.parse(response.body)["bucketlists"]
        expect(result.size).to eql(30)
      end
    end

    context "when there are no queries" do
      it "returns for default page and limit" do
        get "/api/v1/bucketlists"
        result = JSON.parse(response.body)["bucketlists"]
        expect(result.size).to eql(20)
      end
    end

    context "when limit is exceeded" do
      it "returns 413 error" do
        get "/api/v1/bucketlists?page=1&limit=101"
        expect(response).to have_http_status(413)
      end
    end
  end
end

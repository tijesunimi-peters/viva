require "rails_helper"

RSpec.describe "Bucketlist::Searches", type: :request do
  include_examples "bucketlist token"

  describe "GET /bucketlists?q=query" do
    before do
      10.times do |i|
        create :bucketlist, name: "name#{i}"
      end
    end

    context "when there is a search query" do
      it "should return results for the search na" do
        get "/api/v1/bucketlists?q=na"
        result = JSON.parse(response.body)["bucketlists"]
        expect(result.size).to eql(10)

        get "/api/v1/bucketlists?q=1"
        result = JSON.parse(response.body)["bucketlists"]
        expect(result.size).to eql(1)
      end
    end
  end
end

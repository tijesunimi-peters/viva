require "rails_helper"

RSpec.describe "Bucketlist::Searches", type: :request do
  let(:token) { double acceptable?: true, resource_owner_id: 1 }

  before do
    allow_any_instance_of(Api::V1::BucketlistsController).
      to receive(:doorkeeper_token).
      and_return(token)
    create :user
  end

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

require "rails_helper"

RSpec.describe "Bucketlist::CreateBucketlists", type: :request do
  let(:token) { double acceptable?: true, resource_owner_id: 1 }

  before do
    allow_any_instance_of(Api::V1::BucketlistsController).
      to receive(:doorkeeper_token).
      and_return(token)
    create :user
  end

  describe "POST /buckelists" do
    context "when params valid" do
      it "returns 201 success" do
        post "/api/v1/bucketlists", params: { name: "Helloe" }
        expect(response).to have_http_status(201)
      end
    end

    context "when params not valid" do
      it "returns 500 error" do
        post "/api/v1/bucketlists", params: { namr: "Helloe" }
        expect(response).to have_http_status 500
      end
    end

    context "when params is not passed" do
      it "returns 500 error" do
        post "/api/v1/bucketlists"
        expect(response).to have_http_status 500
      end
    end
  end
end

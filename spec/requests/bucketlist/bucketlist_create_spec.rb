require "rails_helper"

RSpec.describe "Bucketlist::Create", type: :request do
  include_examples "bucketlist token"

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

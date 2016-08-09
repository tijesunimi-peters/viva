require 'rails_helper'

RSpec.describe "Buckelists", type: :request do
  let(:token) { double acceptable?: true, resource_owner_id: 1 }

  before do
    allow_any_instance_of(Api::V1::BucketlistsController).
      to receive(:doorkeeper_token).
      and_return(token)
    create :user
  end

  describe "POST /buckelists" do
    context 'when json format is correct' do
      it "returns 201 success" do
        post "/api/v1/bucketlists", params: { bucketlist: { name: "Helloe" }.to_json }
        expect(response).to have_http_status(201)
      end
    end

    context 'when json format is not correct' do
      it 'returns 422 error' do
        post "/api/v1/bucketlists", params: { name: "Helloe" }.to_json
        expect(response).to have_http_status 422
      end
    end
  end
end

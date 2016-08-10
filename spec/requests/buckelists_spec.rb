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

  describe 'GET /bucketlists' do
    context 'when bucketlist is empty' do
      it 'returns empty array' do
        get "/api/v1/bucketlists"
        expect(response).to have_http_status 200
        expect(JSON.parse(response.body)["bucketlists"].size).to eq(0)
      end
    end

    context 'when user has bucketlist' do
      before do
        @bklist1 = create :bucketlist
        @bklist2 = create :bucketlist, name: Faker::Name.name
        @bklist3 = create :bucketlist, name: Faker::Name.name
      end

      it 'returns all bucketlists' do
        get "/api/v1/bucketlists"
        result = JSON.parse(response.body)["bucketlists"]
        expect(result.size).to eql(3)
        expect(result[0]["name"]).to eql(@bklist1.name)
      end
    end
  end

  describe 'GET /bucketlist/:id' do
    context 'when bucketlist is not found' do
      it 'return 404 error' do
        get '/api/v1/bucketlists/1'
        expect(response).to have_http_status 404
      end
    end

    context 'when bucketlist exists' do
      before do
        @bklist = create :bucketlist
        @item1 = create :item
        @item2 = create :item, name: Faker::Name.name
      end

      it 'returns bucketlist and all its items' do
        get '/api/v1/bucketlists/1'
        expect(response).to have_http_status 200
        result = JSON.parse(response.body)["bucketlist"]
        expect(result["name"]).to eql(@bklist.name)
        expect(result["items"][0]["name"]).to eql(@item1.name)
      end
    end
  end

  describe 'PUT /bucketlists/:id' do
    context 'when bucketlist exists' do
      it 'updates bucketlist' do
        @bucketlist = create :bucketlist
        put '/api/v1/bucketlists/1', params: { bucketlist: {id: @bucketlist.id, name: "Hey"}.to_json }
        expect(response).to have_http_status 200
        bktlist = Bucketlist.find_by id: 1
        expect(bktlist.name).to eql("Hey")
      end
    end
  end
end

require 'rails_helper'

RSpec.describe "ItemsRequests", type: :request do
  let(:token) { double acceptable?: true, resource_owner_id: 1 }

  before do
    allow_any_instance_of(Api::V1::ItemsController).
      to receive(:doorkeeper_token).
      and_return(token)
    create :user
  end


  describe "POST /bucketlists/:id/items" do
    it "create items" do
      bucketlist = create :bucketlist
      post "/api/v1/bucketlists/1/items", params: { item: { name: "Hello" }.to_json }
      expect(response).to have_http_status(201)
    end
  end

  describe "GET /bucetlist/:id/items" do
    before do
      create :bucketlist
    end

    context 'when bucketlist has items' do
      it "returns empty array" do
        get "/api/v1/bucketlists/1/items"
        expect(response).to have_http_status(200)
        result = JSON.parse(response.body)["items"]
        expect(result.size).to eql(0)
      end
    end

    context "when bucketlists has items" do
      before do
        item1 = create :item
        item2 = create :item, name: Faker::Name.name
        item3 = create :item, name: Faker::Name.name
      end

      it "returns 3 items for bucketlist 1" do
        get "/api/v1/bucketlists/1/items"
        result = JSON.parse(response.body)["items"]
        expect(result.size).to eql(3)
      end
    end
  end

  describe 'GET /bucketlists/:id/items/:id' do
    before do
      create :bucketlist
      @item = create :item
    end

    context "when bucketlist item exists" do
      it "returns the item" do
        get "/api/v1/bucketlists/1/items/1"
        result = JSON.parse(response.body)["item"]
        expect(result["name"]).to eql(@item.name)
      end
    end

    context 'when bucketlist item does not exist' do
      it "returns a 404 error" do
        get "/api/v1/bucketlists/1/items/2"
        expect(response).to have_http_status 404
      end
    end

    describe 'PUT /bucketlist/:id/items/:id' do
      context 'when update is successful' do
        it "returns 200 status" do
          put "/api/v1/bucketlists/1/items/1", params: { item: { name: "Hello" }.to_json }
          expect(response).to have_http_status 200
          item = Item.find_by id: 1

          expect(item.name).to eql("Hello")
        end
      end

      context 'when bucketlist item does not exist' do
        it "returns a 404 error" do
          get "/api/v1/bucketlists/1/items/2"
          expect(response).to have_http_status 404
        end
      end
    end

    describe "DELETE /bucketlists/:id/items/:id" do
      context "when bucketlist exists" do
        it "returns 200" do
          delete "/api/v1/bucketlists/1/items/1"
          expect(response).to have_http_status 200
          item = Item.find_by id: 1
          expect(item).to be_nil
        end
      end

      context 'when bucketlist item does not exist' do
        it "returns a 404 error" do
          get "/api/v1/bucketlists/1/items/2"
          expect(response).to have_http_status 404
        end
      end
    end
  end

end

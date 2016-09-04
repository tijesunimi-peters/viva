require "rails_helper"

RSpec.describe "Bucketlist::Deletes", type: :request do
  include_examples "bucketlist token"

  describe "DELETE /bucketlists/:id" do
    context "when bucketlist exist" do
      before do
        create :bucketlist
        create :bucketlist, name: Faker::Name.name
      end

      it "deletes the bucketlist" do
        delete "/api/v1/bucketlists/1"
        expect(response).to have_http_status(200)
        bucketlist = Bucketlist.find_by id: 1
        expect(bucketlist).to be_nil
      end
    end

    context 'when bucektlist does not exist' do
      it 'returns not found error' do
        delete "/api/v1/bucketlists/1"
        result = JSON.parse response.body
        expect(result['error']).to eql("Bucketlist not found")
      end
    end
  end
end

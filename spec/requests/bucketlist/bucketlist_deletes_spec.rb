require "rails_helper"

RSpec.describe "Bucketlist::Deletes", type: :request do
  let(:token) { double acceptable?: true, resource_owner_id: 1 }

  before do
    allow_any_instance_of(Api::V1::BucketlistsController).
      to receive(:doorkeeper_token).
      and_return(token)
    create :user
  end

  describe "DELETE /bucketlists/:id" do
    context "when bucketlist exist" do
      before do
        create :bucketlist
        create :bucketlist, name: Faker::Name.name
      end

      it "deletes the bucketlist" do
        delete "/api/v1/bucketlists/1"
        expect(response).to have_http_status(200)
        bktlist = Bucketlist.find_by id: 1
        expect(bktlist).to be_nil
      end
    end
  end
end

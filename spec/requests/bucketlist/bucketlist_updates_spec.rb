require "rails_helper"

RSpec.describe "Bucketlist::Updates", type: :request do
  include_examples "bucketlist token"

  describe "PUT /bucketlists/:id" do
    context "when bucketlist exists" do
      it "updates bucketlist" do
        @bucketlist = create :bucketlist
        put "/api/v1/bucketlists/1", params: {
          id: @bucketlist.id,
          name: "Hey"
        }

        expect(response).to have_http_status 200
        bktlist = Bucketlist.find_by id: 1
        expect(bktlist.name).to eql("Hey")
      end
    end

    context "when bucketlist update detials does not validate" do
      it "bucketlist is not updated" do
        @bucketlist = create :bucketlist
        put "/api/v1/bucketlists/1", params: {
          id: @bucketlist.id,
          name: ""
        }

        expect(response).to have_http_status 500
      end
    end
  end
end

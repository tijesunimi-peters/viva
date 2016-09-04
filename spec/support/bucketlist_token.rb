RSpec.shared_examples "bucketlist token" do
  let(:token) { double acceptable?: true, resource_owner_id: 1 }

  before do
    allow_any_instance_of(Api::V1::BucketlistsController).
      to receive(:doorkeeper_token).
      and_return(token)
    create :user
  end
end
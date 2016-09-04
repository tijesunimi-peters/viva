RSpec.shared_examples "item token" do
  let(:token) { double acceptable?: true, resource_owner_id: 1 }

  before do
    allow_any_instance_of(Api::V1::ItemsController).
      to receive(:doorkeeper_token).
      and_return(token)
    create :user
  end
end
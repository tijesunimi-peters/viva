require "rails_helper"

RSpec.describe User, type: :model do
  describe "#has_many" do
    it { is_expected.to have_many(:bucketlists) }
  end

  describe "#validates" do
    it { is_expected.to validate_presence_of(:firstname) }
    it { is_expected.to validate_presence_of(:lastname) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_confirmation_of(:password) }
    it { is_expected.to have_secure_password }
    it { expect(subject).to allow_value("john@doe.com").for(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_length_of(:password) }
  end
end

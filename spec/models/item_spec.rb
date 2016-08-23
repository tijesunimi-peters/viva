require "rails_helper"

RSpec.describe Item, type: :model do
  describe "belongs_to" do
    it { is_expected.to belong_to(:bucketlist) }
  end

  describe "validates" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :name }
  end
end

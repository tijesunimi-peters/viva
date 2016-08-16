require 'rails_helper'

RSpec.describe Bucketlist, type: :model do
  describe 'has_many' do
    it { is_expected.to have_many :items }
  end

  describe 'belongs_to' do
    it { is_expected.to belong_to :user }
  end

  describe 'validates' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'scopes' do
    it { expect(Bucketlist).to respond_to(:paginate) }
    it { expect(Bucketlist).to respond_to(:search) }
    it { is_expected.to respond_to(:name) }
  end
end

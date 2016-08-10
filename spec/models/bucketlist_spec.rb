require 'rails_helper'

RSpec.describe Bucketlist, type: :model do
  describe 'has_many' do
    it { is_expected.to have_many :items }
  end

  describe 'belongs_to' do
    it { is_expected.to belong_to :user }
  end
end

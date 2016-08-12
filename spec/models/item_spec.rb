require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'belongs_to' do
    it { is_expected.to belong_to(:bucketlist) }
  end
end

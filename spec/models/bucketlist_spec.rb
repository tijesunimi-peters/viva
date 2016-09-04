require "rails_helper"

RSpec.describe Bucketlist, type: :model do
  describe "has_many" do
    it { is_expected.to have_many :items }
  end

  describe "belongs_to" do
    it { is_expected.to belong_to :user }
  end

  describe "validates" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe "scopes" do
    it { expect(Bucketlist).to respond_to(:paginate) }
    it { expect(Bucketlist).to respond_to(:search) }
    it { is_expected.to respond_to(:name) }
  end

  describe "paginate" do
    before do
      30.times do
        create :bucketlist, name: Faker::Name.name
      end
    end 

    context "when limit is 10 and page is 1" do
      it 'returns 10 bucketlist' do
        result = Bucketlist.paginate 1, 10
        expect(result.size).to eql(10)
        expect(result[0].id).to eql(1)
      end
    end

    context 'when limit is 10 and page is 2' do
      it 'returns 10 bucketlist starting from 11' do
        result = Bucketlist.paginate 2, 10
        expect(result[0].id).to eql(11)
      end
    end

    context 'when no argument is passed' do
      it 'returns 20 bucketlists' do
        result = Bucketlist.paginate
        expect(result.size).to eql(20)
      end
    end

    context 'when upperlimit is exceeded' do
      it 'returns nil' do
        result = Bucketlist.paginate 1, 200
        expect(result).to be_nil
      end
    end
  end

  describe '#search' do
    before do
      create :bucketlist, name: 'bucketlist1'
    end

    context 'when query is in uppercase' do
      it 'returns bucketlist1' do
        result = Bucketlist.search "BUC"
        expect(result[0].name).to eql('bucketlist1')
      end
    end

    context 'when query is in mixed case' do
      it 'returns bucketlist1' do
        result = Bucketlist.search "bUcKE"
        expect(result[0].name).to eql('bucketlist1')
      end
    end
  end
end

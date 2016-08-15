FactoryGirl.define do
  factory :item do
    name Faker::Name.name
    bucketlist_id 1
    done false
  end
end
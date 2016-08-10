FactoryGirl.define do
  factory :item do
    name Faker::Name.name
    description Faker::Lorem.sentence
    bucketlist_id 1
    done false
  end
end
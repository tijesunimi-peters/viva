class Item < ApplicationRecord
  belongs_to :bucketlist

  validates :name, presence: true, allow_nil: false
end

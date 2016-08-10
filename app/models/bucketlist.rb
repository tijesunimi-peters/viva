class Bucketlist < ApplicationRecord
  has_many :items, dependent: :destroy
  belongs_to :user

  def self.paginate(page = 1, limit = 20)
    offset_number = (page - 1) * limit
    offset(offset_number).limit(limit)
  end
end

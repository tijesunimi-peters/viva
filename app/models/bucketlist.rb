class Bucketlist < ApplicationRecord
  has_many :items, dependent: :destroy
  belongs_to :user

  def self.paginate(page = 1, limit = 20)
    page = 1 if page == 0
    limit = 20 if limit == 0
    offset_number = (page - 1) * limit
    offset(offset_number).limit(limit)
  end

  def self.search(query)
    where("name like ?", "%#{query}%")
  end
end

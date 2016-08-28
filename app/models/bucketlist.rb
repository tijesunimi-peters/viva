class Bucketlist < ApplicationRecord
  has_many :items, dependent: :destroy
  belongs_to :user

  validates :name, presence: true, allow_nil: false, uniqueness: true

  def self.paginate(page = 1, limit = 20)
    page = 1 if page.zero?
    limit = 20 if limit.zero?
    offset_number = (page - 1) * limit
    order(id: "asc").offset(offset_number).limit(limit)
  end

  def self.search(query)
    where("lower(name) like ?", "%#{query.downcase}%")
  end
end

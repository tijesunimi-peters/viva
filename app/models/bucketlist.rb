class Bucketlist < ApplicationRecord
  has_many :items, dependent: :destroy
  belongs_to :user

  validates :name, presence: true, allow_nil: false, uniqueness: true
  UPPERLIMIT = 100
  LOWERLIMIT = 20

  def self.paginate(page, limit)
    return if limit.to_i > UPPERLIMIT
    page = 1 if page.to_i.zero?
    limit = LOWERLIMIT if limit.to_i.zero?
    offset_number = (page.to_i - 1) * limit.to_i
    order(id: "asc").offset(offset_number).limit(limit)
  end

  def self.search(query)
    where("lower(name) like ?", "%#{query.downcase}%")
  end
end

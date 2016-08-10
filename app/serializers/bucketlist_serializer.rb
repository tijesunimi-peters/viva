class BucketlistSerializer < ActiveModel::Serializer
  include Utilities

  attributes :id, :name, :items, :date_created, :date_modified, :created_by

  def items
    object.items.map do |item|
      ItemSerializer.new(item, scope: scope, root: false)
    end
  end

  def created_by
    object.user.firstname
  end
end

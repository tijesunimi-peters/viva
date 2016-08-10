class ItemSerializer < ActiveModel::Serializer
  include Utilities
  attributes :id, :name, :description, :done, :date_created, :date_modified
end

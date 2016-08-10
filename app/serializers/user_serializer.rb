class UserSerializer < ActiveModel::Serializer
  include Utilities
  
  attributes :id, :firstname, :lastname, :email
end

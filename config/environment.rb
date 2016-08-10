# Load the Rails application.
require_relative 'application'

ActiveModel::Serializer.config.adapter = :json
# Initialize the Rails application.
Rails.application.initialize!

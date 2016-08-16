require 'coveralls'
require 'simplecov'
Coveralls.wear!


RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
   add_filter '/spec/controllers/api/apis_controller_spec.rb'
   add_filter '/spec/rails_helper.rb'
   add_filter '/config/initializers/doorkeeper.rb'
end

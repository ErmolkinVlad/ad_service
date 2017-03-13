require 'capybara/rspec'
require 'factory_girl_rails'
require 'shoulda/matchers'
require 'aasm/rspec'
require 'support/omniauth_macros'
require 'omniauth'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  
  config.include(OmniauthMacros)

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

OmniAuth.config.test_mode = true
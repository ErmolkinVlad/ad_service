require_relative 'boot'

require 'rails/all'
require 'slim'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AdService
  class Application < Rails::Application
    # config.sass.load_paths << File.expand_path('../../app/assets/stylesheets/')
    # config.sass.load_paths << File.expand_path('../../vendor/assets/stylesheets/')

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.action_controller.include_all_helpers = true
  end
end

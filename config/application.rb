require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsTutorial
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    # config/application.rb
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}")]

    config.load_defaults 7.0
    config.active_storage.variant_processor = :mini_magick
    config.i18n.available_locales = [:en, :vi]
    config.i18n.default_locale = :en

    config.action_view.embed_authenticity_token_in_remote_forms = true

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end

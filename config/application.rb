require_relative 'boot'

require 'rails/all'
require 'klaviyo'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GoodfairLandingPage
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.hosts << "28a83e009172.ngrok.io"
    # config.hosts << "9056ca6ac0fc.ngrok.io"

    ShopifyAPI::Base.site = "https://#{ENV["API_KEY"]}:#{ENV["PASSWORD"]}@#{ENV["SHOPIFY_URL"]}/admin"
    ShopifyAPI::Base.api_version = '2020-04'

    # set your 6 digit Public API key
    Klaviyo.public_api_key = ENV['KLAVIYO_PUBLIC_API_KEY']

    # set your Private API key
    Klaviyo.private_api_key = ENV['KLAVIYO_PRIVATE_API_KEY']

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

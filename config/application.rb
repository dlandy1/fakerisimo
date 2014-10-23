require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
require 'rack/throttle'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Fakerisimo

  class Application < Rails::Application
  config.require "api_throttle"
  # max 100 requests per hour per ip
  config.middleware.use ApiThrottle, :max => 100

  end
end

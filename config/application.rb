require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Microposts
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    
    config.generators do |g|
      g.stylesheets false
      g.javascripts false
      g.helper false
      g.test_framework false
    end
    
    config.action_view.embed_authenticity_token_in_remote_forms = true
  end
end

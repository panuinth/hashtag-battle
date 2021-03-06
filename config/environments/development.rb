Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  #config.cache_classes = false
  config.cache_classes = true

  # Do not eager load code on boot.
  config.eager_load = true
  #config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  config.twitter_consumer_key = "VIftGkecEUGzPqbtEn7jfVBX7"
  config.twitter_consumer_secret = "epXZh5FPdNCJlMAuFG6UA3ojLHxjP5XE0VTc6jvdi8x0Uu6PxV"
  config.twitter_access_token = "280079080-mrZoBxfANlVrIk4uMEQaTATArYfwlNlZW9U5dxta"
  config.twitter_access_token_secret = "Wkn1PBAGgTCvsJqpStKeopkFjX080mNrf82AunzC6MgX1"

  config.redis_host = "localhost"
  config.redis_password = nil
  config.redis_port = "6379"

  TweetStream.configure do |config|
    config.consumer_key       = Rails.application.config.twitter_consumer_key
    config.consumer_secret    = Rails.application.config.twitter_consumer_secret
    config.oauth_token        = Rails.application.config.twitter_access_token
    config.oauth_token_secret = Rails.application.config.twitter_access_token_secret
    config.auth_method        = :oauth
  end


end

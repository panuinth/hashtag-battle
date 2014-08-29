Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = false

  # Configure static asset server for tests with Cache-Control for performance.
  config.serve_static_assets  = true
  config.static_cache_control = 'public, max-age=3600'

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

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

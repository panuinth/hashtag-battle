class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def twitter_streaming_client
    @twitter_streaming_client ||= Twitter::Streaming::Client.new do |config|
      config.consumer_key        = Rails.application.config.twitter_consumer_key
      config.consumer_secret     = Rails.application.config.twitter_consumer_secret
      config.access_token        = Rails.application.config.twitter_access_token
      config.access_token_secret = Rails.application.config.twitter_access_token_secret
    end
  end

end

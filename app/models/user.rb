class User < ActiveRecord::Base
  def load_home_timeline
    config = {
      consumer_key: Rails.application.secrets.twitter_consumer_key,
      consumer_secret: Rails.application.secrets.twitter_consumer_secret,
      access_token: twitter_key,
      access_token_secret: twitter_secret
    }

    @client = Twitter::REST::Client.new(config)

    @client.home_timeline
  end
end


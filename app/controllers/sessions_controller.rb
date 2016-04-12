class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create

  # config = {
  #   consumer_key: Rails.application.secrets.twitter_consumer_key,
  #   consumer_secret: Rails.application.secrets.twitter_consumer_secret
  # }

  # client = Twitter::REST::Client.new(config)

  def new
    config = {
      consumer_key: Rails.application.secrets.twitter_consumer_key,
      consumer_secret: Rails.application.secrets.twitter_consumer_secret
    }

    @client = Twitter::REST::Client.new(config)

    def @client.get_all_tweets(user)
      collect_with_max_id do |max_id|
        options = {count: 200, include_rts: true}
        options[:max_id] = max_id unless max_id.nil?
        user_timeline(user, options)
      end
    end

  end

  def create
  end

  def destroy
  end

  def auth_hash
    request.env['omniauth.auth']
  end

  def collect_with_max_id(collection=[], max_id=nil, &block)
    response = yield(max_id)
    collection += response
    response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
  end

end

class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create

  def new
  end

  def create
    user = User.find_or_create_by(provider: auth_hash[:provider], uid: auth_hash[:uid])
    user.update_attributes(name: auth_hash[:info][:name], twitter_key: auth_hash[:credentials][:token], twitter_secret: auth_hash[:credentials][:secret])

    session[:uid] = user.id

    redirect_to sessions_new_path
  end

  def destroy
    reset_session

    redirect_to :root
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end

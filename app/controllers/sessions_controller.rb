class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create

  def new
  end

  def create
    user = User.find_or_create_by(provider: auth_hash[:provider], uid: auth_hash[:uid])
    user.update_attributes(name: auth_hash[:info][:name], twitter_key: auth_hash[:credentials][:token], twitter_secret: auth_hash[:credentials][:secret])

    session[:user_id] = user.id

    redirect_to '/users/' + current_user.id.to_s
  end

  def destroy
    reset_session

    redirect_to sessions_new_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end

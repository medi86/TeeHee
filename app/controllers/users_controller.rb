class UsersController < ApplicationController
  def show
    @user_tweets = current_user.load_home_timeline
  end
end

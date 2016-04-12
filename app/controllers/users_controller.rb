class UsersController < ApplicationController
  def show
    if !logged_in?
      redirect_to root_path
    else
      @user_tweets = current_user.load_home_timeline
    end
  end
end

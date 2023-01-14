# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def create
    user_info = request.env['omniauth.auth']

    # if the user is not signed in, create a new user
    @user = User.find_by(twitter_id: user_info.uid)
    password = Devise.friendly_token[0, 20]
    params = {
      twitter_id: user_info.uid,
      name: user_info.info.name,
      nickname: user_info.info.nickname,
      email: user_info.info.email || "#{user_info.info.nickname.downcase}@twitter.com",
      password:,
      password_confirmation: password,
      token: user_info.credentials.token,
      refresh_token: user_info.credentials.refresh_token,
      expires_at: Time.at(user_info.credentials.expires_at).to_datetime
    }
    if @user.nil?
      @user = User.create!(params)
    else
      # if the user is already signed in, update the user's twitter info
      @user.update!(
        token: params[:token],
        refresh_token: params[:refresh_token],
        expires_at: params[:expires_at]
      )
    end

    session[:user_id] = @user.id

    redirect_to bookmarks_path
  end
end

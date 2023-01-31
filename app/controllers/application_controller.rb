# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :check_login

  def require_user!
    if !current_user
      redirect_to root_path
    end
  end

  def require_user_subscription!
    if !current_user.payment_processor.subscribed?
      redirect_to "/checkout"
    end
  end

  def check_login
    if current_user && request.path == "/"
      redirect_to logout_path
    end
  end

  protected

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:email, :password, :password_confirmation, :twitter_id, :nickname, :name, :token,
                         :refresh_token, :expires_at)
    end

    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:email, :password, :password_confirmation, :current_password, :nickname, :name)
    end
  end
end

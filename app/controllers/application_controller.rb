class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  protected 

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:email, :password, :password_confirmation, :twitter_id, :nickname, :name, :token, :refresh_token, :expires_at)
    end

    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:email, :password, :password_confirmation, :current_password, :nickname, :name)
    end
  end
end

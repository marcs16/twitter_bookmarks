# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def root
    # redirect to users/sign_in if not signed in
    redirect_to new_user_session_path
  end
end

# frozen_string_literal: true

class BookmarksController < ApplicationController
  before_action :require_user!
  def index
    client = Twitter::TwitterClient.new(current_user)
    @bookmarks = client.bookmarks
  end
end

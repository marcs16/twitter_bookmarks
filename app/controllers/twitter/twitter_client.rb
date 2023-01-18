# frozen_string_literal: true

module Twitter
  class TwitterClient < Rest::RestController
    def initialize(user)
      @user = user
    end

    def me
      get '/users/me'
    end

    def bookmarks
      query_string = {
        'tweet.fields': 'context_annotations,created_at',
        'expansions': 'author_id',
        'user.fields': 'profile_image_url'
      }.to_query
      get "/users/#{@user.twitter_id}/bookmarks?#{query_string}"
    end

    private

    def headers
      {
        authorization: "Bearer #{@user.token}",
        "User-Agent": 'RailsBookmarksSearch'
      }
    end

    def set_base_url
      'https://api.twitter.com/2'
    end
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer if Rails.env.development?
  provider(
    :twitter2,
    client_id: ENV["TWITTER_CLIENT_ID"],
    client_secret: ENV["TWITTER_CLIENT_SECRET"],
    callback_path: "/auth/twitter2/callback",
    scope: "tweet.read users.read bookmark.read offline.access"
    )
end
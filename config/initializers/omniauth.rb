Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :developer unless Rails.env.production?
end

OmniAuth.config.full_host = ENV.fetch("OMNIAUTH_FULL_HOST", 'your.host.com')

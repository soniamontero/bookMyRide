REDIS = Redis.new

url = Rails.application.credentials.dig(Rails.env.to_sym, :redis, :url)

if url
  Sidekiq.configure_server do |config|
    config.redis = { url: url }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: url }
  end
  REDIS = Redis.new(url: url)
end

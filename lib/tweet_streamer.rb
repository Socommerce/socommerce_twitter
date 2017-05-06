root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
require File.join(root, 'config', 'environment')

log = File.join(root, 'log', 'stream.log')

TweetStream.configure do |conf|
  conf.consumer_key        = 'a0UmBU7AHn0fFneQ10zYwP0Kk'
  conf.consumer_secret     = 'JZEqUgKJsTrYjjvYv1wO4jtrNpy50pwoTUwr4UAro3pPxS7Hhw'
  conf.oauth_token         = '3139928784-B7kPZz6zLAe1M9bTFI29dSfhU6J6Fi9mNdOmhqC'
  conf.oauth_token_secret  = 'f6cGgOSBU78IPjHz7lDCiOfv4zS4K90OepO2x2355JFqS'
  conf.auth_method         = :oauth
end

daemon = TweetStream::Daemon.new('tweet_streamer', log_output: true)
daemon.on_inited do
  ActiveRecord::Base.connection.reconnect!
  ActiveRecord::Base.logger = Logger.new(File.open(log, 'a'))
end
daemon.track('harvey', 'beyonce', 'kanye', 'kardashian') do |status|
  ::Tweet.create_from_status(status)
end

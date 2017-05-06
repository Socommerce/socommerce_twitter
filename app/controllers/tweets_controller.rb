class TweetsController < ApplicationController
  def tweet
    p "working"
# ENV["RAILS_ENV"] ||= "development"
# root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
# require File.join(root, 'environment')

# log = File.join(root, 'log', 'stream.log')

TweetStream.configure do |conf|
  conf.consumer_key        = 'a0UmBU7AHn0fFneQ10zYwP0Kk'
  conf.consumer_secret     = 'JZEqUgKJsTrYjjvYv1wO4jtrNpy50pwoTUwr4UAro3pPxS7Hhw'
  conf.oauth_token         = '3139928784-B7kPZz6zLAe1M9bTFI29dSfhU6J6Fi9mNdOmhqC'
  conf.oauth_token_secret  = 'f6cGgOSBU78IPjHz7lDCiOfv4zS4K90OepO2x2355JFqS'
  conf.auth_method         = :oauth
end

# daemon = TweetStream::Daemon.new('tweet_streamer', log_output: true)
# daemon.on_inited do
#   ActiveRecord::Base.connection.reconnect!
#   ActiveRecord::Base.logger = Logger.new(File.open(log, 'a'))
# end
# daemon.userstream do |status|
#   binding.pry
#   puts status.text
# end

client = TweetStream::Client.new  
# daemon.on_inited do
#   ActiveRecord::Base.connection.reconnect!
#   ActiveRecord::Base.logger = Logger.new(File.open(log, 'a'))
# end
client.userstream do |status|
  puts status.text
  Tweet.create(status: status.text)
  puts JSON.parse(status)
end

end

end
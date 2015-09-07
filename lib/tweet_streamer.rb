root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
require File.join(root, 'config', 'environment')

log = File.join(root, 'log', 'stream.log')

TweetStream.configure do |conf|
  conf.consumer_key        = 'gWklbzzMP0avmY3VF9FNw'
  conf.consumer_secret     = 'hNVwweFevkmcMlfiowkhQHczOHaJlURdZoNVMHL80w'
  conf.oauth_token         = '4618-aAzT8VSxDBLsUSLTOnVEEEFPDukOhfSEstMzkRU6GLE'
  conf.oauth_token_secret  = 'qAXEKMPi0zFNTMnRJh5ijZj7c8hZSuXWmQ90AH7miZc'
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

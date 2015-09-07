# Store recorded tweets
class Tweet < ActiveRecord::Base
  def self.create_from_status(status)
    create!(
      status: status.text,
      user: status.user.screen_name,
      posted_at: status.created_at
    )
  end
end

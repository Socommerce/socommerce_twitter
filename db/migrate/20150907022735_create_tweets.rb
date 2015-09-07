class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.text :status
      t.string :user
      t.datetime :posted_at

      t.timestamps null: false
    end
  end
end

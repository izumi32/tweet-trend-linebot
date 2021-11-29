namespace :push_line do
  desc 'push_line'
  task push_line_message_1_hour: :environment do

    line_client = Line::Bot::Client.new do |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    end

    twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_API_KEY']
      config.consumer_secret = ENV['TWITTER_API_SECRET_KEY']
      config.access_token = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_SECRET_TOKEN']
    end

    trends = twitter_client.trends(id = 23424856).attrs[:trends].first(10)
    text = ''

    trends.each do |trend|
      text << trend[:name] + "\n" + trend[:url] + "\n" + "\n"
    end

    message = {
      type: 'text',
      text: text
    }

    user_ids = User.all.map(&:line_id)
    response = line_client.multicast(user_ids, message)
  end
end

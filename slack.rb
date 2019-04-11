require 'slack-ruby-client'

TOKEN = ''

Slack.configure do |conf|
  conf.token = TOKEN
end

client = Slack::RealTime::Client.new

client.on :hello do
  puts 'connected!'
  client.message channel: 'your_channel_id', text: 'connected!'
end

client.on :message do |data|
  if data['text'].include?('hi')
    client.message channel: data['channel'], text: "Hi!!!"
  else
    client.message channel: data['channel'], text: "Thank you"
  end
end

client.start!


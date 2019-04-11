# coding: utf-8
require 'slack-ruby-client'
require 'json'
require 'open-uri'

uri = "http://weather.livedoor.com/forecast/webservice/json/v1?city=370000"

TOKEN = ''

Slack.configure do |conf|
  conf.token = TOKEN
end

res = JSON.load(open(uri).read)
title = res['title']
link = res['link']
weather = res['forecasts'].first
message = "[#{weather['date']}の#{title}]は「#{weather['telop']}」です。"

client = Slack::RealTime::Client.new

client.on :hello do
  puts 'connected!'
  client.message channel: 'your_channel_id', text: 'connected!'
end

client.on :message do |data|
  if data['text'].include?('hi')
    client.message channel: data['channel'], text: "Hi!!!"
  elsif data['text'].include?('weather')
    client.message channel: data['channel'], text: message
  else
    client.message channel: data['channel'], text: "Thank you"
  end
end

client.start!


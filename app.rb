# My Bitcoin Slack Bot

require 'sinatra'
require 'httparty'
require 'json'

post '/price' do
  return if params[:token] != ENV['SLACK_TOKEN']

  text = params[:text]
  spot_price_url = 'http://www.omdbapi.com/?t=%22Jurassic%20Park%22'

  case text
    when 'price'
      resp = HTTParty.get(spot_price_url)
      resp = JSON.parse resp.body
      respond_message "#{resp}"
  end
end

def respond_message message
  content_type :json
  {:text => message}.to_json
end

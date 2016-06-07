# My Bitcoin Slack Bot

require 'sinatra'
require 'httparty'
require 'json'

heroku config:set SLACK_TOKEN=hpgHDD26xC9RqpBXLQ0sHvaU

post '/process_command' do
  return if params[:token] != ENV['SLACK_TOKEN']

  text = params[:text]
  spot_price_url = 'https://api.coinbase.com/v2/prices/spot'

  case text
    when 'price'
      resp = HTTParty.get(spot_price_url)
      resp = JSON.parse resp.body
      respond_message "The current Bitcoin spot price is $#{resp['data']['amount']} #{resp['data']['currency']}."
  end
end

def respond_message message
  content_type :json
  {:text => message}.to_json
end

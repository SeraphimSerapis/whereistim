require 'sinatra'
require 'foursquare2'

client = Foursquare2::Client.new(
  :client_id => ENV['client_id'],
  :client_secret => ENV['client_secret'],
  :oauth_token => ENV['oauth_token'],
  :api_version => '20140530'
)

get '/' do
  name = ENV['name']
  twitter = ENV['twitter']
  last_checkins = client.user_checkins(:limit => 3)
  venue_id = last_checkins.items.first.venue.id
  venue = client.venue(venue_id)
  city = venue.location.city
  country = venue.location.country
  erb :index, :locals => {
    :city => city,
    :country => country,
    :name => name,
    :twitter => twitter
  }
end

# Bit.ly API implementation - thanks to Richard Johansso http://gist.github.com/112191
# forked from jehiah/bitly.rb

#I'm going to try to update this to use the public oauth
require 'httparty'
 
class Bitly
  include HTTParty
  base_uri 'https://api-ssl.bit.ly'
  format :json
  
  # Usage: Bitly.shorten("http://example.com")
  def self.shorten(url)
    response = get('/v3/shorten', :query => required_params.merge(:longUrl => url ))
    #binding.pry
    response['data']["url"]
  end
 
  # Usage: Bitly.stats("http://bit.ly/18LNRV")  
  def self.clicks(url)
    response = get('/v3/clicks', :query => required_params.merge(:shortUrl => url))
    response['data']['clicks'][0]['user_clicks']
  end
  
  # your bit.ly api key can be found at http://bit.ly/a/your_api_key
  def self.required_params
    #{:version => "2.0.1", :login => "LOGIN", :apiKey => 'API_KEY'}
    {:access_token => "81416f41e6c48800af3e6cc477c101b6089bd87c"}
    #The access token should be in an environment variable or anotehr secure place and not checked into github, but its an ananoumous one so maybe it doesn't matter?
  end
end

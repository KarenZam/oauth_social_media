require 'oauth_behance'

class Oauth::BehanceCallbackController < ApplicationController
  def index
    # from behance http://www.behance.net/dev/authentication
    if params["code"]
      @code = params["code"]
    else
      @error = params["error"]
    end
    @state_returned = params["state"]
  end
  
  def access_token

    @access_token, @username, @display_name = OauthBehance.exchange_token(params[:code])
    
    # define here the params you want to store
    #projects
    uri = URI.parse("http://www.behance.net/v2/projects?q=motorcycle&api_key=#{ENV["BEHANCE_APP_ID"]}")

    response = Net::HTTP.get(uri)
    formatted_response = JSON.parse(response)
    
  end
end
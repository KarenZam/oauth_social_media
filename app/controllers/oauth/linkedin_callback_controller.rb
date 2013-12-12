require 'linkedin'

class Oauth::LinkedinCallbackController < ApplicationController

  def generate_linkedin
    client = LinkedIn::Client.new
    request_token = client.request_token(:oauth_callback =>"http://my-localhost.com:3000/oauth/callbackLinkedin")
    session[:rtoken] = request_token.token
    session[:rsecret] = request_token.secret
    redirect_to client.request_token.authorize_url
    
  end

  def linkedin_callback
    client = LinkedIn::Client.new

    pin = params[:oauth_verifier]
    atoken, asecret = client.authorize_from_request(session[:rtoken], session[:rsecret], params[:oauth_verifier])
    session[:atoken] = atoken
    session[:asecret] = asecret
    @linkedin_profile = client.profile
  end

end


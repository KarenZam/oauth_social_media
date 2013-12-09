class Oauth::TwitterCallbackController < ApplicationController

  def generate_twitter
    @twitter_user = TwitterOAuth::Client.new(
      :consumer_key => ENV["TWITTER_APP_ID"],
      :consumer_secret => ENV["TWITTER_APP_SECRET"]
    )

    request_token = @twitter_user.request_token(:oauth_callback => "http://my-localhost.com:3000/oauth/callbackTwitter")
    session[:rtoken] = request_token.token
    session[:rsecret] = request_token.secret

    redirect_to request_token.authorize_url
  end

  def twitter_callback
    @client = TwitterOAuth::Client.new(
      :consumer_key => ENV["TWITTER_APP_ID"],
      :consumer_secret => ENV["TWITTER_APP_SECRET"]
    )
    access_token = @client.authorize(session[:rtoken], session[:rsecret], :oauth_verifier => params[:oauth_verifier])
    atoken = access_token.token
    asecret = access_token.secret
    @user_id = params[:user_id]

    puts
    puts
    puts "////////// USER ID ///////////////"
    puts @user_id
    puts @user_id.keys
    puts
    puts @user_id.values
    
  end

  def twitter_profile

  end

end


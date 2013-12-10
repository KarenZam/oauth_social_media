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
    @twitter_user = TwitterOAuth::Client.new(
      :consumer_key => ENV["TWITTER_APP_ID"],
      :consumer_secret => ENV["TWITTER_APP_SECRET"]
    )
    puts "////////////////////////////"
    puts "rtoken"
    puts session[:rtoken]
    puts "rsecret"
    puts session[:rsecret]
    # access_token = @twitter_user.authorize(session[:rtoken], session[:rsecret], :oauth_verifier => params[:oauth_verifier])
    # atoken = access_token.token
    # asecret = access_token.secret
    

    # puts
    # puts
    # puts "////////// USER ID ///////////////"
    # puts @twitter_user.inspect
    # puts "////////// USER PARAMS ///////////////"
    # puts @twitter_user
    # puts
        
  end


end



# u = TwitterOAuth::Client.new(:consumer_key => "LqlUXDjbTxun0pjudhEifQ",:consumer_secret => "JMBtg3dx3rhTgMO8OIj64BWHa78AT0yfBQfAvCVmY")

# u.authorize("xamW5CT3p2pFQCY77vogeUv3qIfKIiZPTbKnf9BGFng", "FcjyHwceyrbtCuNHFun9WOqcH9RMD4yYs8dpNbaHYw", :oauth_verifier => "hLsX41PvHO1c5h0EEow4Qvu68VJXRTisPDJgyMOisQ")


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
    access_token = @twitter_user.authorize(session[:rtoken], session[:rsecret], :oauth_verifier => params[:oauth_verifier])
    atoken = access_token.token
    asecret = access_token.secret

    @twitter_user.info["id_str"]
    
    @twitter_user.user.first["user"]["screen_name"]
    @twitter_user.user.first["user"]["description"]
    @twitter_user.user.first["user"]["location"]
    @twitter_user.user.first["user"]["followers_count"]
    @twitter_user.user.first["user"]["profile_background_image_url"]
    @twitter_user.user.first["user"]["profile_image_url"]
    end

  end

end




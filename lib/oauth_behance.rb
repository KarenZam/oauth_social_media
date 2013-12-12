require "net/http"
require "uri"

class OauthBehance
  # 1. Redirect users to request Behance access
  # http://www.behance.net/dev/authentication
  def self.authorize_url(random_token)
    # scope = "user,user:email,user:follow,public_repo,repo,repo:status,delete_repo,notifications,gist"
    client_id = ENV["BEHANCE_APP_ID"]
    redirect_uri = "http://my-localhost.com:3000/oauth/callbackBehance"
    scope = "activity_read|project_read"
    state = random_token

    "https://www.behance.net/v2/oauth/authenticate?client_id=#{client_id}&redirect_uri=#{redirect_uri}&scope=#{scope}&state=#{state}"
  end
  
  # 2. Behance redirects back to your site
  def self.exchange_token(code)
    uri = URI.parse("https://www.behance.net/v2/oauth/token")

    data = {
      client_id: ENV["BEHANCE_APP_ID"],
      client_secret: ENV["BEHANCE_APP_SECRET"],
      code: code,
      redirect_uri: "http://my-localhost.com:3000/oauth/callbackBehance"
    }
    response = Net::HTTP.post_form(uri, data)
    formatted_response = JSON.parse(response.body)
    access_token = formatted_response["access_token"]
    username = formatted_response["user"]["username"]
    display_name = formatted_response["user"]["display_name"]
    access_token
    
    [access_token, username, display_name]
  end
  
end




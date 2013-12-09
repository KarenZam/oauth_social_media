require "net/http"
require "uri"

class OauthGithub
  # 1. Redirect users to request GitHub access
  # http://developer.github.com/v3/oauth/
  def self.authorize_url(random_token)
    scope = "user,user:email,user:follow,public_repo,repo,repo:status,delete_repo,notifications,gist"
    client_id = ENV["GITHUB_APP_ID"]
    redirect_uri = "http://my-localhost.com:3000/oauth/callbackGithub"
    # "http://localhost:3000/oauth/callback"

    "https://github.com/login/oauth/authorize?scope=#{scope}&client_id=#{client_id}&redirect_uri=#{redirect_uri}&state=#{random_token}"
  end
  
  # 2. GitHub redirects back to your site
  def self.exchange_token(code)
    uri = URI.parse("https://github.com/login/oauth/access_token")

    data = {
      client_id: ENV["GITHUB_APP_ID"],
      client_secret: ENV["GITHUB_APP_SECRET"],
      code: code,
      redirect_uri: "http://my-localhost.com:3000/oauth/callbackGithub"
    }
    response = Net::HTTP.post_form(uri, data)
    result = response.body
    values = result.split("&")
    access_token = values[0].split("=")[1]
    access_token
  end
  
  # def self.get_public_profile(github_username)
  #   uri = URI.parse("https://api.github.com/users/#{github_username}")
  # 
  #   http = Net::HTTP.new(uri.host, uri.port)
  #   request = Net::HTTP::Get.new(uri.to_s)
  # 
  #   response = http.request(request)
  # 
  #   response.code
  #   response_in_json = JSON.parse(response.body)
  #   
  #   puts "response_in_json:"
  #   puts response_in_json
  # end
end




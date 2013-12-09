require 'oauth_github'

class Oauth::GithubCallbackController < ApplicationController
  def index
    @state = params["state"]
    @code = params["code"]
  end
  
  def access_token
    @access_token = OauthGithub.exchange_token(params[:code])
    
    @user_repos_url = "https://api.github.com/user/repos?access_token=#{@access_token}"
    @user_orgs_url = "https://api.github.com/user/orgs?access_token=#{@access_token}"    
  end
end
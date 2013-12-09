require 'oauth_behance'
require 'oauth_github'

class HomeController < ApplicationController
  def index
    state = SecureRandom.hex(32)
    session[:random_oauth_token] = state
    @authorize_github_url = OauthGithub.authorize_url(state)
  
    @authorize_behance_url = OauthBehance.authorize_url(state)
  end
end

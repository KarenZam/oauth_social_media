OauthGithubSample::Application.routes.draw do
  root 'home#index'
  
  namespace :oauth do
    get "callbackBehance" => "behance_callback#index"
    post "behance_access_token" => "behance_callback#access_token"
    get "behance_access_token" => "behance_callback#access_token"

    get "callbackGithub" => "github_callback#index"
    post "github_access_token" => "github_callback#access_token"

    get "callbackTwitter" => "twitter_callback#twitter_callback"
    get 'generate_twitter' => 'twitter_callback#generate_twitter'

    get "callbackLinkedin" => "linkedin_callback#linkedin_callback"
    get 'generate_linkedin' => 'linkedin_callback#generate_linkedin'

  end
  
end

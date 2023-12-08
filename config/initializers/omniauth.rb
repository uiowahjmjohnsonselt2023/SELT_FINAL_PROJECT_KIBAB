# Documentation
# Additional tutorial for implementation: https://dev.to/anne46/google-omniauth-in-a-rails-app-36ka
# Additional implentation strategies: https://github.com/zquestz/omniauth-google-oauth2

Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.allowed_request_methods = [:post, :get]
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {
    scope: 'email, profile',
    prompt: 'select_account',
    image_aspect_ratio: 'square',
    image_size: 50
  }
end
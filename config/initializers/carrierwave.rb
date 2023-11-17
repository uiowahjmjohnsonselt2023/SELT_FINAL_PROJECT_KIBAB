require 'base64'
CarrierWave.configure do |config|
  config.fog_provider = 'fog/google'
  config.fog_credentials = {
    provider: 'Google',
    google_project: ENV["GOOGLE_PROJECT_NAME"],
    google_json_key_string: ENV["GOOGLE_JSON_KEY_STRING"]
  }
  config.fog_directory = ENV['GOOGLE_BUCKET_NAME']
end
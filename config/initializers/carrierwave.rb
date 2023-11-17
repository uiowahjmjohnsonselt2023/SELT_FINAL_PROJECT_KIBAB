require 'base64'
CarrierWave.configure do |config|
  config.fog_provider = 'fog/google'
  config.fog_credentials = {
    provider: 'Google',
    # google_storage_access_key_id: ENV['GOOGLE_STORAGE_ACCESS_KEY_ID'],
    # google_storage_secret_access_key: ENV['GOOGLE_STORAGE_SECRET_ACCESS_KEY']
    google_project: Rails.application.secrets.google_cloud_storage_project_name,
    google_json_key_string: Rails.application.secrets.google_cloud_storage_credential_content
    # google_json_key_string: Base64.decode64(ENV["GOOGLE_JSON_KEY_STRING"])
    # google_json_key_location: ENV['GOOGLE_JSON_KEY_LOCATION']
  }
  # config.fog_directory = 'kibab_product_images_storage'
  config.fog_directory = Rails.application.secrets.google_cloud_storage_bucket_name
end
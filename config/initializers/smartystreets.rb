require '../lib/smartystreets_ruby_sdk/static_credentials'
require '../lib/smartystreets_ruby_sdk/shared_credentials'
require '../lib/smartystreets_ruby_sdk/client_builder'
require '../lib/smartystreets_ruby_sdk/us_street/lookup'
require '../lib/smartystreets_ruby_sdk/us_street/match_type'

SmartyStreetsConfig = OpenStruct.new(
  key: ENV['SMARTY_CLIENT_KEY'],
  referer: 'localhost'
)
SmartyStreetsConfig.credentials = SmartyStreets::SharedCredentials.new(SmartyStreetsConfig.key, SmartyStreetsConfig.referer)
SmartyStreetsConfig.client = SmartyStreets::ClientBuilder.new(SmartyStreetsConfig.credentials).with_licenses(['us-core-cloud']).build_us_street_api_client

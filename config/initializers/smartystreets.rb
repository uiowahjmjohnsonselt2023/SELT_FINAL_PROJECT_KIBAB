
SmartyStreetsConfig = OpenStruct.new(
  key: ENV['SMARTY_CLIENT_KEY'],
  referer: 'localhost'
)
SmartyStreetsConfig.credentials = SmartyStreets::SharedCredentials.new(SmartyStreetsConfig.key, SmartyStreetsConfig.referer)
SmartyStreetsConfig.client = SmartyStreets::ClientBuilder.new(SmartyStreetsConfig.credentials).with_licenses(['us-core-cloud']).build_us_street_api_client
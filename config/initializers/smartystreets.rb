
SmartyStreetsConfig = OpenStruct.new(
  key: ENV['SMARTY_CLIENT_KEY'],
  referer: ENV['SMARTY_CLIENT_HOST']
)
SmartyStreetsConfig.credentials = SmartyStreets::SharedCredentials.new(SmartyStreetsConfig.key, SmartyStreetsConfig.referer)
SmartyStreetsConfig.client = SmartyStreets::ClientBuilder.new(SmartyStreetsConfig.credentials).with_licenses(['us-core-cloud']).build_us_street_api_client

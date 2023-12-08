
SmartyStreetsConfig = OpenStruct.new(
  #key: ENV['SMARTY_CLIENT_KEY'],
  #referer: ENV['SMARTY_CLIENT_HOST']
  id: ENV['SMARTY_AUTH_ID'],
  token: ENV['SMARTY_AUTH_TOKEN']
)
#SmartyStreetsConfig.credentials = SmartyStreets::SharedCredentials.new(SmartyStreetsConfig.key, SmartyStreetsConfig.referer)
SmartyStreetsConfig.credentials = SmartyStreets::StaticCredentials.new(SmartyStreetsConfig.id, SmartyStreetsConfig.token)
SmartyStreetsConfig.client = SmartyStreets::ClientBuilder.new(SmartyStreetsConfig.credentials).with_licenses(['us-core-cloud']).build_us_street_api_client

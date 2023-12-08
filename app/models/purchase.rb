class Purchase < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  def self.valid_address(city,state,address,zip)
    run_it = true
    if run_it
      client = SmartyStreetsConfig.client
      lookup = SmartyStreets::USStreet::Lookup.new
      lookup.street = address
      lookup.state = state
      lookup.city = city
      lookup.zipcode = zip
      lookup.candidates = 1
      lookup.match = SmartyStreets::USStreet::MatchType::STRICT
      begin
        client.send_lookup(lookup)
      rescue SmartyStreets::SmartyError => err
        result = "Got the error" + err.to_s
        return result
      end
      result = lookup.result
      if result.empty?
        false
      else
        lat = result[0].metadata.latitude
        long = result[0].metadata.longitude
        maps_hash = {:lat => lat, :long => long}
        return maps_hash
      end
    else
      maps_hash = {:lat => 0.0, :long => 0.0}
      return maps_hash
    end
  end
end

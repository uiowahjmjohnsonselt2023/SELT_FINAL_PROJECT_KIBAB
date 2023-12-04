class Purchase < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  def self.valid_address(city,state,address,zip)
    run_it = false
    if run_it
      client = SmartyStreetsConfig.client
      lookup = SmartyStreets::USStreet::Lookup.new
      lookup.street = address
      lookup.state = state
      lookup.city = city
      lookup.zipcode = zip
      lookup.candidates = 3
      lookup.match = SmartyStreets::USStreet::MatchType::STRICT
      begin
        client.send_lookup(lookup)
      rescue SmartyStreets::SmartyError => err
        result = "Got the error" + err.to_s
        return result
      end
      if lookup.result.empty?
        false
      else
        true
      end
    else
      true
    end
   end
end

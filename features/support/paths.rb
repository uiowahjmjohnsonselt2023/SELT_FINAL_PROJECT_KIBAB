module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the (Kibab )?home\s?page$/ then '/products'
    when /^the (Kibab )?login\s?page$/ then '/login'
    when /^the (Kibab )?products page$/ then '/products'
    when /^the (Kibab )?about page$/ then '/about'
    when /^the (Kibab )?Create Account page?$/ then '/users/new'
    when /^the (Kibab )?Shopping Cart page?$/ then '/shoppingCart'
    when /^the (Kibab )?Checkout page?$/ then '/shoppingCart'


    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
                "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)

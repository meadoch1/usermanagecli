### UTILITY METHODS ###
require 'rest-client'
require 'json'

def check_website
  @url = "http://localhost:3000"
  @checked_website ||= false
  unless @checked_website
    values = JSON.parse RestClient.get( "#{@url}/users.json")
    raise(RuntimeError, "The test server is not configured with test data") unless values.length == 3
    @checked_website = true
  end
end

Given(/^I am an administrator$/) do
  # Since security isn't built into this, nothing to do here
end

Given(/^I have the address of a running usermanage server$/) do
  check_website
end



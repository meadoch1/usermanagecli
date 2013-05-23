require 'rest-client'
require 'json'
require_relative 'format/table'

module Usermanagecli
  class User 
    def self.list_users(url)
      values = JSON.parse RestClient.get( "#{url}/users.json")
      formatter = Format::Table.new
      values.each do |user|
        formatter.format user
      end
      formatter.to_s
    end

    def self.set_roles(url, user_id, role_args)
      params = {id: user_id}
      role_args.each do |role_arg|
        role, value = role_arg.split(':')
        unless %w[admin supervisor csr].include?(role)
          STDERR.puts "Error: The only valid roles are admin, supervisor, or csr"
          exit 1
        end
        params[role] = (value == "true" ? "1" : "0")
      end
      RestClient.put( "#{url}/users/#{user_id}.json", JSON.dump(params), {content_type: 'application/json'})
      "Role(s) successfully updated"
      
    end

    def self.set_password(url, user_id, args)
      unless args.length == 2
        STDERR.puts "Error: You must supply both a password and a confirmation password which match"
        exit
      end
      unless args[0] == args[1]
        STDERR.puts "Error: The password and confirmation password did not match"
        exit
      end

      params = {id: user_id, password: args[0], password_confirmation: args[1]}
      RestClient.put( "#{url}/users/#{user_id}/password.json", JSON.dump(params), {content_type: 'application/json'})
      "Password successfully updated"
    end
    
  end
end

    

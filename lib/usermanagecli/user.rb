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
      
      role_args.each do |role_arg|
        role, value = role_arg.split(':')
        STDERR.puts "Error: The only valid roles are admin, supervisor, or csr" unless %w[admin supervisor csr].include?(role)
        RestClient.put( "#{url}/users/#{user_id}.json", JSON.dump({id: user_id, "#{role}" => value}), {content_type: 'json'})
      end
      "Role(s) successfully updated"
      
    end
    
  end
end

    

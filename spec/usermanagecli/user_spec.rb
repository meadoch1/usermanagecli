require 'spec_helper'

module Usermanagecli
    
  describe User do
#    let(:url) { "http://foo.com" }
    let(:url) { "http://localhost:3000" }
    describe 'list_users' do
      context "with no results returned" do
        it do
          RestClient.should_receive(:get).with("#{url}/users.json").and_return("[]")
          User.list_users(url).should ==
            """+----+----------+------+-------+------------+-----+
| id | username | name | admin | supervisor | csr |
+----+----------+------+-------+------------+-----+
+----+----------+------+-------+------------+-----+"""
        end
      end
      
      
      context "with an array of two users" do
        let(:result) { '[{"id":1,"username":"user1","name":"User One","admin":true,"supervisor":null, "csr":null},{"id":2,"username":"user2","name":"User Two","admin":null,"supervisor":true,"csr":true}]' }

        it do
          RestClient.should_receive(:get).with("#{url}/users.json").and_return(result)
          User.list_users(url).should ==
            """+----+----------+----------+-------+------------+-----+
| id | username | name     | admin | supervisor | csr |
+----+----------+----------+-------+------------+-----+
| 1  | user1    | User One | *     |            |     |
| 2  | user2    | User Two |       | *          | *   |
+----+----------+----------+-------+------------+-----+"""
        end
      end
    end

    describe 'set_role' do
      let(:user_id) { 1 }
      let(:role_args) { ["admin:true"] }
      context "setting a single role value" do
        it do
#          RestClient::Request.should_receive(:execute).with(:method => :put, :url => "#{url}/users/#{user_id}.json", :payload => "{\"id\":1,\"admin\":\"true\"}", :headers => {:content_type => 'json'})
          User.set_roles(url, user_id, role_args).should == "Role(s) successfully updated"
        end
        
      end
    
    end
    
  end
end
